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
#import "OSSClient.h"
#import "ClientConfiguration.h"
#import "ServiceCredentials.h"
#import "DefaultServiceClient.h"
#import "OSSUtils.h"
#import "OSSBucketOperation.h"
#import "ListObjectsRequest.h"
#import "OSSObjectOperation.h"
#import "ObjectMetadata.h"
#import "OSSMultipartOperation.h"
#import "OSSObjectGroupOperation.h"
#import "PostObjectGroupRequest.h"
#import "PostObjectGroupResult.h"
#import "FetchObjectGroupIndexResult.h"
@interface OSSClient ()<BucketOperationDelegate,OSSObjectOperationDelegate,OSSMultipartOperationDelegate,OSSObjectGroupOperationDelegate>

@end
@implementation OSSClient
@synthesize delegate;
-(void)dealloc
{
    [_endPoint release];
    _endPoint = nil;
    [_credentials release];
    _credentials = nil;
    [_config release];
    _config = nil;
    [_serviceClientBucket release];
    _serviceClientBucket = nil;
    [_serviceClientObject release];
    _serviceClientObject = nil;
    [_serviceClientObjectGroup release];
    _serviceClientObjectGroup = nil;
    [_serviceClientMultipart release];
    _serviceClientMultipart = nil;
    [_ossBucketOperation release];
    _ossBucketOperation = nil;
    [_ossObjectOperation release];
    _ossObjectOperation = nil;
    [_ossMultipartOperation release];
    _ossMultipartOperation = nil;
    [_ossObjectGroupOperation release];
    _ossObjectGroupOperation = nil;
    [super dealloc];
}
-(id) init
{
    /*
    if (self = [self initWithEndPoint:@"http://storage.aliyun.com" AccessId:@"" andAccessKey:@"" andConfig:nil]) {
        ;
    }
     */
    if (self = [self initWithEndPoint:@"http://oss.aliyuncs.com" AccessId:@"" andAccessKey:@"" andConfig:nil]) {
        ;
    }
   
    return self;
}
-(id) initWithAccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    ClientConfiguration * config = [ClientConfiguration clientConfiguration];
    /*
    if (self = [self initWithEndPoint:@"http://storage.aliyun.com" AccessId:accessID andAccessKey:accessKey andConfig:config]) {
        ;
    }
     */
    if (self = [self initWithEndPoint:@"http://oss.aliyuncs.com" AccessId:accessID andAccessKey:accessKey andConfig:config]) {
        ;
    }
    return self;
}
-(id) initWithEndPoint:(NSString * ) endpoint AccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    if (self = [self initWithEndPoint:endpoint AccessId:accessID andAccessKey:accessKey andConfig:nil]) {
        ;
    }
    return self;
}
-(id) initWithEndPoint:(NSString * ) endpoint AccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey andConfig:(ClientConfiguration *)config
{
    if (self = [super init]) {
        _endPoint = endpoint;
        [_endPoint retain];
        _credentials = [[ServiceCredentials alloc] initWithAccessId:accessID andAccessKey:accessKey];
        _config = config;
        [_config retain];
        _serviceClientBucket = [[DefaultServiceClient alloc] initWithClientConfiguration:_config ];
        _ossBucketOperation = [[OSSBucketOperation alloc] initWithEndPoint:_endPoint credentials:_credentials client:_serviceClientBucket];
        _ossBucketOperation.delegate = self;
        _serviceClientObject = [[DefaultServiceClient alloc] initWithClientConfiguration:_config ];
        _ossObjectOperation = [[OSSObjectOperation alloc] initWithEndPoint:_endPoint credentials:_credentials client:_serviceClientObject];
        _ossObjectOperation.delegate = self;
        _serviceClientMultipart =[[DefaultServiceClient alloc] initWithClientConfiguration:_config ];
        _ossMultipartOperation = [[OSSMultipartOperation alloc]initWithEndPoint:_endPoint credentials:_credentials client:_serviceClientMultipart];
        _ossMultipartOperation.delegate = self;
        _serviceClientObjectGroup =[[DefaultServiceClient alloc] initWithClientConfiguration:_config ];
        _ossObjectGroupOperation = [[OSSObjectGroupOperation alloc] initWithEndPoint:_endPoint credentials:_credentials client:_serviceClientObjectGroup];
        _ossObjectGroupOperation.delegate = self;
        
    }
    return self;
}
+(id) OSSClientWithAccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    OSSClient * c = [[OSSClient alloc] initWithAccessId:accessID andAccessKey:accessKey];
    return [c autorelease];
}
+(id) OSSClientWithEndPoint:(NSString * ) endpoint AccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    OSSClient * c = [[OSSClient alloc] initWithEndPoint:endpoint AccessId:accessID andAccessKey:accessKey];
    return [c autorelease];
}
+(id)  OSSClientWithEndPoint:(NSString * ) endpoint AccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey andConfig:(ClientConfiguration *)config
{
    OSSClient * c = [[OSSClient alloc]  initWithEndPoint:endpoint AccessId:accessID andAccessKey:accessKey andConfig:config];
    return [c autorelease];
}
-(void) createBucket:(NSString *) bucketName
{
     NSAssert(!(bucketName == nil),@"bucketName is nil");
    if (bucketName != nil) {
        [_ossBucketOperation createBucket:bucketName];
    }
    
}
-(void) deleteBucket:(NSString*) bucketName
{
    NSAssert(!(bucketName == nil),@"bucketName is nil");
    if (bucketName != nil) {
        [_ossBucketOperation deleteBucket:bucketName];
    }
}
-(void) listBuckets
{
    [_ossBucketOperation listBuckets];
}
-(void) writeBucketAcl:(NSString*) bucketName  cannedAccessControlList:(CannedAccessControlList*) cannedAccessControlList
{
    [_ossBucketOperation writeBucketAcl:bucketName cannedAccessControlList:cannedAccessControlList];
}
-(void)readBucketAcl:(NSString *)bucketName
{
    [_ossBucketOperation readBucketAcl:bucketName];
}
-(void)isBucketExist:(NSString*)bucketName
{
    [_ossBucketOperation isBucketExist:bucketName];
}
-(void) listObjects:(ListObjectsRequest*)listObjectsRequest
{
    [_ossBucketOperation listObjects:listObjectsRequest];
}
-(void) putObject:(NSString*) bucketName 
                            key: (NSString*) key 
                           data:(NSData*) data  
                 objectMetadata:(ObjectMetadata*) objectMetadata
{
    [_ossObjectOperation putObject:bucketName key:key data:data objectMetadata:objectMetadata];
}
-(void)fetchObject:(NSString*) bucketName key: (NSString*) key
{
    [_ossObjectOperation fetchObject:bucketName key:key];
}
-(void)fetchObject:(FetchObjectRequest*)  fetchObjectRequest
{
    [_ossObjectOperation fetchObject:fetchObjectRequest];
}
-(void)fetchObject:(FetchObjectRequest *)  fetchObjectRequest  file:(NSString*) filePath
{
    [_ossObjectOperation fetchObject:fetchObjectRequest file:filePath];
}
-(void) fetchObjectMetadata:(NSString*) bucketName key: (NSString*) key
{
    [_ossObjectOperation fetchObjectMetadata:bucketName key:key];
}
-(void) copyObject:(CopyObjectRequest*)copyObjectRequest
{
    [_ossObjectOperation copyObject:copyObjectRequest];
}
-(void)deleteObject:(NSString*) bucketName key: (NSString*) key
{
    [_ossObjectOperation deleteObject:bucketName key:key];
}
-(void)deleteMultipleObjects:(NSString*) bucketName objectNames:(NSArray*)objectNames isQuiet:(BOOL)isQuiet
{
    [_ossObjectOperation deleteMultipleObjects:bucketName objectNames:objectNames isQuiet:isQuiet]; 
}

