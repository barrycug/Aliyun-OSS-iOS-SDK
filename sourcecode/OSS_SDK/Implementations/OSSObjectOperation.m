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
#import "OSSObjectOperation.h"
#import "ObjectMetadata.h"
#import "OSSUtils.h"
#import "OSSErrorCode.h"
#import "ResponseMessage.h"
#import "ResponseParser.h"
#import "PutObjectResult.h"
#import "FetchObjectRequest.h"
#import "DateUtil.h"
#import "OSSObject.h"
#import "CopyObjectRequest.h"
#import "GHNSString+Utils.h"
#import "GHNSData+Base64.h"
#import "DeleteObjectsResult.h"
@interface OSSObjectOperation()
-(void) sendInvalidBucketNameError:(NSString *) method;
-(void) sendInvalidKeyError:(NSString *) method;
-(void) sendInvalidNetWorkError;
-(void)invoke:(HttpMethod) httpMethod buckName:(NSString*) buckName objectName:(NSString*)objectName headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params content:(NSData*)content contentLength:(long) contentLength  userInfo:(NSDictionary*)userInfo;
-(void) sendFailedMessage:(ResponseMessage*) rm;
-(void) sendFinishedMessage:(ResponseMessage*) rm;
-(NSString*) joinETag:(NSMutableArray*) arrayList;
@end
@implementation OSSObjectOperation
@synthesize delegate;
-(void) sendInvalidBucketNameError:(NSString *) method
{
    NSString * errorCode = [OSSErrorCode OSSErrorCodeToString: OSSErrorCodeType_INVALID_BUCKET_NAME];
    OSSError * error = [OSSError OSSErrorWithErrorCode:errorCode
                                               message:@"" 
                                     stringToSignBytes:@"" 
                                     signatureProvided:@"" 
                                          stringToSign:@"" 
                                        ossAccessKeyId:@"" 
                                             requestId:@"" 
                                                hostId:@""]; 
    if ([method isEqualToString:@"putObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationPutObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationPutObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"fetchObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationFetchObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"fetchObjectMetadata"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectMetadataFailed:error:)]) {
            
            [self.delegate OSSObjectOperationFetchObjectMetadataFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"copyObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationCopyObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationCopyObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"deleteObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationDeleteObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"deleteMultipleObjects"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteMultipleObjectsFailed:error:)]) {
            
            [self.delegate OSSObjectOperationDeleteMultipleObjectsFailed:self error:error];
        }
    }
    
}
-(void) sendInvalidKeyError:(NSString *) method
{
    NSString * errorCode = [OSSErrorCode OSSErrorCodeToString: OSSErrorCodeType_INVALIED];
    OSSError * error = [OSSError OSSErrorWithErrorCode:errorCode
                                               message:@"" 
                                     stringToSignBytes:@"" 
                                     signatureProvided:@"" 
                                          stringToSign:@"" 
                                        ossAccessKeyId:@"" 
                                             requestId:@"" 
                                                hostId:@""];  
    [self.delegate OSSObjectOperationPutObjectFailed:self error:error];
    if ([method isEqualToString:@"putObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationPutObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationPutObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"fetchObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationFetchObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"fetchObjectMetadata"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectMetadataFailed:error:)]) {
            
            [self.delegate OSSObjectOperationFetchObjectMetadataFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"copyObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationCopyObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationCopyObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"deleteObject"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteObjectFailed:error:)]) {
            
            [self.delegate OSSObjectOperationDeleteObjectFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"deleteMultipleObjects"]) {
        if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteMultipleObjectsFailed:error:)]) {
            
            [self.delegate OSSObjectOperationDeleteMultipleObjectsFailed:self error:error];
        }
    }
}

