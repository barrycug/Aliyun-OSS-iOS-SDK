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
#import "OSSMultipartOperation.h"
#import "ObjectMetadata.h"
#import "OSSUtils.h"
#import "OSSErrorCode.h"
#import "ResponseMessage.h"
#import "ResponseParser.h"
#import "OSSError.h"
#import "AbortMultipartUploadRequest.h"
#import "CompleteMultipartUploadRequest.h"
#import "PartETag.h"
#import "CompleteMultipartUploadResult.h"
#import "InitiateMultipartUploadRequest.h"
#import "InitiateMultipartUploadResult.h"
#import "ListMultipartUploadsRequest.h"
#import "ListPartsRequest.h"
#import "UploadPartRequest.h"
#import "UploadPartResult.h"

@interface OSSMultipartOperation()
-(void)invoke:(HttpMethod) httpMethod buckName:(NSString*) buckName objectName:(NSString*)objectName headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params content:(NSData*)content contentLength:(long) contentLength  userInfo:(NSDictionary*)userInfo;
-(void) sendInvalidBucketNameError:(NSString*) method;
-(void) sendInvalidKeyError:(NSString*) method;
-(void) sendInvalidNetWorkError;
-(NSString *)buildMultipartRequestXml:(NSArray*) partETags;
@end
@implementation OSSMultipartOperation
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
    if ([method isEqualToString:@"AbortMultipartUpload"])
    {
       
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationAbortMultipartUploadFailed:error:)]) 
        {
             
            [self.delegate OSSMultipartOperationAbortMultipartUploadFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"completeMultipartUpload"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationCompleteMultipartUploadFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"initiateMultipartUploadRequest"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationInitiateMultipartUploadFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"listMultipartUploads"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListMultipartUploadsFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationListMultipartUploadsFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"listPartsRequest"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListPartsFailed:error::error:)]) 
        {
            
            [self.delegate OSSMultipartOperationListPartsFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"uploadPart"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationUploadPartFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationUploadPartFailed:self error:error];
        }
    }
    
    
    /*
    NSString * errorCode = [OSSErrorCode OSSErrorCodeToString: OSSErrorCodeType_INVALID_BUCKET_NAME];
    NSLog(@"%@",errorCode);
     */
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
    if ([method isEqualToString:@"AbortMultipartUpload"])
    {
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationAbortMultipartUploadFailed:error:)]) 
        {
           
            [self.delegate OSSMultipartOperationAbortMultipartUploadFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"completeMultipartUpload"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationCompleteMultipartUploadFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"initiateMultipartUploadRequest"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationInitiateMultipartUploadFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"listPartsRequest"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListPartsFailed:error::error:)]) 
        {
            
            [self.delegate OSSMultipartOperationListPartsFailed:self error:error];
        }
    }
    if ([method isEqualToString:@"uploadPart"])
    {
        
        if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationUploadPartFailed:error:)]) 
        {
            
            [self.delegate OSSMultipartOperationUploadPartFailed:self error:error];
        }
    }
    /*
    NSString * errorCode = [OSSErrorCode OSSErrorCodeToString: OSSErrorCodeType_INVALIED];
    NSLog(@"%@",errorCode);
     */
}

