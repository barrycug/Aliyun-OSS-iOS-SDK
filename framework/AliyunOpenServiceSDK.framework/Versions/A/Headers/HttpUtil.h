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
#import "OrderedDictionary.h"
/**
 Http相关通用处理操作类
 */
@interface HttpUtil : NSObject
{
  
}
/**
 单例模式，获取HttpUtil实例
 */
+(id) defaultHttpUtil;
/**
 静态方法，返回ISO_8859_1_CHARSET 字符集对应的字符串
 */
+(NSString*)ISO_8859_1_CHARSET;
/**
 静态方法，返回ISO_8859_1_CHARSET 字符集对应的NSStringEncoding
 */
+(NSStringEncoding)ISO_8859_1_CHARSET_OBJC;

/**
 url 编码
 @param url NSString
 @param encoding NSStringEncoding
 */
+(NSString*) urlEncode:(NSString*) url encoding:(NSStringEncoding) encoding;
/**
 http请求参数转换成字符串
 @param paramDict NSDictionary
 @param encoding NSStringEncoding
 */
+(NSString*) paramToQueryString:(NSDictionary*) paramDict encoding:(NSStringEncoding) encoding;
/**
 http请求参数转换成字符串
 @param paramDict NSDictionary
 @param encoding NSStringEncoding
 */
+(NSString*) paramToQueryStringOrder:(OrderedDictionary*) paramDict encoding:(NSStringEncoding) encoding;
/**
 静态方法，将http头的字符编码由Iso88591转成UTF-8
  @param paramDict NSDictionary
 */
+(void)convertHeaderCharsetFromIso88591:(NSMutableDictionary*) paramDict;
/**
 静态方法，将http头的字符编码由UTF-8转成Iso88591
 @param paramDict NSDictionary
 */
+(void)convertHeaderCharsetToIso88591:(NSMutableDictionary*) paramDict;
/**
 静态方法，将http头的字符编码进行转换
 @param paramDict NSDictionary
  @param encodingFrom NSStringEncoding
  @param encodingTo NSStringEncoding
 */
+(void)convertHeaderCharset:(NSMutableDictionary*) paramDict encodingFrom: (NSStringEncoding) encodingFrom encodingTo: (NSStringEncoding) encodingTo;
@end
