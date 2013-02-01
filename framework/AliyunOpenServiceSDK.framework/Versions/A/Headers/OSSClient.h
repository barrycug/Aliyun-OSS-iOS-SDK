/*
 Copyright 2012 baocai zhang. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE FREEBSD PROJECT ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE FREEBSD PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.
 */
/*!
 OSSClient 
 */

/*
 @author baocai zhang
 website:www.giser.net
 email:zhangbaocaicug@gmail.com
 */
#import <Foundation/Foundation.h>
@class ClientConfiguration;
@class ServiceCredentials;
@class DefaultServiceClient;
@class OSSBucketOperation;
@class CannedAccessControlList;
@class ListObjectsRequest;
@class OSSObjectOperation;
@class ObjectMetadata;
@class FetchObjectRequest;
@class CopyObjectRequest;
@class OSSMultipartOperation;
@class UploadPartRequest;
@class ListPartsRequest;
@class ListMultipartUploadsRequest;
@class InitiateMultipartUploadRequest;
@class CompleteMultipartUploadRequest;
@class AbortMultipartUploadRequest;
@class PostObjectGroupRequest;
@class OSSObjectGroupOperation;
@class OSSClient;
@class Bucket;
@class OSSError;
@class ObjectListing;
@class PutObjectResult;
@class OSSObject;
@class CopyObjectResult;
@class DeleteObjectsResult;
@class CompleteMultipartUploadResult;
@class InitiateMultipartUploadResult;
@class MultipartUploadListing;
@class PartListing;
@class UploadPartResult;
@class PostObjectGroupResult;
@class FetchObjectGroupIndexResult;
/**
 
 OSSClientDelegate, OSSClient 实现的代理方法，用来响应OSSClient发送的操作请求
 
 Version: 1.0
 */
@protocol OSSClientDelegate <NSObject>
@optional
/**
 网络请求失败
 @param client OSSClient 
 @param error OSSError 
 */
-(void)netWorkFailed:(OSSClient*) client error:(OSSError*) error;
/**
 bucket 创建成功，返回创建好的bucket对象
 @param client OSSClient 
 @param bucket Bucket 
 */
-(void)bucketCreateFinish:(OSSClient*) client result:(Bucket*) bucket;
/**
 bucket 创建失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketCreateFailed:(OSSClient*) client error:(OSSError*) error;
/**
 bucket 删除成功，返回删除的bucket名称
@param client OSSClient 
@param bucketName NSString
 */
-(void)bucketDeleteFinish:(OSSClient*) client result:(NSString*) bucketName;
/**
 bucket 删除失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketDeleteFailed:(OSSClient*) client error:(OSSError*) error;
/**
 获取bucket list 成功，返回获取到的bucket list 数据，数组内的类型为Bucket
@param client OSSClient 
@param bucketList NSArray
 */
-(void)bucketListFinish:(OSSClient*) client result:(NSArray*) bucketList;
/**
获取bucket list 失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketListFailed:(OSSClient*) client error:(OSSError*) error;
/**
 写Bucket Acl成功，返回获取到的Canned Access Control List 数据
@param client OSSClient 
@param result CannedAccessControlList
 */
-(void)bucketWriteBucketAclFinish:(OSSClient*) client result:(CannedAccessControlList*) result;
/**
 写Bucket Acl失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketWriteBucketAclFailed:(OSSClient*) client error:(OSSError*) error;
/**
 读Bucket Acl成功，返回获取到的Canned Access Control List 数据
@param client OSSClient 
@param result CannedAccessControlList
 */
-(void)bucketReadBucketAclFinish:(OSSClient*) client result:(CannedAccessControlList*) result;
/**
 读Bucket Acl失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketReadBucketAclFailed:(OSSClient*) client error:(OSSError*) error;
/**
 获取bucket是否存在 方法执行成功，返回是否存在该bucket 
@param client OSSClient 
@param isBucketExist BOOL
 */
-(void)bucketIsBucketExistFinish:(OSSClient*) client result:(BOOL) isBucketExist;
/**
 获取bucket是否存在 方法执行失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketIsBucketExistFailed:(OSSClient*) client error:(OSSError*) error;
/**
 ListObjects 方法执行成功，返回ObjectListing 对象
@param client OSSClient 
@param result ObjectListing
 */
-(void)bucketListObjectsFinish:(OSSClient*) client result:(ObjectListing*) result;
/**
 ListObjects 方法执行失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)bucketListObjectsFailed:(OSSClient*) client error:(OSSError*) error;
/**
  PutObject 方法执行成功，返回ObjectListing 对象 
@param client OSSClient 
@param result PutObjectResult
 */
