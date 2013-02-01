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
#import "ResponseParser.h"
#import "OSSError.h"
#import "Bucket.h"
#import "NSArray+Bucketlist.h"
#import "CannedAccessControlList.h"
#import "ObjectListing.h"
#import "PutObjectResult.h"
#import "ObjectMetadata.h"
#import "DateUtil.h"
#import "OSSUtils.h"
#import "CopyObjectResult.h"
#import "CompleteMultipartUploadResult.h"
#import "InitiateMultipartUploadResult.h"
#import "MultipartUploadListing.h"
#import "PartListing.h"
#import "PostObjectGroupResult.h"
#import "FetchObjectGroupIndexResult.h"
@implementation ResponseParser
+(OSSError *) parserOSSError:(NSData*) data
{
    if (data != nil) 
    {
        OSSError * error = [[OSSError alloc] initWithData:data];
        return [error autorelease];
    }
    else 
    {
        return nil;
    }
   
}
+(NSArray *) parserBucklist:(NSData*) data
{
    if (data != nil) 
    {
        NSArray * array = [[NSArray alloc] initWithBucketListXMLData:data];
        return [array autorelease];
    }
    else 
    {
        return nil;
    }
}
+(CannedAccessControlList*) parserCannedAccessControlList:(NSData*) data
{
    return [[[CannedAccessControlList alloc] initWithXMLData:data] autorelease];
}
+(ObjectListing*)parserObjectListing:(NSData*) data
{
     return [[[ObjectListing alloc] initWithXMLData:data] autorelease];
}
+(ObjectMetadata*)parserObjectMetadata:(NSMutableDictionary*)headers
{
    NSAssert(!(headers == nil),@"headers == nil") ;
    ObjectMetadata *objMetadata =[[ObjectMetadata alloc] init]; 
    NSEnumerator * keyEnumerator = headers.keyEnumerator;
    id key;
    while (key = [keyEnumerator nextObject]) {
        NSString * strKey = (NSString*) key;
        NSString * str;
        NSString * strValue = [headers objectForKey:key];
        NSRange rang = [strKey rangeOfString:@"x-oss-meta-"];
        if (rang.length > 0 ) 
        {
            str = [strKey substringFromIndex:(rang.location+rang.length)];
            [objMetadata addUserMetadata:str value:strValue];
        }
        else if([strKey isEqualToString:@"Last-Modified"]){
            [objMetadata addHeader:strKey value:[DateUtil parseRfc822Date:strValue]];
        }
        else if([strKey isEqualToString:@"Content-Length"]){
            [objMetadata addHeader:strKey value:strValue];
        }
        else if([strKey isEqualToString:@"Etag"]){
            [objMetadata addHeader:strKey value:[OSSUtils trimQuotes:strValue]];
        }
        else {
             [objMetadata addHeader:strKey value:strValue];
        }
    }
    return [objMetadata autorelease];
  
}
+(CopyObjectResult*)parseCopyObjectResult:(NSData*) data
{
    return [[[CopyObjectResult alloc] initWithXMLData:data] autorelease];
}
+(CompleteMultipartUploadResult*)parseCompleteMultipartUpload:(NSData*) data
{
    return [[[CompleteMultipartUploadResult alloc] initWithXMLData:data] autorelease];
}
+(InitiateMultipartUploadResult*)parseInitiateMultipartUpload:(NSData*) data
{
    return [[[InitiateMultipartUploadResult alloc] initWithXMLData:data] autorelease];
}
+(MultipartUploadListing*)parseListMultipartUploads:(NSData*) data
{
    return [[[MultipartUploadListing alloc] initWithXMLData:data] autorelease];
}
+(PartListing*)parsePartList:(NSData*) data
{
    return [[[PartListing alloc] initWithXMLData:data] autorelease];
}
+(PostObjectGroupResult*)parsePostObjectGroupResult:(NSData*) data
{
    return [[[PostObjectGroupResult alloc]initWithXMLData:data] autorelease];
}
+(FetchObjectGroupIndexResult*)parseFetchObjectGroupIndexResult:(NSData*) data
{
    return [[[FetchObjectGroupIndexResult alloc] initWithXMLData:data] autorelease];
}
@end