-(void) putObject:(NSString*) bucketName 
                            key: (NSString*) key 
                           data:(NSData*) data  
                 objectMetadata:(ObjectMetadata*) objectMetadata
{
    NSAssert(!(bucketName == nil),@"bucketName nil");
    NSAssert(!(key == nil),@"key nil");
  //  NSAssert(!(data == nil),@"data nil");
    NSAssert(!(objectMetadata == nil),@"objectMetadata nil");
    BOOL isVaildBucketName = [OSSUtils validateBucketName:bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"putObject"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"putObject"];
        return;
    }
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:10];
    [OSSUtils populateRequestMetadata:headers objectMetadata:objectMetadata];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"key",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"putObject",key, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];

    [self invoke:HttpMethod_PUT buckName:bucketName objectName:key headers:headers params:nil content:data contentLength:[data length] userInfo:userInfo];
    [headers release];
}
-(void)fetchObject:(NSString*) bucketName key: (NSString*) key 
{
    BOOL isVaildBucketName = [OSSUtils validateBucketName:bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"fetchObject"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"fetchObject"];
        return;
    }
    FetchObjectRequest * fetchObjectRequest = [[FetchObjectRequest alloc] initWithBucketName:bucketName key:key];
    [self  fetchObject:fetchObjectRequest];
    [fetchObjectRequest release];

}
-(void)fetchObject:(FetchObjectRequest*)  fetchObjectRequest
{
    [self fetchObject:fetchObjectRequest file:@""];
}
-(void)fetchObject:(FetchObjectRequest *)  fetchObjectRequest  file:(NSString*) filePath
{
    NSAssert(!(fetchObjectRequest == nil),@"fetchObjectRequest nil");
    BOOL isVaildBucketName = [OSSUtils validateBucketName:fetchObjectRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:fetchObjectRequest.key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"fetchObject"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"fetchObject"];
        return;
    }
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSRange rang = fetchObjectRequest.rang;
    if (!(rang.location == 0 && rang.length == 0))
    {
        NSString * strRange = [NSString stringWithFormat:@"bytes=%ld-%ld",rang.location,rang.location+rang.length];
        [headers setObject:strRange forKey:@"Range"];
    }
    if (fetchObjectRequest.modifiedSinceConstraint != nil) {
        [headers setObject:[DateUtil formatRfc822Date:fetchObjectRequest.modifiedSinceConstraint] forKey:@"If-Modified-Since"];
    }
    if (fetchObjectRequest.unmodifiedSinceConstraint != nil) {
        [headers setObject:[DateUtil formatRfc822Date:fetchObjectRequest.unmodifiedSinceConstraint] forKey:@"If-Unmodified-Since"];
    }
    if ([fetchObjectRequest.matchingETagConstraints count] >0) {
        [headers setObject:[self joinETag:fetchObjectRequest.matchingETagConstraints] forKey:@"If-Match"];
    }
    if ([fetchObjectRequest.nonmatchingEtagConstraints count] >0) {
        [headers setObject:[self joinETag:fetchObjectRequest.nonmatchingEtagConstraints] forKey:@"If-None-Match"];
    }
    OrderedDictionary * params =[OSSUtils getResponseHeaderParameters:fetchObjectRequest.responseHeaders];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName",@"key",@"filePath",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"fetchObject",fetchObjectRequest.bucketName,fetchObjectRequest.key,filePath, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_GET buckName:fetchObjectRequest.bucketName objectName:fetchObjectRequest.key headers:headers params:params content:nil contentLength:0 userInfo:userInfo];
    [headers release];
}
-(void) fetchObjectMetadata:(NSString*) bucketName key: (NSString*) key 
{
    NSAssert(!(bucketName == nil),@"bucketName nil");
    NSAssert(!(key == nil),@"key nil");
    BOOL isVaildBucketName = [OSSUtils validateBucketName:bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"fetchObjectMetadata"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"fetchObjectMetadata"];
        return;
    }
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"fetchObjectMetadata", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    
    [self invoke:HttpMethod_HEAD buckName:bucketName objectName:key headers:nil params:nil content:nil contentLength:0 userInfo:userInfo];
}
-(void) copyObject:(CopyObjectRequest*)copyObjectRequest
{
    NSAssert(!(copyObjectRequest==nil),@"copyObjectRequest == nil");
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:5]; 
    [self populateCopyObjectHeaders:copyObjectRequest headers:headers];
    [headers removeObjectForKey:@"Content-Length"];

    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"copyObject", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    
    [self invoke:HttpMethod_PUT buckName:copyObjectRequest.destinationBucketName objectName:copyObjectRequest.destinationKey headers:headers params:nil content:nil contentLength:0 userInfo:userInfo];
    [headers release];
}
-(void) populateCopyObjectHeaders:(CopyObjectRequest*) copyObjectRequest headers:(NSMutableDictionary *) headers
{
    NSMutableString * str =[[NSMutableString alloc] initWithCapacity:100];
    [str appendString:@"/"];
    [str appendString:copyObjectRequest.sourceBucketName];
    [str appendString:@"/"];
    [str appendString:copyObjectRequest.sourceKey];
    [headers setObject:str forKey:@"x-oss-copy-source"];
    [str release];
    [OSSUtils addDateHeader:headers key:@"x-oss-copy-source-if-modified-since" value:copyObjectRequest.modifiedSinceConstraint];
     [OSSUtils addDateHeader:headers key:@"x-oss-copy-source-if-unmodified-since" value:copyObjectRequest.unmodifiedSinceConstraint];

    [OSSUtils addListHeader:headers key:@"x-oss-copy-source-if-match" value:copyObjectRequest.matchingETagConstraints];
    [OSSUtils addListHeader:headers key:@"x-oss-copy-source-if-none-match" value:copyObjectRequest.nonmatchingEtagConstraints];
    ObjectMetadata *objectMetadata = copyObjectRequest.aNewObjectMetadata;
    if (objectMetadata != nil)
    {
        [headers setObject:@"REPLACE" forKey:@"x-oss-metadata-directiv"];
        [OSSUtils populateRequestMetadata:headers  objectMetadata: objectMetadata];
    }
}
-(void)deleteObject:(NSString*) bucketName key: (NSString*) key
{
    NSAssert(!(bucketName == nil),@"bucketName nil");
    NSAssert(!(key == nil),@"key nil");
    BOOL isVaildBucketName = [OSSUtils validateBucketName:bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"deleteObject"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"deleteObject"];
        return;
    }
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName",@"key",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"deleteObject",bucketName,key, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_DELETE buckName:bucketName objectName:key headers:nil params:nil content:nil contentLength:0 userInfo:userInfo];
}
-(void)deleteMultipleObjects:(NSString*) bucketName objectNames:(NSArray*)objectNames isQuiet:(BOOL)isQuiet
{
    NSAssert(!(bucketName == nil),@"bucketName nil");
    NSAssert(!(objectNames == nil),@"key nil");
    BOOL isVaildBucketName = [OSSUtils validateBucketName:bucketName];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"deleteMultipleObjects"];
        return;
    }
    OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1]; 
    [params setObject:@"" forKey:@"delete"];
    NSMutableArray * vaildObjNames = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSString * strObjName in objectNames)
    {
        BOOL isVaildBucketKey = [OSSUtils validateObjectKey:strObjName];
   
        if (!isVaildBucketKey) {
         //   [self sendInvalidKeyError:@"deleteMultipleObjects"];
            continue;
        }
        [vaildObjNames addObject:strObjName];
        
    }
    NSString * strXMLContent = [self makeDeleteObjectsXMLContent:vaildObjNames isQuiet:isQuiet];
    [vaildObjNames release];
    NSString * strBase64 = [[strXMLContent gh_MD5Data] gh_base64];
 //   NSString * strBase64 = [[strMD5 dataUsingEncoding:NSUTF8StringEncoding] gh_base64];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:5]; 
    [headers setObject:strBase64 forKey:@"Content-MD5"];
    NSData * content = [strXMLContent dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName",@"objectNames",@"isQuiet",nil];
    
    NSArray *objs = [NSArray arrayWithObjects:@"deleteMultipleObjects",bucketName,objectNames,[NSNumber numberWithBool:isQuiet], nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_POST buckName:bucketName objectName:nil headers:headers params:params content: content contentLength:[content length] userInfo:userInfo];
    [headers release];
    [params release];
}
-(NSString *) makeDeleteObjectsXMLContent:(NSMutableArray*)objectNames isQuiet:(BOOL)isQuiet
{
    NSMutableString * returnString = [[NSMutableString alloc] initWithCapacity:100];
    [returnString appendString:@"<Delete>"];
    [returnString appendString:@"<Quiet>"];
    if (isQuiet) {
        [returnString appendString:@"true"];
    }
    else {
        [returnString appendString:@"false"];
    }
    [returnString appendString:@"</Quiet>"];
    for (NSString * key in objectNames) {
        [returnString appendString:@"<Object>"];
        [returnString appendString:@"<Key>"];
        [returnString appendString:key];
        [returnString appendString:@"</Key>"];
        [returnString appendString:@"</Object>"];
    }
    
    [returnString appendString:@"</Delete>"];
    return [returnString autorelease];
}
-(NSString*) joinETag:(NSMutableArray*) arrayList
{
    NSMutableString * rtnString = [[NSMutableString alloc] initWithCapacity:50];
    int i = 1;
    for (NSString * str in arrayList) {
        if (i==0) {
            [rtnString appendString:@","]; 
        }
        [rtnString appendString:str];
        i=0;
    }
    return [rtnString autorelease];
}
-(void) sendFinishedMessage:(ResponseMessage*) rm
{
    NSString * strMethod = nil;
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        strMethod = [rm.userInfo objectForKey:@"method"];
        // createBucket finish
        if([strMethod isEqualToString:@"putObject"] )
        {
            NSString * strETag = [rm.headers objectForKey:@"Etag"];
            strETag =[OSSUtils trimQuotes:strETag];
            NSString *strKey = [rm.userInfo objectForKey:@"key"];
            PutObjectResult * por =[PutObjectResult PutObjectResultWithETag:strETag andKey:strKey];
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationPutObjectFinish:result:)]) 
            {            
                [self.delegate OSSObjectOperationPutObjectFinish:self result:por];
            }
        }
        if([strMethod isEqualToString:@"fetchObject"] )
        {
            NSString *strKey = [rm.userInfo objectForKey:@"key"];
            NSString *strBucketName = [rm.userInfo objectForKey:@"bucketName"];
            NSString *strFilePath = [rm.userInfo objectForKey:@"filePath"];
            OSSObject *ossObj = [[[OSSObject alloc] initWithKey:strKey bucketName:strBucketName metadata:[ResponseParser parserObjectMetadata:rm.headers ] objectContent:rm.content ] autorelease];
            if (![strFilePath isEqualToString:@""]) {
              BOOL isWrited =   [rm.content writeToFile:strFilePath atomically:YES];
                if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectAndWriteToFileFinish:result: isWritedToFile:)]) 
                {            
                    [self.delegate OSSObjectOperationFetchObjectAndWriteToFileFinish:self result:ossObj isWritedToFile:isWrited];
                }

            }
            else {
                if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectFinish:result:)]) 
                {            
                    [self.delegate OSSObjectOperationFetchObjectFinish:self result:ossObj];
                }
            }
        }
        if([strMethod isEqualToString:@"fetchObjectMetadata"] )
        {
            ObjectMetadata * objMetadata = [ResponseParser parserObjectMetadata:rm.headers ];
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectMetadataFinish:result:)]) 
            {            
                [self.delegate OSSObjectOperationFetchObjectMetadataFinish:self result:objMetadata];
            }
        }
        if([strMethod isEqualToString:@"copyObject"] )
        {
            CopyObjectResult * cor = [ResponseParser parseCopyObjectResult:rm.content];
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationCopyObjectFinish:result:)]) 
            {            
                [self.delegate OSSObjectOperationCopyObjectFinish:self result:cor];
            }
        }
        if([strMethod isEqualToString:@"deleteObject"] )
        {
            NSString *strKey1 = [rm.userInfo objectForKey:@"key"];
            NSString *strBucketName1 = [rm.userInfo objectForKey:@"bucketName"];
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteObjectFinish:bucketName:key:)]) 
            {            
                [self.delegate OSSObjectOperationDeleteObjectFinish:self bucketName:strBucketName1 key:strKey1];
            }
        }
        if([strMethod isEqualToString:@"deleteMultipleObjects"] )
        {
            NSString *strBucketName1 = [rm.userInfo objectForKey:@"bucketName"];
            NSArray  *objectNames = [rm.userInfo objectForKey:@"objectNames"];
            NSNumber * num =[rm.userInfo objectForKey:@"isQuiet"] ;
            BOOL isQuiet = [num boolValue];
            /*
            -(void)OSSObjectOperationDeleteMultipleObjectsFinish:(OSSObjectOperation*) ossObjectOperation result:(DeleteResult*) result;
            -(void)OSSObjectOperationDeleteMultipleObjectsFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;
             */
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteMultipleObjectsFinish:bucketName:result:)]) 
            {     
                DeleteObjectsResult * dr = nil;
                if (!isQuiet) {
                    dr = [[[DeleteObjectsResult alloc ]initWithXMLData: rm.content] autorelease];
                }
                else {
                    dr =  [[[DeleteObjectsResult alloc ] initWithObjects:objectNames] autorelease];
                }
                [self.delegate OSSObjectOperationDeleteMultipleObjectsFinish:self bucketName:strBucketName1 result:dr];
            }
        }
    }
}
-(void) sendFailedMessage:(ResponseMessage*) rm
{
    OSSError * error = [OSSError OSSErrorWithData:rm.content]; 
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        NSString * strMethod = [rm.userInfo objectForKey:@"method"];
        // createBucket Failed
        if ([strMethod isEqualToString:@"putObject"])
        {
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationPutObjectFailed:error:)]) 
            {
                [self.delegate OSSObjectOperationPutObjectFailed:self error:error];                
            }
        }
         // fetchObject Failed
        if([strMethod isEqualToString:@"fetchObject"] )
        {
             NSString *strFilePath = [rm.userInfo objectForKey:@"filePath"];
            if (![strFilePath isEqualToString:@""]) 
            {
                if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectAndWriteToFileFailed:error:)]) 
                {
                    [self.delegate OSSObjectOperationFetchObjectAndWriteToFileFailed:self error:error];                
                }
            }
            else 
            {
                if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectFailed:error:)]) 
                {
                    [self.delegate OSSObjectOperationFetchObjectFailed:self error:error];
                }
            }
        }
        if([strMethod isEqualToString:@"fetchObjectMetadata"] )
        {
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationFetchObjectMetadataFailed:error:)]) 
            {            
                [self.delegate OSSObjectOperationFetchObjectMetadataFailed:self error:error];
            }
        }
        if([strMethod isEqualToString:@"copyObject"] )
        {
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationCopyObjectFailed:error:)]) 
            {            
                [self.delegate OSSObjectOperationCopyObjectFailed:self error:error];
            }
        }
        if([strMethod isEqualToString:@"deleteObject"] )
        {
            if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteObjectFailed:error:)]) 
            {            
                [self.delegate OSSObjectOperationDeleteObjectFailed:self error:error];
            }
        }
         if([strMethod isEqualToString:@"deleteMultipleObjects"] )
         {
             if ([self.delegate respondsToSelector:@selector(OSSObjectOperationDeleteMultipleObjectsFailed:error:)]) 
             {            
                 [self.delegate OSSObjectOperationDeleteMultipleObjectsFailed:self error:error];
             }
         }

    }
}