-(void) uploadPart:(UploadPartRequest*) uploadPartRequest
{
    [_ossMultipartOperation uploadPart:uploadPartRequest];
}
-(void) listParts:(ListPartsRequest*) listPartsRequest
{
    [_ossMultipartOperation  listParts:listPartsRequest];
}
-(void) listMultipartUploads:(ListMultipartUploadsRequest*)listMultipartUploadsRequest
{
    [_ossMultipartOperation listMultipartUploads:listMultipartUploadsRequest];
}
-(void) initiateMultipartUpload:(InitiateMultipartUploadRequest*)initiateMultipartUploadRequest
{
    [_ossMultipartOperation initiateMultipartUpload:initiateMultipartUploadRequest];
}
-(void) completeMultipartUpload:(CompleteMultipartUploadRequest*)completeMultipartUploadRequest
{
    [_ossMultipartOperation completeMultipartUpload:completeMultipartUploadRequest];
}
-(void) abortMultipartUpload:(AbortMultipartUploadRequest*) abortMultipartUploadRequest
{
    [_ossMultipartOperation  abortMultipartUpload:abortMultipartUploadRequest];
}

-(void) postObjectGroup:(PostObjectGroupRequest*)postObjectGroupRequest
{
    [_ossObjectGroupOperation postObjectGroup:postObjectGroupRequest];
}
-(void)fetchObjectGroupIndex:(NSString*) bucketName key: (NSString*) key
{
    [_ossObjectGroupOperation fetchObjectGroupIndex:bucketName key:key];
}
-(void)bucketOperationCreateFinish:(OSSBucketOperation*) bucketOperation result:(Bucket*) bucket
{
    if ([self.delegate respondsToSelector:@selector(bucketCreateFinish:result:)]) {
        [self.delegate bucketCreateFinish:self result:bucket];
    }
}
-(void)bucketOperationCreateFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;
{
    if ([self.delegate respondsToSelector:@selector(bucketCreateFailed:error:)]) {
        [self.delegate bucketCreateFailed:self error:error];
    }
}
-(void)bucketOperationDeleteFinish:(OSSBucketOperation*) bucketOperation result:(NSString*) bucketName
{
    if ([self.delegate respondsToSelector:@selector(bucketDeleteFinish:result:)]) {
        [self.delegate bucketDeleteFinish:self result:bucketName];
    }
}
-(void)bucketOperationDeleteFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(bucketDeleteFailed:error:)]) {
        [self.delegate bucketDeleteFailed:self error:error];
    }
}
-(void)bucketOperationListFinish:(OSSBucketOperation*) bucketOperation result:(NSArray*) bucketList
{
    if ([self.delegate respondsToSelector:@selector(bucketListFinish:result:)]) {
        [self.delegate bucketListFinish:self result:bucketList];
    }
}
-(void)bucketOperationListFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(bucketListFailed:error:)]) {
        [self.delegate bucketListFailed:self error:error];
    }
}
-(void)bucketOperationWriteBucketAclFinish:(OSSBucketOperation*) bucketOperation result:(CannedAccessControlList*) cannedAcl
{
    if ([self.delegate respondsToSelector:@selector(bucketWriteBucketAclFinish:result:)]) {
        [self.delegate bucketWriteBucketAclFinish:self result:cannedAcl];
    }
}
-(void)bucketOperationWriteBucketAclFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(bucketWriteBucketAclFailed:error:)]) {
        [self.delegate bucketWriteBucketAclFailed:self error:error];
    }
}
-(void)bucketOperationReadBucketAclFinish:(OSSBucketOperation*) bucketOperation result:(CannedAccessControlList*) cannedAcl
{
    if ([self.delegate respondsToSelector:@selector(bucketReadBucketAclFinish:result:)]) {
        [self.delegate bucketReadBucketAclFinish:self result:cannedAcl];
    }
}
-(void)bucketOperationReadBucketAclFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(bucketReadBucketAclFailed:error:)]) {
        [self.delegate bucketReadBucketAclFailed:self error:error];
    }
}
-(void)bucketOperationIsBucketExistFinish:(OSSBucketOperation*) bucketOperation result:(BOOL) isBucketExist
{
    if ([self.delegate respondsToSelector:@selector(bucketIsBucketExistFinish:result:)]) {
        [self.delegate bucketIsBucketExistFinish:self result:isBucketExist];
    }
}
-(void)bucketOperationIsBucketExistFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(bucketIsBucketExistFailed:error:)]) {
        [self.delegate bucketIsBucketExistFailed:self error:error];
    }
}
-(void)bucketOperationListObjectsFinish:(OSSBucketOperation*) bucketOperation result:(ObjectListing*) result
{
    if ([self.delegate respondsToSelector:@selector(bucketListObjectsFinish:result:)]) {
        [self.delegate bucketListObjectsFinish:self result:result];
    }
}
-(void)bucketOperationListObjectsFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(bucketListObjectsFailed:error:)]) {
        [self.delegate bucketListObjectsFailed:self error:error];
    }
}
-(void) bucketOperationNetWorkFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(netWorkFailed:error:)]) {
        [self.delegate netWorkFailed:self error:error];
    }
}
-(void)OSSObjectOperationPutObjectFinish:(OSSObjectOperation*) ossObjectOperation result:(PutObjectResult*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectPutObjectFinish:result:)]) {
        [self.delegate OSSObjectPutObjectFinish:self result:result];
    }
}
-(void)OSSObjectOperationPutObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectPutObjectFailed:error:)]) {
        [self.delegate OSSObjectPutObjectFailed:self error:error];
    }
}
-(void)OSSObjectOperationNetWorkFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(netWorkFailed:error:)]) {
        [self.delegate netWorkFailed:self error:error];
    }
}
-(void)OSSObjectOperationFetchObjectFinish:(OSSObjectOperation*) ossObjectOperation result:(OSSObject*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectFetchObjectFinish:result:)]) {
        [self.delegate OSSObjectFetchObjectFinish:self result:result];
    }
}
-(void)OSSObjectOperationFetchObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectFetchObjectFailed:error:)]) {
        [self.delegate OSSObjectFetchObjectFailed:self error:error];
    }
}
//fetchObject write to file
-(void)OSSObjectOperationFetchObjectAndWriteToFileFinish:(OSSObjectOperation*) ossObjectOperation result:(OSSObject*) result isWritedToFile:(BOOL)isWritedToFile 
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectFetchObjectAndWriteToFileFinish:result:isWritedToFile:)]) {
        [self.delegate OSSObjectFetchObjectAndWriteToFileFinish:self result:result isWritedToFile:isWritedToFile];
    }
}
-(void)OSSObjectOperationFetchObjectAndWriteToFileFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error  
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectFetchObjectAndWriteToFileFailed:error:)]) {
        [self.delegate OSSObjectFetchObjectAndWriteToFileFailed:self error:error];
    }
}

