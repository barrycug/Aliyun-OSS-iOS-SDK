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
#import "HttpHeaders.h"
/**
 OSSHeaders 类定义了OSS相关自定义请求头
 */
@interface OSSHeaders : HttpHeaders
{
    
}
/**
 静态方法，返回OSS_PREFIX字符串
 */
+(NSString *)OSS_PREFIX;
/**
 静态方法，返回OSS_USER_METADATA_PREFIX字符串
 */
+(NSString *)OSS_USER_METADATA_PREFIX;
/**
 静态方法，返回OSS_CANNED_ACL字符串
 */
+(NSString *)OSS_CANNED_ACL;
/**
 静态方法，返回STORAGE_CLASS字符串
 */
+(NSString *)STORAGE_CLASS;
/**
 静态方法，返回OSS_VERSION_ID字符串
 */

+(NSString *)OSS_VERSION_ID;
/**
 静态方法，返回GET_OBJECT_IF_MODIFIED_SINCE字符串
 */

+(NSString *)GET_OBJECT_IF_MODIFIED_SINCE;
/**
 静态方法，返回GET_OBJECT_IF_UNMODIFIED_SINCE字符串
 */

+(NSString *)GET_OBJECT_IF_UNMODIFIED_SINCE;
/**
 静态方法，返回GET_OBJECT_IF_MATCH字符串
 */

+(NSString *)GET_OBJECT_IF_MATCH;
/**
 静态方法，返回GET_OBJECT_IF_NONE_MATCH字符串
 */

+(NSString *)GET_OBJECT_IF_NONE_MATCH;
/**
 静态方法，返回COPY_OBJECT_SOURCE字符串
 */

+(NSString *)COPY_OBJECT_SOURCE;
/**
 静态方法，返回COPY_OBJECT_SOURCE_IF_MATCH字符串
 */

+(NSString *)COPY_OBJECT_SOURCE_IF_MATCH;
/**
 静态方法，返回COPY_OBJECT_SOURCE_IF_NONE_MATCH字符串
 */

+(NSString *)COPY_OBJECT_SOURCE_IF_NONE_MATCH;
/**
 静态方法，返回COPY_OBJECT_SOURCE_IF_UNMODIFIED_SINCE字符串
 */

+(NSString *)COPY_OBJECT_SOURCE_IF_UNMODIFIED_SINCE;
/**
 静态方法，返回COPY_OBJECT_SOURCE_IF_MODIFIED_SINCE字符串
 */

+(NSString *)COPY_OBJECT_SOURCE_IF_MODIFIED_SINCE;
/**
 静态方法，返回COPY_OBJECT_METADATA_DIRECTIVE字符串
 */

+(NSString *)COPY_OBJECT_METADATA_DIRECTIVE;

@end