-(void)OSSObjectPutObjectFinish:(OSSClient*) client result:(PutObjectResult*) result;
/**
 PutObject 方法执行失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectPutObjectFailed:(OSSClient*) client error:(OSSError*) error;
/**
 FetchObject 方法执行成功，返回OSSObject 对象 
@param client OSSClient 
@param result OSSObject
 */
-(void)OSSObjectFetchObjectFinish:(OSSClient*) client result:(OSSObject*) result;
/**
 FetchObject 方法执行失败，返回OSSError 对象 
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectFetchObjectFailed:(OSSClient*) client error:(OSSError*) error;
/**
 FetchObjectAndWriteToFile 方法执行成功，返回OSSObject 对象 和isWritedToFile对象
@param client OSSClient 
@param result OSSObject
 @param isWritedToFile BOOL
 */
-(void)OSSObjectFetchObjectAndWriteToFileFinish:(OSSClient*) client result:(OSSObject*) result isWritedToFile:(BOOL)isWritedToFile ;
/**
 FetchObjectAndWriteToFile 方法执行失败，返回OSSError 对象 
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectFetchObjectAndWriteToFileFailed:(OSSClient*) client error:(OSSError*) error;
/**
 FetchObjectMetadata 方法执行成功，返回ObjectMetadata 对象 
@param client OSSClient 
@param result ObjectMetadata
 */
-(void)OSSObjectFetchObjectMetadataFinish:(OSSClient*) client result:(ObjectMetadata*) result;
/**
 FetchObjectMetadata 方法执行失败，返回OSSError 对象 
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectFetchObjectMetadataFailed:(OSSClient*) client error:(OSSError*) error;
/**
 CopyObject 方法执行成功，返回CopyObjectResult 对象 
@param client OSSClient 
@param result CopyObjectResult
 */
-(void)OSSObjectCopyObjectFinish:(OSSClient*) client result:(CopyObjectResult*) result;
/**
 CopyObject 方法执行失败，返回OSSError 对象  
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectCopyObjectFailed:(OSSClient*) client error:(OSSError*) error;
/**
 DeleteObject 方法执行成功，返回删除的bucketName 和key
 @param client OSSClient 
 @param bucketName  NSString
 @param key  NSString
 */
-(void)OSSObjectDeleteObjectFinish:(OSSClient*) client bucketName:(NSString*) bucketName key:(NSString*)key;
/**
 DeleteObject 方法执行失败，返回OSSError 对象  
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectDeleteObjectFailed:(OSSClient*) client error:(OSSError*) error;
/**
 DeleteMultipleObjects 方法执行成功，返回DeleteObjectsResult对象
@param client OSSClient 
@param result DeleteObjectsResult
 @param bucketName NSString
 */
-(void)OSSObjectDeleteMultipleObjectsFinish:(OSSClient*) client  bucketName:(NSString*) bucketName result:(DeleteObjectsResult*) result;
/**
 DeleteMultipleObjects 方法执行失败，返回OSSError 对象  
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectDeleteMultipleObjectsFailed:(OSSClient*) client error:(OSSError*) error;

/**
 AbortMultipartUpload 方法执行成功，返回uploadId
@param client OSSClient 
@param uploadId NSString
 */
-(void) OSSMultipartAbortMultipartUploadFinished:(OSSClient*) client result:(NSString*) uploadId;
/**
 AbortMultipartUpload 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartAbortMultipartUploadFailed:(OSSClient*) client error:(OSSError *) error;
/**
 CompleteMultipartUpload 方法执行成功，返回CompleteMultipartUploadResult 对象
@param client OSSClient 
@param result CompleteMultipartUploadResult
 */
-(void) OSSMultipartCompleteMultipartUploadFinished:(OSSClient*) client result:(CompleteMultipartUploadResult*) result;
/**
 CompleteMultipartUpload 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartCompleteMultipartUploadFailed:(OSSClient*) client  error:(OSSError *) error;
/**
 InitiateMultipartUpload 方法执行成功，返回InitiateMultipartUploadResult 对象
@param client OSSClient 
@param result InitiateMultipartUploadResult
 */
-(void) OSSMultipartInitiateMultipartUploadFinished:(OSSClient*) client result:(InitiateMultipartUploadResult*) result;
/**
 InitiateMultipartUpload 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartInitiateMultipartUploadFailed:(OSSClient*) client  error:(OSSError *) error;
/**
 ListMultipartUploads 方法执行成功，返回MultipartUploadListing 对象
@param client OSSClient 
@param result MultipartUploadListing
 */