-(void)OSSObjectOperationFetchObjectMetadataFinish:(OSSObjectOperation*) ossObjectOperation result:(ObjectMetadata*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectFetchObjectMetadataFinish:result:)]) {
        [self.delegate OSSObjectFetchObjectMetadataFinish:self result:result];
    }
}
-(void)OSSObjectOperationFetchObjectMetadataFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectFetchObjectMetadataFailed:error:)]) {
        [self.delegate OSSObjectFetchObjectMetadataFailed:self error:error];
    }
}
-(void)OSSObjectOperationCopyObjectFinish:(OSSObjectOperation*) ossObjectOperation result:(CopyObjectResult*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectCopyObjectFinish:result:)]) {
        [self.delegate OSSObjectCopyObjectFinish:self result:result];
    }
}
-(void)OSSObjectOperationCopyObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectCopyObjectFailed:error:)]) {
        [self.delegate OSSObjectCopyObjectFailed:self error:error];
    }
}
-(void)OSSObjectOperationDeleteObjectFinish:(OSSObjectOperation*) ossObjectOperation bucketName:(NSString*) bucketName key:(NSString*)key
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectDeleteObjectFinish:bucketName:key:)]) {
        [self.delegate OSSObjectDeleteObjectFinish:self bucketName:bucketName key:key];
    }
}
-(void)OSSObjectOperationDeleteObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectDeleteObjectFailed:error:)]) {
        [self.delegate OSSObjectDeleteObjectFailed:self error:error];
    }
}
-(void)OSSObjectOperationDeleteMultipleObjectsFinish:(OSSObjectOperation*) ossObjectOperation  bucketName:(NSString*) bucketName result:(DeleteObjectsResult*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectDeleteMultipleObjectsFinish:bucketName:result:)]) {
        [self.delegate OSSObjectDeleteMultipleObjectsFinish:self bucketName:bucketName result:result];
    }

}
-(void)OSSObjectOperationDeleteMultipleObjectsFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectDeleteMultipleObjectsFailed:error:)]) {
        [self.delegate OSSObjectDeleteMultipleObjectsFailed:self error:error];
    }

}
//
-(void) OSSMultipartOperationNetWorkFailed:(OSSMultipartOperation*)operation error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(netWorkFailed:error:)]) {
        [self.delegate netWorkFailed:self error:error];
    }
}
-(void) OSSMultipartOperationAbortMultipartUploadFinished:(OSSMultipartOperation*)operation result:(NSString*) uploadId
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartAbortMultipartUploadFinished:result:)]) {
        [self.delegate OSSMultipartAbortMultipartUploadFinished:self result:uploadId];
    }
}
-(void) OSSMultipartOperationAbortMultipartUploadFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartAbortMultipartUploadFailed:error:)]) {
        [self.delegate OSSMultipartAbortMultipartUploadFailed:self error:error];
    }
}

