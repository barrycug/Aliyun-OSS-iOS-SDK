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
/**
 ResponseHeaderOverrides 类，响应结果头
 */
@interface ResponseHeaderOverrides : NSObject
{
    @private
    NSString    *_contentType;
    NSString    *_contentLangauge;
    NSString    *_expires;
    NSString    *_cacheControl;
    NSString    *_contentDisposition;
    NSString    *_contentEncoding;
}
/**
 内容类型
 */
@property(nonatomic,retain)NSString    *contentType;
/**
 内容语言
 */
@property(nonatomic,retain)NSString    *contentLangauge;
/**
 过期时间
 */

@property(nonatomic,retain)NSString    *expires;
/**
 cacheControl
 */

@property(nonatomic,retain)NSString    *cacheControl;
/**
contentDisposition
 */

@property(nonatomic,retain)NSString    *contentDisposition;
/**
 内容编码
 */

@property(nonatomic,retain)NSString    *contentEncoding;
/**
 静态方法 返回RESPONSE_HEADER_CONTENT_TYPE的字符串
 */
+(NSString*)RESPONSE_HEADER_CONTENT_TYPE;
/**
 静态方法 返回RESPONSE_HEADER_CONTENT_LANGUAGE的字符串
 */
+(NSString*)RESPONSE_HEADER_CONTENT_LANGUAGE;
/**
 静态方法 返回RESPONSE_HEADER_EXPIRES的字符串
 */

+(NSString*)RESPONSE_HEADER_EXPIRES;
/**
 静态方法 返回RESPONSE_HEADER_CACHE_CONTROL的字符串
 */

+(NSString*)RESPONSE_HEADER_CACHE_CONTROL;
/**
 静态方法 返回RESPONSE_HEADER_CONTENT_DISPOSITION的字符串
 */

+(NSString*)RESPONSE_HEADER_CONTENT_DISPOSITION;
/**
 静态方法 返回RESPONSE_HEADER_CONTENT_ENCODING的字符串
 */

+(NSString*)RESPONSE_HEADER_CONTENT_ENCODING;


@end
