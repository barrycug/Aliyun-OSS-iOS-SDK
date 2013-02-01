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
#import "OSSBucketOperation.h"
#import "OSSUtils.h"
#import "OSSOperation.h"
#import "Bucket.h"
#import "ResponseMessage.h"
#import "OSSError.h"
#import "OSSErrorCode.h"
#import "ResponseParser.h"
#import "CannedAccessControlList.h"
#import "ListObjectsRequest.h"
#import "ObjectListing.h"
#import "OrderedDictionary.h"
@interface OSSBucketOperation()
-(void) sendInvalidBucketNameError;
-(void) sendInvalidNetWorkError;
-(void) sendFailedMessage:(ResponseMessage*) rm;
-(void) sendFinishedMessage:(ResponseMessage*) rm;
@end
@implementation OSSBucketOperation
@synthesize delegate;
+(NSString*) SUBRESOURCE_ACL
{
    return  @"acl";
}
-(void) sendInvalidBucketNameError
{
    if ([self.delegate respondsToSelector:@selector(bucketOperationCreateFailed:error:)]) {
        NSString * errorCode = [OSSErrorCode OSSErrorCodeToString: OSSErrorCodeType_INVALID_BUCKET_NAME];
        OSSError * error = [OSSError OSSErrorWithErrorCode:errorCode
                                                   message:@"" 
                                         stringToSignBytes:@"" 
                                         signatureProvided:@"" 
                                              stringToSign:@"" 
                                            ossAccessKeyId:@"" 
                                                 requestId:@"" 
                                                    hostId:@""];  
        [self.delegate bucketOperationCreateFailed:self error:error];
    }
}
//创建Bucket
-(void) createBucket:(NSString *) bucketName
{
    BOOL isValidate = [OSSUtils validateBucketName: bucketName];
    if (isValidate) 
    {
        NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName", nil];
        NSArray *objs = [NSArray arrayWithObjects:@"createBucket",bucketName, nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        [self invoke:HttpMethod_PUT buckName:bucketName headers:nil params:nil userInfo:userInfo];
    }
    else 
    {
        [self sendInvalidBucketNameError];
    }
}
-(void) deleteBucket:(NSString*) bucketName
{
    BOOL isValidate = [OSSUtils validateBucketName: bucketName];
    if (isValidate) {
        NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName", nil];
        NSArray *objs = [NSArray arrayWithObjects:@"deleteBucket",bucketName, nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        [self invoke:HttpMethod_DELETE buckName:bucketName headers:nil params:nil userInfo:userInfo];
    }
    else {
        [self sendInvalidBucketNameError];
    }
}
-(void)listBuckets
{
    NSArray *keys = [NSArray arrayWithObjects:@"method", nil];
    NSArray *objs = [NSArray arrayWithObjects:@"listBuckets", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invoke:HttpMethod_GET buckName:nil headers:nil params:nil userInfo:userInfo];

}
-(void) writeBucketAcl:(NSString*) bucketName  cannedAccessControlList:(CannedAccessControlList*) cannedAccessControlList
{
    
    BOOL isValidate = [OSSUtils validateBucketName: bucketName];
    if (isValidate) {
        if (cannedAccessControlList == nil) {
            cannedAccessControlList = [CannedAccessControlList cannedAclWithCannedAclType:CannedAclType_Private];            
        }
        NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName",@"acl",nil];
        NSArray *objs = [NSArray arrayWithObjects:@"writeBucketAcl",bucketName,cannedAccessControlList, nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:1];
        [headers setObject:cannedAccessControlList.cannedAclString forKey:@"x-oss-acl"];
        OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
        [params setObject:@"" forKey:@"acl"];
        [self invoke:HttpMethod_PUT buckName:bucketName headers:headers params:params userInfo:userInfo];
        [headers release];
        [params release];
        
    }
    else {
        [self sendInvalidBucketNameError];
    }

}
-(void)readBucketAcl:(NSString *)bucketName
{
    BOOL isValidate = [OSSUtils validateBucketName: bucketName];
    if (isValidate) {
        
        NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName",nil];
        NSArray *objs = [NSArray arrayWithObjects:@"readBucketAcl",bucketName, nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        
        OrderedDictionary * params = [[OrderedDictionary alloc] initWithCapacity:1];
        [params setObject:@"" forKey:@"acl"];
        [self invoke:HttpMethod_GET buckName:bucketName headers:nil params:params userInfo:userInfo];
        [params release];
        
    }
    else {
        [self sendInvalidBucketNameError];
    }
}
-(void)isBucketExist:(NSString*)bucketName
{
    BOOL isValidate = [OSSUtils validateBucketName: bucketName];
    if (isValidate) {
        NSArray *keys = [NSArray arrayWithObjects:@"method",@"bucketName",nil];
        NSArray *objs = [NSArray arrayWithObjects:@"isBucketExist",bucketName, nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        [self invoke:HttpMethod_GET buckName:nil headers:nil params:nil userInfo:userInfo];
    }
    else 
    {
        [self sendInvalidBucketNameError];
    }
}
-(void) listObjects:(ListObjectsRequest*)listObjectsRequest
{
    NSAssert(!(listObjectsRequest == nil),@"listObjectsRequest nil");
    BOOL isValidate = [OSSUtils validateBucketName: listObjectsRequest.bucketName];
    if (isValidate) {
        NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
        NSArray *objs = [NSArray arrayWithObjects:@"listObjects", nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        OrderedDictionary * parames = [[OrderedDictionary alloc] initWithCapacity:5];
        if (listObjectsRequest.prefix != nil && ![listObjectsRequest.prefix isEqualToString:@""]) {
            [parames setObject:listObjectsRequest.prefix forKey:@"prefix"];
        }
        if (listObjectsRequest.marker != nil && ![listObjectsRequest.marker isEqualToString:@""]) {
            [parames setObject:listObjectsRequest.prefix forKey:@"marker"];
        }
        if (listObjectsRequest.delimiter != nil && ![listObjectsRequest.delimiter isEqualToString:@""]) {
            [parames setObject:listObjectsRequest.delimiter forKey:@"delimiter"];
        }
        if (listObjectsRequest.maxKeys > 0 ) {
            [parames setObject:[NSString stringWithFormat:@"%d",listObjectsRequest.maxKeys] forKey:@"max-keys"];
        }
        [self invoke:HttpMethod_GET buckName:listObjectsRequest.bucketName headers:nil params:parames userInfo:userInfo];
        [parames release];
    }
    else 
    {
        [self sendInvalidBucketNameError];
    }
}

-(void)invoke:(HttpMethod) httpMethod buckName:(NSString*) buckName  headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params userInfo:(NSDictionary*)userInfo
{
    [self request: httpMethod 
         buckName: buckName 
       objectName: nil 
          headers: headers   
           params: params
           content: nil  
     contentLength: 0
         userInfo:userInfo];
}
-(void) sendFinishedMessage:(ResponseMessage*) rm
{
    NSString * strMethod = nil;
    NSString * strBucketName = nil;
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        Bucket * bucket = nil;
        strMethod = [rm.userInfo objectForKey:@"method"];
        strBucketName = [rm.userInfo objectForKey:@"bucketName"] ;
        // createBucket finish
        if([strMethod isEqualToString:@"createBucket"] )
        {
            bucket = [Bucket bucketWithName:[rm.userInfo objectForKey:@"bucketName"]];
            if ([self.delegate respondsToSelector:@selector(bucketOperationCreateFinish:result:)]) 
            {            
                [self.delegate bucketOperationCreateFinish:self result:bucket];
            }
        }
        // deleteBucket finish
        if([strMethod isEqualToString:@"deleteBucket"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationDeleteFinish:result:)]) 
            {            
                [self.delegate bucketOperationDeleteFinish:self result:strBucketName];
            }
        }
        // listBuckets finish
        if([strMethod isEqualToString:@"listBuckets"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationListFinish:result:)]) 
            {    
                NSArray * arrayList = [ResponseParser parserBucklist:rm.content];
                [self.delegate bucketOperationListFinish:self result:arrayList];
            }
        }
        // writeBucketAcl finish
        if([strMethod isEqualToString:@"writeBucketAcl"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationWriteBucketAclFinish:result:)]) 
            {    
                
                CannedAccessControlList * acl = [rm.userInfo objectForKey:@"acl"];
                [self.delegate bucketOperationWriteBucketAclFinish:self result:acl];
            }
        }
        // readBucketAcl finish
        if([strMethod isEqualToString:@"readBucketAcl"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationReadBucketAclFinish:result:)]) 
            {    
                
                CannedAccessControlList * acl = [ResponseParser parserCannedAccessControlList:rm.content];
                [self.delegate bucketOperationReadBucketAclFinish:self result:acl];
            }
        }
        // isBucketExist finish
        if([strMethod isEqualToString:@"isBucketExist"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationIsBucketExistFinish:result:)]) 
            {    
                NSArray * arrayList = [ResponseParser parserBucklist:rm.content];
                NSString * strBucketName = [rm.userInfo objectForKey:@"bucketName"];
                BOOL isBucketExist = NO;
                for (Bucket *bucket in arrayList) {
                    if ([bucket.name isEqualToString:strBucketName]) {
                        isBucketExist = YES;
                        break;
                    }
                }
                [self.delegate bucketOperationIsBucketExistFinish:self result:isBucketExist];
            }
        }
        // isBucketExist finish
        if([strMethod isEqualToString:@"listObjects"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationListObjectsFinish:result:)]) 
            {    
                ObjectListing * ol = [ResponseParser parserObjectListing:rm.content];
                [self.delegate bucketOperationListObjectsFinish:self result:ol];
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
        if ([strMethod isEqualToString:@"createBucket"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationCreateFailed:error:)]) 
            {
                [self.delegate bucketOperationCreateFailed:self error:error];                
            }
        }
        // deleteBucket Failed
        if ([strMethod isEqualToString:@"deleteBucket"] )
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationDeleteFailed:error:)]) 
            {
                [self.delegate bucketOperationDeleteFailed:self error:error];                
            }
            
        }
        // listBuckets Failed
        if([strMethod isEqualToString:@"listBuckets"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationListFailed:error:)]) 
            {
                [self.delegate bucketOperationListFailed:self error:error];                
            }
        }
        // writeBucketAcl Failed
        if([strMethod isEqualToString:@"writeBucketAcl"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationWriteBucketAclFailed:error:)]) 
            {
                [self.delegate bucketOperationWriteBucketAclFailed:self error:error];                
            }
        }
        // readBucketAcl Failed
        if([strMethod isEqualToString:@"readBucketAcl"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationReadBucketAclFailed:error:)]) 
            {
                [self.delegate bucketOperationReadBucketAclFailed:self error:error];                
            }
        }
        // isBucketExist finish
        if([strMethod isEqualToString:@"isBucketExist"])
        {
            if ([self.delegate respondsToSelector:@selector(bucketOperationIsBucketExistFailed:error:)]) 
            {    
                [self.delegate bucketOperationIsBucketExistFailed:self error:error];
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
    if ([self.delegate respondsToSelector:@selector(bucketOperationNetWorkFailed:error:)]) 
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
        [self.delegate bucketOperationNetWorkFailed:self error:error];
    
    }
}
@end