-(void) OSSMultipartOperationCompleteMultipartUploadFinished:(OSSMultipartOperation*)operation result:(CompleteMultipartUploadResult*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartCompleteMultipartUploadFinished:result:)]) {
        [self.delegate OSSMultipartCompleteMultipartUploadFinished:self result:result];
    }
}

-(void) OSSMultipartOperationCompleteMultipartUploadFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartCompleteMultipartUploadFailed:error:)]) {
        [self.delegate OSSMultipartCompleteMultipartUploadFailed:self error:error];
    }
}

-(void) OSSMultipartOperationInitiateMultipartUploadFinished:(OSSMultipartOperation*)operation result:(InitiateMultipartUploadResult*) result
{
    
    if ([self.delegate respondsToSelector:@selector(OSSMultipartInitiateMultipartUploadFinished:result:)]) {
        [self.delegate OSSMultipartInitiateMultipartUploadFinished:self result:result];
    }
}

-(void) OSSMultipartOperationInitiateMultipartUploadFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartInitiateMultipartUploadFailed:error:)]) {
        [self.delegate OSSMultipartInitiateMultipartUploadFailed:self error:error];
    }
}


-(void) OSSMultipartOperationListMultipartUploadsFinished:(OSSMultipartOperation*)operation result:(MultipartUploadListing*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartListMultipartUploadsFinished:result:)]) {
        [self.delegate OSSMultipartListMultipartUploadsFinished:self result:result];
    }
}

