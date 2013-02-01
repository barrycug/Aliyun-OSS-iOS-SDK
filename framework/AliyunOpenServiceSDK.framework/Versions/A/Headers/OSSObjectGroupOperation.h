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
@class OSSObjectGroupOperation;
@class OSSError;
@class PostObjectGroupResult;
@class PostObjectGroupRequest;
@class FetchObjectGroupIndexResult;
/**
 OSSObjectGroupOperationDelegate 协议，声明OSSObjectGroupOperation相关方法
 */
@protocol OSSObjectGroupOperationDelegate<NSObject>
/**
 network 失败
 @param operation OSSObjectGroupOperation
 @param error OSSError
 */
-(void) OSSObjectGroupOperationNetWorkFailed:(OSSObjectGroupOperation*)operation error:(OSSError *) error;
/**
 PostObjectGroup 成功
 @param operation OSSObjectGroupOperation
 @param result PostObjectGroupResult
 */
-(void) OSSObjectGroupOperationPostObjectGroupFinish:(OSSObjectGroupOperation*)operation result:(PostObjectGroupResult *) result;
/**
 PostObjectGroup 失败
 @param operation OSSObjectGroupOperation
 @param error OSSError
 */
-(void) OSSObjectGroupOperationPostObjectGroupFailed:(OSSObjectGroupOperation*)operation error:(OSSError *) error;
/**
 FetchObjectGroupIndex 成功
 @param operation OSSObjectGroupOperation
 @param result FetchObjectGroupIndexResult
 */
-(void) OSSObjectGroupOperationFetchObjectGroupIndexFinish:(OSSObjectGroupOperation*)operation result:(FetchObjectGroupIndexResult *) result;
/**
 FetchObjectGroupIndex 失败
 @param operation OSSObjectGroupOperation
 @param error OSSError
 */
-(void) OSSObjectGroupOperationFetchObjectGroupIndexFailed:(OSSObjectGroupOperation*)operation error:(OSSError *) error;

@end
/**
 OSSObjectGroupOperation 类，ObjectGroup相关操作类
 */
@interface OSSObjectGroupOperation : OSSOperation
{
    id<OSSObjectGroupOperationDelegate> delegate;
}
/**
 OSSObjectGroupOperationDelegate 代理对象
 */
@property(nonatomic,assign) id<OSSObjectGroupOperationDelegate> delegate;
/**
 提交ObjectGroup 
 @param postObjectGroupRequest PostObjectGroupRequest
 */
-(void) postObjectGroup:(PostObjectGroupRequest*)postObjectGroupRequest;
/**
 获取ObjectGroupIndex 
 @param bucketName NSString
 @param key NSString
 */
-(void)fetchObjectGroupIndex:(NSString*) bucketName key: (NSString*) key;
/**
 获取ObjectGroup 没有实现，请使用 fetchObject 方法
 @param bucketName NSString
 @param key NSString
 */

-(void) fetchObjectGroup:(NSString*) bucketName key: (NSString*) key;
/**
 获取ObjectGroup 没有实现，请使用 deleteObject 方法
 @param bucketName NSString
 @param key NSString
 */
-(void) deleteObjectGroup:(NSString*) bucketName key: (NSString*) key;

/**
 获取ObjectGroup 没有实现，请使用 fetchObjectMetadata 方法
 @param bucketName NSString
 @param key NSString
 */
-(void)fetchObjectGroupMetadata:(NSString*) bucketName key: (NSString*) key;

@end
