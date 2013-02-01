/*
 Copyright 2012 baocai zhang. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE FREEBSD PROJECT ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE FREEBSD PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.
 */
/*
 @author baocai zhang
 website:www.giser.net
 email:zhangbaocaicug@gmail.com
 */

#import "OSSUtils.h"
#import "HttpUtil.h"
#import "NSString+Starts.h"
#import "ObjectMetadata.h"
#import "DateUtil.h"
#import "ResponseHeaderOverrides.h"


@implementation OSSUtils
+(NSString*)DEFAULT_OBJECT_CONTENT_TYPE
{
    return @"application/octet-stream";
}
+(BOOL)validateBucketName:(NSString* )bucketName
{
    if (bucketName == nil)
    {
        return NO;
    }
    NSString * regex        = @"^[a-z0-9][a-z0-9_\\-]{2,254}$";  
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];  
    BOOL isMatch            = [pred evaluateWithObject:bucketName]; 
    return isMatch ;
}
+(BOOL)validateObjectKey:(NSString*) key
{
    if (key == nil)
    {
        return NO;
    }
    long len = strlen([key cStringUsingEncoding:NSUTF8StringEncoding]);
    return ((len>0) && (len< 1024));
}
+(NSString *) urlEncodeKey:(NSString *)s
{
    NSAssert(!(s==nil),@"urlEncodeKey s nil");
    NSArray * stringArray = [s componentsSeparatedByString:@"/"];
    NSMutableString * returnString = [[NSMutableString alloc] initWithCapacity:100];
    if ([stringArray count] > 0) {
        [returnString appendString:[HttpUtil urlEncode:[stringArray objectAtIndex:0] encoding:NSUTF8StringEncoding]];
        for (int j = 1; j<[stringArray count]; j++) {
            [returnString appendString:@"/"];
            [returnString appendString:[HttpUtil urlEncode:[stringArray objectAtIndex:j] encoding:NSUTF8StringEncoding]];
        }
        /*
        if ([s endsWith:@"/"] ) {
            for (int i = [s length] -1; i>=0 && [s characterAtIndex:i] =='/'; i--) {
                [returnString appendString:@"/"];
            }
        }
         */
    }
    return [returnString autorelease];
}
+(NSString*) makeResourcePath:(NSString*) buckeName objectName:(NSString*) objectName
{
    NSMutableString * returnString=[[NSMutableString alloc] initWithCapacity:200];
    if (buckeName != nil)
    {
        [returnString appendString:buckeName];
        if (objectName!= nil) {
            [returnString appendString:@"/"];
            [returnString appendString:[OSSUtils urlEncodeKey:objectName]];
        }
        else {
            [returnString appendString:@""];
        }
    }
    
    return [returnString autorelease];
}
+(void)populateRequestMetadata:(NSMutableDictionary *) dict  objectMetadata:(ObjectMetadata *)objectMetadata
{
    NSMutableDictionary * metaDataDict = objectMetadata.metadata;
    BOOL isHaveContentType = NO;
     NSString * strCType =[[NSString stringWithString:@"Content-Type"] lowercaseString];
    if (metaDataDict != nil)
    {
        NSEnumerator * enumerator = [metaDataDict keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) 
        {
            NSString * strKey = (NSString*)key;
           
            if ([[strKey lowercaseString] isEqualToString:strCType]) {
                isHaveContentType = YES;
            }
            [dict setObject:[metaDataDict objectForKey:key] forKey:key];
        }
        if (!isHaveContentType)
        {
            [dict setObject:@"application/octet-stream" forKey:@"Content-Type"];
        }
       
    }
       
    NSMutableDictionary * userMetaDataDict = objectMetadata.userMetadata;
  
    if (userMetaDataDict != nil)
    {
        NSEnumerator * enumerator = [userMetaDataDict keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) 
        {
            NSString * strKey = (NSString*)key;  
            NSString * strValue = [metaDataDict objectForKey:key];
            [strKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (strValue != nil) {
                 [strValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            NSString * str = [NSString stringWithFormat:@"x-oss-meta-%@",strKey];
           
            [dict setObject:strValue forKey:str];
        }
    }
}
+(void) addDateHeader:(NSMutableDictionary *) headers key:(NSString*) key value:(NSDate*)  date
{
    if (date != nil)
    {
        [headers setObject:[DateUtil formatRfc822Date:date] forKey:key];
    }
}
+(void) addListHeader:(NSMutableDictionary *) headers key:(NSString*)key value:(NSArray*)  list
{
    if (list != nil)
    {
        NSMutableString * string = [[NSMutableString alloc] initWithCapacity:100];

        int i = 1;
        for (NSString * strValue in list) {
            if (i== 0) {
                [string appendString:@", "];
            }
            [string appendString:strValue];
            i=0;
        }
        [headers setObject:string forKey:key];
        [string release];
    }
}
+(NSString*) trimQuotes:(NSString *)string
{
    if (string == nil)
    {
        return nil;
    }
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string startsWith:@"\""])
    {
        string = [string substringFromIndex:1];
    }
    if ([string endsWith:@"\""])
    {
        string = [string substringToIndex:[string length] -1];
    }
    return string;
}
+(OrderedDictionary*) getResponseHeaderParameters:(ResponseHeaderOverrides*)responseHeaderOverrides
{
    OrderedDictionary * dict = [[OrderedDictionary alloc] initWithCapacity:10];

    if (responseHeaderOverrides != nil)
    {
        if (responseHeaderOverrides.cacheControl != nil)
        {
            [dict setObject:responseHeaderOverrides.cacheControl forKey:@"response-cache-control"];
        }
        if (responseHeaderOverrides.contentDisposition != nil)
        {
            [dict setObject:responseHeaderOverrides.contentDisposition forKey:@"response-content-disposition"];
        }
        if (responseHeaderOverrides.contentEncoding != nil)
        {
            [dict setObject:responseHeaderOverrides.contentEncoding forKey:@"response-content-encoding"];
        }
        if (responseHeaderOverrides.contentLangauge != nil)
        {
            [dict setObject:responseHeaderOverrides.contentLangauge forKey:@"response-content-language"];
        }
        if (responseHeaderOverrides.contentType != nil)
        {
            [dict setObject:responseHeaderOverrides.contentType forKey:@"response-content-type"];
        }
        if (responseHeaderOverrides.expires != nil)
        {
            [dict setObject:responseHeaderOverrides.expires forKey:@"response-expires"];
        }
        
    }
    return [dict autorelease];
}
+(NSString*) HttpMethod2String:(HttpMethod) httpMethod
{
    NSString * rtnString = @"";
    switch (httpMethod) 
    {
        case HttpMethod_DELETE:
            rtnString = @"DELETE";
            break;
        case HttpMethod_GET:
            rtnString = @"GET";
            break;
        case HttpMethod_HEAD:
            rtnString = @"HEAD";
            break;
        case HttpMethod_POST:
            rtnString = @"POST";
            break;
        case HttpMethod_PUT:
            rtnString = @"PUT";
            break;
        default:
            break;
    }
    return rtnString;
}

@end