-(void) OSSMultipartOperationListMultipartUploadsFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartListMultipartUploadsFailed:error:)]) {
        [self.delegate OSSMultipartListMultipartUploadsFailed:self error:error];
    }
}

-(void) OSSMultipartOperationListPartsFinished:(OSSMultipartOperation*)operation result:(PartListing*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartListPartsFinished:result:)]) {
        [self.delegate OSSMultipartListPartsFinished:self result:result];
    }

}

-(void) OSSMultipartOperationListPartsFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartListPartsFailed:error:)]) {
        [self.delegate OSSMultipartListPartsFailed:self error:error];
    }
}


-(void) OSSMultipartOperationUploadPartFinished:(OSSMultipartOperation*)operation result:(UploadPartResult*) result
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartUploadPartFinished:result:)]) {
        [self.delegate OSSMultipartUploadPartFinished:self result:result];
    }
}

-(void) OSSMultipartOperationUploadPartFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error
{
    if ([self.delegate respondsToSelector:@selector(OSSMultipartUploadPartFailed:error:)]) {
        [self.delegate OSSMultipartUploadPartFailed:self error:error];
    }
}


-(void) OSSObjectGroupOperationNetWorkFailed:(OSSObjectGroupOperation*)operation error:(OSSError *) erreor
{
    if ([self.delegate respondsToSelector:@selector(netWorkFailed:error:)]) {
        [self.delegate netWorkFailed:self error:erreor];
    }
}
-(void) OSSObjectGroupOperationPostObjectGroupFinish:(OSSObjectGroupOperation*)operation result:(PostObjectGroupResult *) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectGroupPostObjectGroupFinish:result:)]) {
        [self.delegate OSSObjectGroupPostObjectGroupFinish:self result:result];
    }
}
-(void) OSSObjectGroupOperationPostObjectGroupFailed:(OSSObjectGroupOperation*)operation error:(OSSError *) erreor
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectGroupPostObjectGroupFailed:error:)]) {
        [self.delegate OSSObjectGroupPostObjectGroupFailed:self error:erreor];
    }
}
-(void) OSSObjectGroupOperationFetchObjectGroupIndexFinish:(OSSObjectGroupOperation*)operation result:(FetchObjectGroupIndexResult *) result
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectGroupFetchObjectGroupIndexFinish:result:)]) {
        [self.delegate OSSObjectGroupFetchObjectGroupIndexFinish:self result:result];
    }
}
-(void) OSSObjectGroupOperationFetchObjectGroupIndexFailed:(OSSObjectGroupOperation*)operation error:(OSSError *) erreor
{
    if ([self.delegate respondsToSelector:@selector(OSSObjectGroupFetchObjectGroupIndexFailed:error:)]) {
        [self.delegate OSSObjectGroupFetchObjectGroupIndexFailed:self error:erreor];
    }
}
@end