-(void) abortMultipartUpload:(AbortMultipartUploadRequest*) abortMultipartUploadRequest
{
    NSAssert(!(abortMultipartUploadRequest == nil),@"abortMultipartUploadRequest nil");

    BOOL isVaildBucketName = [OSSUtils validateBucketName:abortMultipartUploadRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:abortMultipartUploadRequest.key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"AbortMultipartUpload"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"AbortMultipartUpload"];
        return;
    }
    NSAssert(!(abortMultipartUploadRequest.uploadId == nil),@"abortMultipartUploadRequest.uploadId is nil");
    OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
    [params setObject:abortMultipartUploadRequest.uploadId  forKey:@"uploadId"];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"uploadId",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"AbortMultipartUpload",abortMultipartUploadRequest.uploadId, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_DELETE buckName:abortMultipartUploadRequest.bucketName objectName:abortMultipartUploadRequest.key headers:nil params:params content:nil contentLength:0 userInfo:userInfo];
    [params release];
}
-(void) completeMultipartUpload:(CompleteMultipartUploadRequest*)completeMultipartUploadRequest
{
    NSAssert(!(completeMultipartUploadRequest == nil),@"completeMultipartUploadRequest nil");
    
    BOOL isVaildBucketName = [OSSUtils validateBucketName:completeMultipartUploadRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:completeMultipartUploadRequest.key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"completeMultipartUpload"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"completeMultipartUpload"];
        return;
    }
    NSAssert(!(completeMultipartUploadRequest.uploadId == nil),@"completeMultipartUploadRequest.uploadId is nil");
    NSAssert(!(completeMultipartUploadRequest.partETags == nil),@"completeMultipartUploadRequest.partETags is nil");
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:1];
    [headers setObject:@"text/plain"  forKey:@"Content-Type"];
    OrderedDictionary * param = [[OrderedDictionary alloc] initWithCapacity:1];
    [param setObject:completeMultipartUploadRequest.uploadId  forKey:@"uploadId"];
    
    NSString * strContent = [self buildMultipartRequestXml:completeMultipartUploadRequest.partETags];
    NSData * content = [strContent dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"uploadId",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"completeMultipartUpload",completeMultipartUploadRequest.uploadId, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_POST buckName:completeMultipartUploadRequest.bucketName objectName:completeMultipartUploadRequest.key headers:headers params:param content:content contentLength:[content length] userInfo:userInfo];
    [param release];
    [headers release];
}
-(void) initiateMultipartUpload:(InitiateMultipartUploadRequest*)initiateMultipartUploadRequest
{
    NSAssert(!(initiateMultipartUploadRequest == nil),@"initiateMultipartUploadRequest nil");
    
    BOOL isVaildBucketName = [OSSUtils validateBucketName:initiateMultipartUploadRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:initiateMultipartUploadRequest.key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"initiateMultipartUploadRequest"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"initiateMultipartUploadRequest"];
        return;
    }
    OrderedDictionary * headers = [[OrderedDictionary alloc] initWithCapacity:1];
    if (initiateMultipartUploadRequest.objectMetadata != nil) {
        [OSSUtils populateRequestMetadata:headers objectMetadata:initiateMultipartUploadRequest.objectMetadata];
    }
    [headers removeObjectForKey:@"Content-Length"];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:1];
    [params setObject:@""  forKey:@"uploads"];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"initiateMultipartUploadRequest", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    NSData * data = [[NSString stringWithString:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    [self invoke:HttpMethod_POST buckName:initiateMultipartUploadRequest.bucketName objectName:initiateMultipartUploadRequest.key headers:headers params:params content:data contentLength:0 userInfo:userInfo];
    [headers release];
    [params release];
    
  
}
-(void)listMultipartUploads:(ListMultipartUploadsRequest*)listMultipartUploadsRequest
{
    NSAssert(!(listMultipartUploadsRequest == nil),@"listMultipartUploadsRequest nil");
    
    BOOL isVaildBucketName = [OSSUtils validateBucketName:listMultipartUploadsRequest.bucketName];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"listMultipartUploads"];
        return;
    }
    OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
    [params setObject:@""  forKey:@"uploads"];
    if (listMultipartUploadsRequest.delimiter != nil) {
        [params setObject:listMultipartUploadsRequest.delimiter  forKey:@"delimiter"];
    }
    if (listMultipartUploadsRequest.keyMarker != nil) {
        [params setObject:listMultipartUploadsRequest.keyMarker  forKey:@"key-marker"];
    }
    if (listMultipartUploadsRequest.maxUploads >0) {
        [params setObject:[NSString stringWithFormat:@"%d",listMultipartUploadsRequest.maxUploads]  forKey:@"max-uploads"];
    }
    if (listMultipartUploadsRequest.prefix != nil) {
        [params setObject:listMultipartUploadsRequest.prefix  forKey:@"prefix"];
    }
    if (listMultipartUploadsRequest.uploadIdMarker != nil) {
        [params setObject:listMultipartUploadsRequest.uploadIdMarker  forKey:@"upload-id-marker"];
    }
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"listMultipartUploads", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    
    [self invoke:HttpMethod_GET buckName:listMultipartUploadsRequest.bucketName objectName:nil headers:nil params:params content:nil contentLength:0 userInfo:userInfo];
    [params release];
    
}
-(void)listParts:(ListPartsRequest*) listPartsRequest
{
    NSAssert(!(listPartsRequest == nil),@"listPartsRequest nil");
    
    BOOL isVaildBucketName = [OSSUtils validateBucketName:listPartsRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:listPartsRequest.key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"listPartsRequest"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"listPartsRequest"];
        return;
    }
    NSAssert(!(listPartsRequest.uploadId == nil),@"listPartsRequest.uploadId nil");
    int partNumberMarker = listPartsRequest.partNumberMarker;
    NSAssert((listPartsRequest.maxParts >0 && listPartsRequest.maxParts <1000),@"maxParts failed");
    NSAssert((partNumberMarker >0 && partNumberMarker <1000),@"partNumberMarker failed");
    OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
    [params setObject:listPartsRequest.uploadId  forKey:@"uploadId"];
    [params setObject:[NSString stringWithFormat:@"%d",listPartsRequest.maxParts]  forKey:@"max-parts"];
    [params setObject:[NSString stringWithFormat:@"%d",listPartsRequest.partNumberMarker]  forKey:@"part-number-marker"];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"listPartsRequest", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_GET buckName:listPartsRequest.bucketName objectName:listPartsRequest.key headers:nil params:params content:nil contentLength:0 userInfo:userInfo];
    [params release];
}
-(void) uploadPart:(UploadPartRequest*) uploadPartRequest
{
    NSAssert(!(uploadPartRequest == nil),@"uploadPartRequest nil");
    
    BOOL isVaildBucketName = [OSSUtils validateBucketName:uploadPartRequest.bucketName];
    BOOL isVaildBucketKey = [OSSUtils validateObjectKey:uploadPartRequest.key];
    if (!isVaildBucketName) {
        [self sendInvalidBucketNameError:@"uploadPartRequest"];
        return;
    }
    if (!isVaildBucketKey) {
        [self sendInvalidKeyError:@"uploadPartRequest"];
        return;
    }
    int l = uploadPartRequest.partSize;
    int i = uploadPartRequest.partNumber;
    NSAssert(!(uploadPartRequest.uploadId == nil),@"uploadPartRequest.uploadId nil");
    NSAssert(!(l < 0) || (l > 5368709120),@"uploadPartRequest partSize l < 0) || (l > 5368709120 ");
    NSAssert(!(i < 0) || (i > 10000),@"uploadPartRequest partNumber (i < 0) || (i > 10000)");
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:1];
    OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
    [headers setObject:[NSString stringWithFormat:@"%ld",l] forKey:@"Content-Length"];
    [headers setObject:uploadPartRequest.md5Digest forKey:@"Content-MD5"];
    [params setObject:uploadPartRequest.uploadId forKey:@"uploadId"];
    [params setObject:[NSString stringWithFormat:@"%ld",i] forKey:@"partNumber"];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"partNumber",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"uploadPart",[NSString stringWithFormat:@"%ld",i], nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_PUT buckName:uploadPartRequest.bucketName objectName:uploadPartRequest.key headers:headers params:params content:uploadPartRequest.data contentLength:l userInfo:userInfo];
    [headers release];
    [params release];
}

