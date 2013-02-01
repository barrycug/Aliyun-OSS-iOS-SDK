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
#import "OSSOperation.h"
@class OSSError;
@class Bucket;
@class OSSBucketOperation;
@class CannedAccessControlList;
@class ListObjectsRequest;
@class ObjectListing;
/**
  BucketOperation 代理协议，声明BucketOperation相关代理方法
 */
@protocol BucketOperationDelegate<NSObject>
//create 
/**
 create bucket成功 
 @param bucketOperation OSSBucketOperation
 @param bucket Bucket
 */
-(void)bucketOperationCreateFinish:(OSSBucketOperation*) bucketOperation result:(Bucket*) bucket;
/**
 create bucket失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationCreateFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;
//delete bucket
/**
 create bucket成功 
 @param bucketOperation OSSBucketOperation
 @param bucketName NSString
 */
-(void)bucketOperationDeleteFinish:(OSSBucketOperation*) bucketOperation result:(NSString*) bucketName;
/**
 delete bucket失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationDeleteFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;
//list 
/**
 list bucket成功 
 @param bucketOperation OSSBucketOperation
 @param bucketList NSArray<Bucket>
 */
-(void)bucketOperationListFinish:(OSSBucketOperation*) bucketOperation result:(NSArray*) bucketList;
/**
 list bucket失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationListFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;

//writeBucketAcl
//list 
/**
 writeBucketAcl成功 
 @param bucketOperation OSSBucketOperation
 @param cannedAcl CannedAccessControlList
 */
-(void)bucketOperationWriteBucketAclFinish:(OSSBucketOperation*) bucketOperation result:(CannedAccessControlList*) cannedAcl;
/**
 writeBucketAcl 失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationWriteBucketAclFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;

//readBucketAcl
/**
 readBucketAcl 成功 
 @param bucketOperation OSSBucketOperation
 @param cannedAcl CannedAccessControlList
 */
-(void)bucketOperationReadBucketAclFinish:(OSSBucketOperation*) bucketOperation result:(CannedAccessControlList*) cannedAcl;
/**
 readBucketAcl 失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationReadBucketAclFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;

//isBucketExist
/**
 isBucketExist 成功 
 @param bucketOperation OSSBucketOperation
 @param isBucketExist BOOL
 */
-(void)bucketOperationIsBucketExistFinish:(OSSBucketOperation*) bucketOperation result:(BOOL) isBucketExist;
/**
 isBucketExist 失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationIsBucketExistFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;
/**
 ListObjects 成功 
 @param bucketOperation OSSBucketOperation
 @param objectListing ObjectListing
 */
-(void)bucketOperationListObjectsFinish:(OSSBucketOperation*) bucketOperation result:(ObjectListing*) objectListing;
/**
 ListObjects 失败 
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void)bucketOperationListObjectsFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;
/**
 network 失败 http 请求错误 没有返回正确错误信息的其他错误
 @param bucketOperation OSSBucketOperation
 @param error OSSError
 */
-(void) bucketOperationNetWorkFailed:(OSSBucketOperation*) bucketOperation error:(OSSError*) error;
@end
/**
 OSSBucketOperation 类，Bucket相关操作类
 */
@interface OSSBucketOperation : OSSOperation
{
    id<BucketOperationDelegate> delegate;
}
/**
 BucketOperationDelegate代理对象
 */
@property(nonatomic,assign) id<BucketOperationDelegate> delegate;

/**
创建Bucket
 @param bucketName NSString
 */
-(void) createBucket:(NSString *) bucketName;
/**
 删除Bucket
 @param bucketName NSString
 */
-(void) deleteBucket:(NSString*) bucketName;
/**
 list Bucket
 */
-(void) listBuckets;
/**
 写Bucket的ACL
 @param bucketName NSString
  @param cannedAccessControlList CannedAccessControlList
 */
-(void) writeBucketAcl:(NSString*) bucketName  cannedAccessControlList:(CannedAccessControlList*) cannedAccessControlList;
/**
 读Bucket的ACL
 @param bucketName NSString
 */
-(void)readBucketAcl:(NSString *)bucketName;
/**
 Bucket是否存在
 @param bucketName NSString
 */
-(void)isBucketExist:(NSString*)bucketName;
/**
列出Bucket中的Objects
 @param listObjectsRequest ListObjectsRequest
 */
-(void) listObjects:(ListObjectsRequest*)listObjectsRequest;
@end
