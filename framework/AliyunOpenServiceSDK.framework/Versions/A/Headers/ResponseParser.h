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
@class OSSError;
@class CannedAccessControlList;
@class ObjectListing;
@class PutObjectResult;
@class ObjectMetadata;
@class CopyObjectResult;
@class CompleteMultipartUploadResult;
@class InitiateMultipartUploadResult;
@class MultipartUploadListing;
@class PartListing;
@class PostObjectGroupResult;
@class FetchObjectGroupIndexResult;
/**
 ResponseParser 类，对响应结果处理的通用类
 */
@interface ResponseParser : NSObject
{
    
}
/**
 静态方法 从xml数据中生成错误信息
  @param data NSData
 */
+(OSSError *) parserOSSError:(NSData*) data;
/**
 静态方法 从xml数据中生成Bucklist
  @param data NSData
 */
+(NSArray *) parserBucklist:(NSData*) data;
/**
 静态方法 从xml数据中生成Bucklist
  @param data NSData
 */
+(CannedAccessControlList*) parserCannedAccessControlList:(NSData*) data;
/**
 静态方法 从xml数据中生成Bucklist
  @param data NSData
 */
+(ObjectListing*)parserObjectListing:(NSData*) data;
/**
 静态方法 从请求投中生成Object元数据
  @param headers NSMutableDictionary
 */

+(ObjectMetadata*)parserObjectMetadata:(NSMutableDictionary*)headers;
/**
 静态方法 从xml数据中生成CopyObjectResult
  @param data NSData
 */

+(CopyObjectResult*)parseCopyObjectResult:(NSData*) data;
/**
 静态方法 从xml数据中生成CompleteMultipartUploadResult
  @param data NSData
 */

+(CompleteMultipartUploadResult*)parseCompleteMultipartUpload:(NSData*) data;
/**
 静态方法 从xml数据中生成InitiateMultipartUploadResult
  @param data NSData
 */

+(InitiateMultipartUploadResult*)parseInitiateMultipartUpload:(NSData*) data;
/**
 静态方法 从xml数据中生成MultipartUploadListing
  @param data NSData
 */

+(MultipartUploadListing*)parseListMultipartUploads:(NSData*) data;
/**
 静态方法 从xml数据中生成PartList
  @param data NSData
 */

+(PartListing*)parsePartList:(NSData*) data;
/**
 静态方法 从xml数据中生成PostObjectGroupResult
  @param data NSData
 */

+(PostObjectGroupResult*)parsePostObjectGroupResult:(NSData*) data;
/**
 静态方法 从xml数据中生成FetchObjectGroupIndexResult
  @param data NSData
 */

+(FetchObjectGroupIndexResult*)parseFetchObjectGroupIndexResult:(NSData*) data;
@end