-(void)serviceClientRequestFinished:(DefaultServiceClient*)defaultServiceClient result:(id) result
{
    [super serviceClientRequestFinished:defaultServiceClient result:result];
    if([result isKindOfClass:[ResponseMessage  class]])
    {
        ResponseMessage * rm = (ResponseMessage*) result;
        
        //successed
        if ([rm isSuccessful]) 
        {
            [self sendFinishedMessage:rm];
        }
        // failed
        else 
        {
            [self sendFailedMessage:rm];
        }
    }
    // other failed
    else {
        
        [self sendInvalidNetWorkError];
    }
    
    
}
-(void)serviceClientRequestFailed:(DefaultServiceClient*)defaultServiceClient error:(id) error
{
    [super serviceClientRequestFailed:defaultServiceClient error:error];
    [self sendInvalidNetWorkError];
}
-(void) sendInvalidNetWorkError
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectOperationNetWorkFailed:error:)]) 
    {
        NSString * errorCode = [OSSErrorCode OSSErrorCodeToString: OSSErrorCodeType_INVALIED];
        OSSError * error = [OSSError OSSErrorWithErrorCode:errorCode
                                                   message:@"" 
                                         stringToSignBytes:@"" 
                                         signatureProvided:@"" 
                                              stringToSign:@"" 
                                            ossAccessKeyId:@"" 
                                                 requestId:@"" 
                                                    hostId:@""];  
        [self.delegate OSSObjectOperationNetWorkFailed:self error:error];
        
    }  
}
-(void)invoke:(HttpMethod) httpMethod buckName:(NSString*) buckName objectName:(NSString*)objectName headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params content:(NSData*)content contentLength:(long) contentLength  userInfo:(NSDictionary*)userInfo
{
    NSAssert(!(5368709120L <= contentLength),@"content too large ");
    [self request: httpMethod 
         buckName: buckName 
       objectName: objectName 
          headers: headers   
           params: params
          content: content  
    contentLength: contentLength
         userInfo:userInfo];
}
@end
