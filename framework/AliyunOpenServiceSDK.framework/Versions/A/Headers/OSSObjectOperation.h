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
#import <Foundation/Foundation.h>
#import "OSSOperation.h"
#import "OSSError.h"

@class OSSObjectOperation;
@class ObjectMetadata;
@class PutObjectResult;
@class OSSObject;
@class FetchObjectRequest;
@class ObjectMetadata;
@class CopyObjectRequest;
@class CopyObjectResult;
@class DeleteObjectsResult;
/**
 OSSObjectOperationDelegate 协议，声明OSSObjectOperation相关方法
 */
@protocol OSSObjectOperationDelegate<NSObject>
/**
PutObject 成功
 @param ossObjectOperation OSSObjectOperation
 @param result PutObjectResult
 */
-(void)OSSObjectOperationPutObjectFinish:(OSSObjectOperation*) ossObjectOperation result:(PutObjectResult*) result;
/**
 PutObject 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationPutObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;
//fetchObject
/**
 fetchObject 成功
 @param ossObjectOperation OSSObjectOperation
 @param result OSSObject
 */
-(void)OSSObjectOperationFetchObjectFinish:(OSSObjectOperation*) ossObjectOperation result:(OSSObject*) result;
/**
 FetchObject 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationFetchObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;
//fetchObject write to file
/**
 FetchObjectAndWriteToFile 成功
 @param ossObjectOperation OSSObjectOperation
 @param result OSSObject
 @param isWritedToFile BOOL
 */
-(void)OSSObjectOperationFetchObjectAndWriteToFileFinish:(OSSObjectOperation*) ossObjectOperation result:(OSSObject*) result isWritedToFile:(BOOL)isWritedToFile ;
/**
 FetchObjectAndWriteToFile 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */

-(void)OSSObjectOperationFetchObjectAndWriteToFileFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error  ;
/**
 fetchObject Metadata成功
 @param ossObjectOperation OSSObjectOperation
 @param result ObjectMetadata
 */
//fetchObject Metadata
-(void)OSSObjectOperationFetchObjectMetadataFinish:(OSSObjectOperation*) ossObjectOperation result:(ObjectMetadata*) result;
/**
 FetchObjectMetadata 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationFetchObjectMetadataFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;

/**
 CopyObject成功
 @param ossObjectOperation OSSObjectOperation
 @param result CopyObjectResult
 */
-(void)OSSObjectOperationCopyObjectFinish:(OSSObjectOperation*) ossObjectOperation result:(CopyObjectResult*) result;
/**
 CopyObject 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationCopyObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;

//deleteObject 
/**
 deleteObject成功
 @param ossObjectOperation OSSObjectOperation
 @param bucketName NSString
  @param key NSString
 */
-(void)OSSObjectOperationDeleteObjectFinish:(OSSObjectOperation*) ossObjectOperation bucketName:(NSString*) bucketName key:(NSString*)key;
/**
 DeleteObject 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationDeleteObjectFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;

//deleteMultipleObjects 
/**
 deleteMultipleObjects成功
 @param ossObjectOperation OSSObjectOperation
 @param bucketName NSString
 @param result DeleteObjectsResult
 */
-(void)OSSObjectOperationDeleteMultipleObjectsFinish:(OSSObjectOperation*) ossObjectOperation  bucketName:(NSString*) bucketName result:(DeleteObjectsResult*) result;
/**
 DeleteMultipleObject 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationDeleteMultipleObjectsFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;

//network failed
/**
 network 失败
 @param ossObjectOperation OSSObjectOperation
 @param error OSSError
 */
-(void)OSSObjectOperationNetWorkFailed:(OSSObjectOperation*) ossObjectOperation error:(OSSError*) error;
@end
/**
 OSSObjectOperation 类，Object相关操作类
 */
@interface OSSObjectOperation : OSSOperation
{
    id<OSSObjectOperationDelegate> delegate;
}
/**
 OSSObjectOperationDelegate 代理对象
 */
@property(nonatomic,assign) id<OSSObjectOperationDelegate> delegate;

/**
 putObject
 @param bucketName NSString
 @param key NSString
  @param data NSData
 @param objectMetadata ObjectMetadata
 */
-(void) putObject:(NSString*) bucketName 
              key: (NSString*) key 
             data:(NSData*) data  
   objectMetadata:(ObjectMetadata*) objectMetadata;
//
/**
 fetchObject
 原API中为getObject，此处get与ios的属性语义冲突，因此改为fetchObject
 @param bucketName NSString
 @param key NSString

 */
-(void)fetchObject:(NSString*) bucketName key: (NSString*) key;
/**
 fetchObject
 原API中为getObject，此处get与ios的属性语义冲突，因此改为fetchObject
 @param fetchObjectRequest FetchObjectRequest
 */
-(void)fetchObject:(FetchObjectRequest*)  fetchObjectRequest;
/**
 fetchObject 并写入文件
 原API中为getObject，此处get与ios的属性语义冲突，因此改为fetchObject
 @param fetchObjectRequest FetchObjectRequest
  @param filePath NSString
 */
-(void)fetchObject:(FetchObjectRequest *)  fetchObjectRequest  file:(NSString*) filePath;
/**
 fetchObjectMetadata
 @param bucketName NSString
 @param key NSString
 */
-(void)fetchObjectMetadata:(NSString*) bucketName key: (NSString*) key;
/**
 copyObject
 @param  copyObjectRequest CopyObjectRequest
 */
-(void)copyObject:(CopyObjectRequest*)copyObjectRequest;
/**
 deleteObject
 @param bucketName NSString
 @param key NSString
 */
-(void)deleteObject:(NSString*) bucketName key: (NSString*) key;
/**
 deleteMultipleObjects
 @param bucketName NSString
 @param objectNames NSArray
  @param isQuiet BOOL
 */
-(void)deleteMultipleObjects:(NSString*) bucketName objectNames:(NSArray*)objectNames isQuiet:(BOOL)isQuiet;
@end