-(void) OSSMultipartListMultipartUploadsFinished:(OSSClient*) client result:(MultipartUploadListing*) result;
/**
 ListMultipartUploads 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartListMultipartUploadsFailed:(OSSClient*) client  error:(OSSError *) error;
/**
 ListParts 方法执行成功，返回PartListing 对象 
@param client OSSClient 
@param result PartListing
 */
-(void) OSSMultipartListPartsFinished:(OSSClient*) client result:(PartListing*) result;
/**
 ListParts 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartListPartsFailed:(OSSClient*) client  error:(OSSError *) error;
/**
 UploadPart 方法执行成功，返回UploadPartResult 对象
@param client OSSClient 
@param result UploadPartResult
 */
-(void) OSSMultipartUploadPartFinished:(OSSClient*) client result:(UploadPartResult*) result;
/**
 UploadPart 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartUploadPartFailed:(OSSClient*) client  error:(OSSError *) error;
/**
 GroupPostObject 方法执行成功，返回PostObjectGroupResult 对象
 @param client OSSClient 
 @param result PostObjectGroupResult 
 */
-(void) OSSObjectGroupPostObjectGroupFinish:(OSSClient*) client result:(PostObjectGroupResult *) result;
/**
 GroupPostObject 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSObjectGroupPostObjectGroupFailed:(OSSClient*) client error:(OSSError *) error;
/**
 FetchObjectGroupIndex 方法执行成功，返回FetchObjectGroupIndex 对象
 @param client OSSClient 
 @param result FetchObjectGroupIndexResult 
 */
-(void) OSSObjectGroupFetchObjectGroupIndexFinish:(OSSClient*) client result:(FetchObjectGroupIndexResult *) result;
/**
 FetchObjectGroupIndex 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSObjectGroupFetchObjectGroupIndexFailed:(OSSClient*) client error:(OSSError *) error;

@end
/**
 OSSClient ,OSS SDK 的核心类，用来对Bucket，Object等对象进行操作，所有的API功能都通过该类调用
 */
@interface OSSClient : NSObject
{
@private

    NSString * _endPoint;
    ClientConfiguration *_config;
    ServiceCredentials *_credentials ;
    DefaultServiceClient *_serviceClientBucket;
    DefaultServiceClient *_serviceClientObject;
    DefaultServiceClient *_serviceClientMultipart;
    DefaultServiceClient *_serviceClientObjectGroup;
    OSSBucketOperation *_ossBucketOperation;
    OSSObjectOperation *_ossObjectOperation;
    OSSMultipartOperation *_ossMultipartOperation;
    OSSObjectGroupOperation *_ossObjectGroupOperation;
    id<OSSClientDelegate> delegate;
    
 }
/**
OSSClientDelegate 代理对象
 */
@property(nonatomic,assign)id<OSSClientDelegate> delegate; 

/**
 初始化方法
 @param accessID NSString
 @param accessKey NSString
 */
-(id) initWithAccessId:(NSString * ) accessID 
          andAccessKey:(NSString * )accessKey;
/**
 初始化方法 
 @param endpoint NSString
 @param accessID NSString
  @param accessKey NSString
 */
-(id) initWithEndPoint:(NSString * ) endpoint 
              AccessId:(NSString * ) accessID 
          andAccessKey:(NSString * )accessKey;
/**
 初始化方法
 @param endpoint NSString
 @param accessID NSString
 @param accessKey NSString
 @param config ClientConfiguration
 */
-(id) initWithEndPoint:(NSString * ) endpoint 
              AccessId:(NSString * ) accessID 
          andAccessKey:(NSString * )accessKey 
             andConfig:(ClientConfiguration *)config;
/**
 静态初始化方法 返回autorelease 对象
 @param accessID NSString
 @param accessKey NSString
 */
+(id) OSSClientWithAccessId:(NSString * ) accessID 
               andAccessKey:(NSString * )accessKey;
/**
 静态初始化方法 返回autorelease 对象 
 @param endpoint NSString
 @param accessID NSString
 @param accessKey NSString
 */
+(id) OSSClientWithEndPoint:(NSString * ) endpoint 
                   AccessId:(NSString * ) accessID 
               andAccessKey:(NSString * )accessKey;
/**
 静态初始化方法 返回autorelease 对象 
 @param endpoint NSString
 @param accessID NSString
 @param accessKey NSString
 @param config ClientConfiguration
 */
+(id)  OSSClientWithEndPoint:(NSString * ) endpoint 
                    AccessId:(NSString * ) accessID 
                andAccessKey:(NSString * )accessKey 
                   andConfig:(ClientConfiguration *)config;

/**
 创建bucket
 @param bucketName NSString
 */