-(NSString *)buildMultipartRequestXml:(NSArray*) partETags
{
    NSMutableString * rtnString = [[NSMutableString alloc] initWithCapacity:100];
    [rtnString appendString:@"<CompleteMultipartUpload>"];
    for (PartETag *partETag in partETags) {
        [rtnString appendString:@"<Part>"];
        [rtnString appendString:@"<PartNumber>"];
        [rtnString appendString:[NSString stringWithFormat:@"%d",partETag.partNumber]];
        [rtnString appendString:@"</PartNumber>"];
        [rtnString appendString:@"<ETag>"];
        [rtnString appendString:partETag.eTag];
        [rtnString appendString:@"</ETag>"];
        [rtnString appendString:@"</Part>"];
    }
    [rtnString appendString:@"</CompleteMultipartUpload>"];
    return [rtnString autorelease];
}

-(void) sendFinishedMessage:(ResponseMessage*) rm
{
    NSString * strMethod = nil;
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        strMethod = [rm.userInfo objectForKey:@"method"];
        if ([strMethod isEqualToString:@"AbortMultipartUpload"]) {
            NSString * strUploadId = [rm.userInfo objectForKey:@"uploadId"];
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationAbortMultipartUploadFinished:result:)]) {
                [self.delegate OSSMultipartOperationAbortMultipartUploadFinished:self result:strUploadId];
            }
        }
        if ([strMethod isEqualToString:@"completeMultipartUpload"])
        {
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFinished:result:)]) 
            {
                CompleteMultipartUploadResult * result = [ResponseParser parseCompleteMultipartUpload:rm.content];
                [self.delegate OSSMultipartOperationCompleteMultipartUploadFinished:self result:result];
            }
        }
        if ([strMethod isEqualToString:@"initiateMultipartUploadRequest"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationInitiateMultipartUploadFinished:result:)]) 
            {
                InitiateMultipartUploadResult * result = [ResponseParser parseInitiateMultipartUpload:rm.content];
                
                [self.delegate OSSMultipartOperationInitiateMultipartUploadFinished:self result:result];
            }
        }
        if ([strMethod isEqualToString:@"listMultipartUploads"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListMultipartUploadsFinished:result:)]) 
            {
                MultipartUploadListing* result = [ResponseParser  parseListMultipartUploads:rm.content];
                
                [self.delegate OSSMultipartOperationListMultipartUploadsFinished:self result:result];
            }
        }
        if ([strMethod isEqualToString:@"listPartsRequest"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListPartsFinished:result:)]) 
            {
                PartListing * result = [ResponseParser parsePartList:rm.content];
                [self.delegate OSSMultipartOperationListPartsFinished:self result:result];
            }
        }
        if ([strMethod isEqualToString:@"uploadPart"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationUploadPartFinished:result:)]) 
            {
                int partNum = [[rm.userInfo objectForKey:@"partNumber"] intValue];
                NSString * eTag = [rm.headers objectForKey:@"Etag"];
                 eTag =  [ OSSUtils trimQuotes:eTag];
                UploadPartResult *result = [[[UploadPartResult alloc] initWithPartNumber:partNum eTag:eTag] autorelease];
                [self.delegate OSSMultipartOperationUploadPartFinished:self result:result];
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
        if ([strMethod isEqualToString:@"AbortMultipartUpload"]) {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationAbortMultipartUploadFailed:error:)]) {
                [self.delegate OSSMultipartOperationAbortMultipartUploadFailed:self error:error];
            }
        }
        if ([strMethod isEqualToString:@"completeMultipartUpload"])
        {
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFailed:error:)]) 
            {
                
                [self.delegate OSSMultipartOperationCompleteMultipartUploadFailed:self error:error];
            }
        }
        if ([strMethod isEqualToString:@"initiateMultipartUploadRequest"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationCompleteMultipartUploadFailed:error:)]) 
            {
                
                [self.delegate OSSMultipartOperationInitiateMultipartUploadFailed:self error:error];
            }
        }
        if ([strMethod isEqualToString:@"initiateMultipartUploadRequest"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListMultipartUploadsFailed:error:)]) 
            {
                
                [self.delegate OSSMultipartOperationListMultipartUploadsFailed:self error:error];
            }
        }
        if ([strMethod isEqualToString:@"listPartsRequest"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationListPartsFailed:error::error:)]) 
            {
                
                [self.delegate OSSMultipartOperationListPartsFailed:self error:error];
            }
        }
        if ([strMethod isEqualToString:@"uploadPart"])
        {
            
            if ([self.delegate respondsToSelector:@selector(OSSMultipartOperationUploadPartFailed:error:)]) 
            {
                
                [self.delegate OSSMultipartOperationUploadPartFailed:self error:error];
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
        [self.delegate OSSMultipartOperationNetWorkFailed:self error:error];
        
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
