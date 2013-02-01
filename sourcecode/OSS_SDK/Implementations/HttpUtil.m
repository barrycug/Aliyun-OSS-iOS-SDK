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
#import "HttpUtil.h"
/*
 NSString * = "iso-8859-1";
 NSString * = "utf-8";
 */
 static HttpUtil *g_httpUtil = nil;
@implementation HttpUtil
-(void) dealloc
{
    [super dealloc];
}
+(id) defaultHttpUtil
{
    if (g_httpUtil == nil) {
        g_httpUtil = [[HttpUtil alloc] init];
    }
    return  g_httpUtil;
}
+(NSString*)ISO_8859_1_CHARSET
{
    return @"iso-8859-1";
}
/*
+(NSString*)JAVA_CHARSET
{
    return @"utf-8";
}
 */
+(NSStringEncoding)ISO_8859_1_CHARSET_OBJC
{
    return NSISOLatin1StringEncoding;
}
/*
+(NSStringEncoding)JAVA_CHARSET_OBJC
{
    return  NSUTF8StringEncoding;
}
 */
+(NSString*) urlEncode:(NSString*) url encoding:(NSStringEncoding) encoding
{ 
    NSString* encodedUrl =
    [url stringByAddingPercentEscapesUsingEncoding:encoding];
    return encodedUrl;
}
+(NSString *)urlEncode:(NSString*) str UsingEncoding:(NSStringEncoding)encoding {

    return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)str,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding)) autorelease];
}
/*
+(NSString*) paramToQueryString:(NSDictionary*) paramDict encoding:(NSStringEncoding) encoding
{
    if ((paramDict == nil) || ([paramDict count] == 0))
    {
        return nil;
    }
    NSMutableString * returnString = [[NSMutableString alloc] initWithCapacity:200];
    int i = 1;
    NSEnumerator *keyEnumerator = paramDict.keyEnumerator;
    id key;
    while ((key = [keyEnumerator nextObject]))   
    {  
        NSString * strKey = (NSString *) key;
        NSString * strValue = [paramDict objectForKey:key];
        if (i==0) {
            [returnString appendString:@"&"];
        }
        [returnString appendString:strKey];
        if (strValue != nil &&(![strValue isEqualToString:@""])) {
            [returnString appendString:@"="];
            [returnString appendString:[HttpUtil urlEncode:strValue encoding:encoding]];
        }
        i=0;
    }
    return [returnString autorelease];
}
*/
+(NSString*) paramToQueryStringOrder:(OrderedDictionary*) paramDict encoding:(NSStringEncoding) encoding
{
    if ((paramDict == nil) || ([paramDict count] == 0))
    {
        return nil;
    }
    NSMutableString * returnString = [[NSMutableString alloc] initWithCapacity:200];
    int i = 1;
    int j = 0;
    for (j = 0;j< [paramDict count] ;j++) {
        id key = [paramDict keyAtIndex:j];
        NSString * strKey = (NSString *) key;
        NSString * strValue = [paramDict objectForKey:key];
        if (i==0) {
            [returnString appendString:@"&"];
        }
        [returnString appendString:strKey];
        if (strValue != nil &&(![strValue isEqualToString:@""])) {
            [returnString appendString:@"="];
            [returnString appendString:[HttpUtil urlEncode:strValue UsingEncoding:encoding]];
            
        }
        i=0;
    }
    return [returnString autorelease];
}

+(NSString*) paramToQueryString:(NSDictionary*) paramDict encoding:(NSStringEncoding) encoding
{
    if ((paramDict == nil) || ([paramDict count] == 0))
    {
        return nil;
    }
    NSMutableString * returnString = [[NSMutableString alloc] initWithCapacity:200];
    int i = 1;
    NSArray *sortArray =[[paramDict allKeys] sortedArrayUsingComparator:^(id a, id b)
                         {
                             return [a compare:b];
                         }];
    for (NSString * key in sortArray) {
        NSString * strKey = (NSString *) key;
        NSString * strValue = [paramDict objectForKey:key];
        if (i==0) {
            [returnString appendString:@"&"];
        }
        [returnString appendString:strKey];
        if (strValue != nil &&(![strValue isEqualToString:@""])) {
            [returnString appendString:@"="];
            [returnString appendString:[HttpUtil urlEncode:strValue UsingEncoding:encoding]];
        }
        i=0;
    }
    return [returnString autorelease];
}
 
+(void)convertHeaderCharsetFromIso88591:(NSMutableDictionary*) paramDict
{
    [HttpUtil convertHeaderCharset:paramDict encodingFrom:NSISOLatin1StringEncoding encodingTo:NSUTF8StringEncoding];
}

+(void)convertHeaderCharsetToIso88591:(NSMutableDictionary*) paramDict
{
    [HttpUtil convertHeaderCharset:paramDict encodingFrom:NSUTF8StringEncoding encodingTo:NSISOLatin1StringEncoding];
}

+(void)convertHeaderCharset:(NSMutableDictionary*) paramDict encodingFrom: (NSStringEncoding) encodingFrom encodingTo: (NSStringEncoding) encodingTo
{
    NSAssert(!(paramDict == nil),@"paramMap nil");
    
    NSMutableDictionary * dict = [paramDict copy];
    NSEnumerator *keyEnumerator = [dict keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject])   
    {  
        NSString * strKey =(NSString*)key;
        NSString * strValue = [dict objectForKey:key];
        NSString *newValue = [NSString stringWithCString:[strValue cStringUsingEncoding:encodingFrom] encoding:encodingTo];
        [paramDict setValue:newValue forKey:strKey];
        
    }
    [dict release];
     
}
@end