-(void) createBucket:(NSString *) bucketName;
/**
 删除bucket
 @param bucketName NSString
 */
-(void) deleteBucket:(NSString*) bucketName;
/**
  list bucket
 */
-(void) listBuckets;
/**
 写 bucket 的 AccessControlList
 在ios中 get set开头的默认为属性的方法，所以此处改为read/write ,分别对应文档中的setBucketAcl 和getBucketAcl方法
 @param bucketName NSString
 @param cannedAccessControlList CannedAccessControlList
 */
-(void) writeBucketAcl:(NSString*) bucketName  cannedAccessControlList:(CannedAccessControlList*) cannedAccessControlList;
/**
  读 bucket 的 AccessControlList
  在ios中 get set开头的默认为属性的方法，所以此处改为read/write ,分别对应文档中的setBucketAcl 和getBucketAcl方法
 @param bucketName NSString
 */
-(void)readBucketAcl:(NSString *)bucketName;
/**
 查询bucket是否存在
 @param bucketName NSString
 */
-(void)isBucketExist:(NSString*)bucketName;
/**
 list Objects
 @param listObjectsRequest ListObjectsRequest
 */
-(void) listObjects:(ListObjectsRequest*)listObjectsRequest;
/**
 上传 object
 @param bucketName NSString
 @param key NSString
  @param data NSData
  @param objectMetadata ObjectMetadata
 */
-(void) putObject:(NSString*) bucketName 
                            key: (NSString*) key 
                           data:(NSData*) data  
                 objectMetadata:(ObjectMetadata*) objectMetadata;
/**
 获取object
 @param bucketName NSString
 @param key NSString
 */
-(void)fetchObject:(NSString*) bucketName key: (NSString*) key;
/**
 获取object
 @param fetchObjectRequest FetchObjectRequest
 */
-(void)fetchObject:(FetchObjectRequest*)  fetchObjectRequest;
/**
 获取object 并写到文件中
 @param fetchObjectRequest FetchObjectRequest
  @param filePath NSString
 */
-(void)fetchObject:(FetchObjectRequest *)  fetchObjectRequest  file:(NSString*) filePath;
/**
 获取Object元数据
 @param bucketName NSString
 @param key NSString
 */
-(void)fetchObjectMetadata:(NSString*) bucketName key: (NSString*) key;
/**
 拷贝object
 @param copyObjectRequest CopyObjectRequest
 */
-(void)copyObject:(CopyObjectRequest*)copyObjectRequest;
/**
 删除object
 @param bucketName NSString
 @param key NSString
 */
-(void)deleteObject:(NSString*) bucketName key: (NSString*) key;
/**
 删除多个object
 @param bucketName NSString
 @param objectNames NSArray
 @param isQuiet BOOL
 */
-(void)deleteMultipleObjects:(NSString*) bucketName objectNames:(NSArray*)objectNames isQuiet:(BOOL)isQuiet;
/**
 多点上传 上传其中的一部分
 @param uploadPartRequest UploadPartRequest
 */
-(void) uploadPart:(UploadPartRequest*) uploadPartRequest;
/**
 多点上传 列出单个Object上传的部分
 @param listPartsRequest ListPartsRequest
 */
-(void) listParts:(ListPartsRequest*) listPartsRequest;
/**
 多点上传 列出所有Object上传的部分
 @param listMultipartUploadsRequest ListMultipartUploadsRequest
 */
-(void) listMultipartUploads:(ListMultipartUploadsRequest*)listMultipartUploadsRequest;
/**
 多点上传 初始化多点上传请求
 @param initiateMultipartUploadRequest InitiateMultipartUploadRequest
 */
-(void) initiateMultipartUpload:(InitiateMultipartUploadRequest*)initiateMultipartUploadRequest;
/**
 多点上传 完成多点上传请求
 @param completeMultipartUploadRequest CompleteMultipartUploadRequest
 */
-(void) completeMultipartUpload:(CompleteMultipartUploadRequest*)completeMultipartUploadRequest;
/**
 多点上传 取消多点上传请求
 @param abortMultipartUploadRequest AbortMultipartUploadRequest
 */
-(void) abortMultipartUpload:(AbortMultipartUploadRequest*) abortMultipartUploadRequest;

/**
  提交 Object Group
 @param postObjectGroupRequest PostObjectGroupRequest
 */
-(void) postObjectGroup:(PostObjectGroupRequest*)postObjectGroupRequest;
/**
 获取 Object Group索引
 @param bucketName NSString
 @param key NSString
 */
-(void)fetchObjectGroupIndex:(NSString*) bucketName key: (NSString*) key;
@end
