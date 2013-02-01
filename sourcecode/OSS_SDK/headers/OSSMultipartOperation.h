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
@class OSSMultipartOperation;
@class OSSError;
@class CompleteMultipartUploadResult;
@class InitiateMultipartUploadResult;
@class MultipartUploadListing;
@class PartListing;
@class UploadPartResult;
@class UploadPartRequest;
@class ListPartsRequest;
@class ListMultipartUploadsRequest;
@class InitiateMultipartUploadRequest;
@class CompleteMultipartUploadRequest;
@class AbortMultipartUploadRequest;
/**
 OSSMultipartOperationDelegate 协议，声明OSSMultipartOperation相关方法
 */
@protocol OSSMultipartOperationDelegate<NSObject>
/**
 network 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationNetWorkFailed:(OSSMultipartOperation*)operation error:(OSSError *) error;
/**
 AbortMultipartUpload 成功
 @param operation OSSMultipartOperation
 @param uploadId NSString
 */
-(void) OSSMultipartOperationAbortMultipartUploadFinished:(OSSMultipartOperation*)operation result:(NSString*) uploadId;
/**
 AbortMultipartUpload 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationAbortMultipartUploadFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error;
/**
 CompleteMultipartUpload 成功
 @param operation OSSMultipartOperation
 @param result CompleteMultipartUploadResult
 */
-(void) OSSMultipartOperationCompleteMultipartUploadFinished:(OSSMultipartOperation*)operation result:(CompleteMultipartUploadResult*) result;
/**
 CompleteMultipartUpload 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationCompleteMultipartUploadFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error;
/**
 InitiateMultipartUpload 成功
 @param operation OSSMultipartOperation
 @param result InitiateMultipartUploadResult
 */
-(void) OSSMultipartOperationInitiateMultipartUploadFinished:(OSSMultipartOperation*)operation result:(InitiateMultipartUploadResult*) result;
/**
 InitiateMultipartUpload 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationInitiateMultipartUploadFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error;
/**
 ListMultipartUploads 成功
 @param operation OSSMultipartOperation
 @param result MultipartUploadListing
 */
-(void) OSSMultipartOperationListMultipartUploadsFinished:(OSSMultipartOperation*)operation result:(MultipartUploadListing*) result;
/**
 ListMultipartUploads 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationListMultipartUploadsFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error;
/**
 ListParts 成功
 @param operation OSSMultipartOperation
 @param result PartListing
 */
-(void) OSSMultipartOperationListPartsFinished:(OSSMultipartOperation*)operation result:(PartListing*) result;
/**
 ListParts 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationListPartsFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error;
/**
 UploadPart 成功
 @param operation OSSMultipartOperation
 @param result UploadPartResult
 */
-(void) OSSMultipartOperationUploadPartFinished:(OSSMultipartOperation*)operation result:(UploadPartResult*) result;
/**
 UploadPart 失败
 @param operation OSSMultipartOperation
 @param error OSSError
 */
-(void) OSSMultipartOperationUploadPartFailed:(OSSMultipartOperation*)operation  error:(OSSError *) error;
@end
/**
 OSSMultipartOperation 类，多点上传相关操作类
 */
@interface OSSMultipartOperation : OSSOperation
{
      id<OSSMultipartOperationDelegate> delegate;
}
/**
 OSSMultipartOperationDelegate代理对象
 */
@property(nonatomic,assign) id<OSSMultipartOperationDelegate> delegate;

/**
 uploadPart
 @param uploadPartRequest UploadPartRequest
 */
-(void) uploadPart:(UploadPartRequest*) uploadPartRequest;
/**
 listParts
 @param listPartsRequest ListPartsRequest
 */
-(void) listParts:(ListPartsRequest*) listPartsRequest;
/**
 listMultipartUploads
 @param listMultipartUploadsRequest ListMultipartUploadsRequest
 */
-(void) listMultipartUploads:(ListMultipartUploadsRequest*)listMultipartUploadsRequest;
/**
 initiateMultipartUpload
 @param initiateMultipartUploadRequest InitiateMultipartUploadRequest
 */
-(void) initiateMultipartUpload:(InitiateMultipartUploadRequest*)initiateMultipartUploadRequest;
/**
 completeMultipartUpload
 @param completeMultipartUploadRequest CompleteMultipartUploadRequest
 */
-(void) completeMultipartUpload:(CompleteMultipartUploadRequest*)completeMultipartUploadRequest;
/**
 abortMultipartUpload
 @param abortMultipartUploadRequest AbortMultipartUploadRequest
 */
-(void) abortMultipartUpload:(AbortMultipartUploadRequest*) abortMultipartUploadRequest;
@end
