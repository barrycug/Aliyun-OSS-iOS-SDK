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
#import "OSSObjectGroupOperation.h"
#import "ObjectMetadata.h"
#import "OSSUtils.h"
#import "OSSErrorCode.h"
#import "ResponseMessage.h"
#import "ResponseParser.h"
#import "OSSError.h"
#import "ObjectGroupPartETag.h"
#import "PostObjectGroupRequest.h"
#import "PostObjectGroupResult.h"
#import "FetchObjectGroupIndexResult.h"
#import "OrderedDictionary.h"

@interface OSSObjectGroupOperation() 
-(void)invoke:(HttpMethod) httpMethod buckName:(NSString*) buckName objectName:(NSString*)objectName headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params content:(NSData*)content contentLength:(long) contentLength  userInfo:(NSDictionary*)userInfo;
-(void) sendInvalidBucketNameError:(NSString*) method;
-(void) sendInvalidKeyError:(NSString*) method;
-(void) sendInvalidNetWorkError;

@end
@implementation OSSObjectGroupOperation
@synthesize delegate;
-(void) sendInvalidBucketNameError:(NSString*) method
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
   
     if ([method isEqualToString:@"postObjectGroupRequest"])
     {
     if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationPostObjectGroupFailed:error:)]) 
        {
     
            [self.delegate OSSObjectGroupOperationPostObjectGroupFailed:self error:error];
        }
     }
    if ([method isEqualToString:@"fetchObjectGroupIndex"])
    {
        if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationFetchObjectGroupIndexFailed:error:)]) 
        {
            
            [self.delegate OSSObjectGroupOperationFetchObjectGroupIndexFailed:self error:error];
        }
    }
 
}
-(void) sendInvalidKeyError:(NSString*) method
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
   
    if ([method isEqualToString:@"postObjectGroupRequest"])
    {
        if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationPostObjectGroupFailed:error:)]) 
        {
            
            [self.delegate OSSObjectGroupOperationPostObjectGroupFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"fetchObjectGroupIndex"])
    {
        if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationFetchObjectGroupIndexFailed:error:)]) 
        {
            
            [self.delegate OSSObjectGroupOperationFetchObjectGroupIndexFailed:self error:error];
        }
    }
    
}
-(void) postObjectGroup:(PostObjectGroupRequest*)postObjectGroupRequest
{
    BOOL isVaildBucketName = [OSSUtils validateBucketName:postObjectGroupRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:postObjectGroupRequest.objectGroupName];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"postObjectGroupRequest"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"postObjectGroupRequest"];
        return;
    }
    NSAssert(!(postObjectGroupRequest.objectGroupPartETags == nil || [postObjectGroupRequest.objectGroupPartETags count] <0 ||[postObjectGroupRequest.objectGroupPartETags count] >1000),@"postObjectGroup failed");
    NSArray * sortArray = [postObjectGroupRequest.objectGroupPartETags sortedArrayUsingComparator:^(id a, id b) {
        ObjectGroupPartETag *first = a;
        ObjectGroupPartETag *second = b;
        return (NSComparisonResult)(first.partNumber > second.partNumber);
    }];
    NSString * xmlData = [self makePostObjectGroupXML:sortArray];
    NSData * content = [xmlData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:1];
    [headers setObject:@"text/plain"  forKey:@"Content-Type"];
    OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
    [params setObject:@""  forKey:@"group"];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"postObjectGroupRequest", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_POST buckName:postObjectGroupRequest.bucketName objectName:postObjectGroupRequest.objectGroupName headers:headers params:params content:content contentLength:[content length] userInfo:userInfo];
    [headers release];
    [params release];
    
}
-(void)fetchObjectGroupIndex:(NSString*) bucketName key: (NSString*) key
{
    BOOL isVaildBucketName = [OSSUtils validateBucketName:bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"fetchObjectGroupIndex"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"fetchObjectGroupIndex"];
        return;
    }
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:1];
    [headers setObject:@"NULL"  forKey:@"x-oss-file-group"];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"fetchObjectGroupIndex", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_GET buckName:bucketName objectName:key headers:headers params:nil content:nil contentLength:0 userInfo:userInfo];
    [headers release];

}
//没有实现，请使用 fetchObject 方法
-(void) fetchObjectGroup:(NSString*) bucketName key: (NSString*) key
{
    return;
}
//没有实现，请使用 deleteObject 方法
-(void) deleteObjectGroup:(NSString*) bucketName key: (NSString*) key
{
    return;
}
//没有实现，请使用 fetchObjectMetadata 方法
-(void)fetchObjectGroupMetadata:(NSString*) bucketName key: (NSString*) key
{
    return;
}
-(NSString * ) makePostObjectGroupXML:(NSArray*)objectGroupPartETags
{
    NSMutableString * rtnString = [[NSMutableString alloc] initWithCapacity:100];
    [rtnString appendString:@"<CreateFileGroup>"];
    for (ObjectGroupPartETag * partEtag in objectGroupPartETags) {
        [rtnString appendString:@"<Part>"];
        [rtnString appendString:@"<PartNumber>"];
        [rtnString appendString:[NSString stringWithFormat:@"%d",partEtag.partNumber]];
        [rtnString appendString:@"</PartNumber>"];
        [rtnString appendString:@"<PartName>"];
        [rtnString appendString:partEtag.partName];
        [rtnString appendString:@"</PartName>"];
        [rtnString appendString:@"<ETag>"];
        [rtnString appendString:partEtag.eTag];
        [rtnString appendString:@"</ETag>"];        
        [rtnString appendString:@"</Part>"];
    }
    [rtnString appendString:@"</CreateFileGroup>"];
    return [rtnString autorelease];
}
-(void) sendFinishedMessage:(ResponseMessage*) rm
{
    NSString * strMethod = nil;
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        strMethod = [rm.userInfo objectForKey:@"method"];
        if ([strMethod isEqualToString:@"postObjectGroupRequest"]) {
                    
            if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationPostObjectGroupFinish:result:)]) {
                PostObjectGroupResult * result = [ResponseParser parsePostObjectGroupResult:rm.content];
                [self.delegate OSSObjectGroupOperationPostObjectGroupFinish:self result:result];
            }
             
        }
        if ([strMethod isEqualToString:@"fetchObjectGroupIndex"]) {
            
            if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationFetchObjectGroupIndexFinish:result:)]) {
                FetchObjectGroupIndexResult * result = [ResponseParser parseFetchObjectGroupIndexResult:rm.content];
                [self.delegate OSSObjectGroupOperationFetchObjectGroupIndexFinish:self result:result];
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
        NSString *strMethod = [rm.userInfo objectForKey:@"method"];
        
        if ([strMethod isEqualToString:@"postObjectGroupRequest"]) {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationAbortMultipartUploadFailed:error:)]) {
                [self.delegate OSSObjectGroupOperationPostObjectGroupFailed:self error:error];
            }
        }
        if ([strMethod isEqualToString:@"fetchObjectGroupIndex"])
        {
            if ([self.delegate respondsToSelector:@selector(OSSObjectGroupOperationFetchObjectGroupIndexFailed:error:)]) 
            {
                
                [self.delegate OSSObjectGroupOperationFetchObjectGroupIndexFailed:self error:error];
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
    if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationNetWorkFailed:error:)]) 
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
        [self.delegate OSSObjectGroupOperationNetWorkFailed:self error:error];
            
    }  
}
-(void)invoke:(HttpMethod) httpMethod buckName:(NSString*) buckName objectName:(NSString*)objectName headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params content:(NSData*)content contentLength:(long) contentLength  userInfo:(NSDictionary*)userInfo
{
    //    NSAssert(!(5368709120L <= contentLength),@"content too large ");
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
