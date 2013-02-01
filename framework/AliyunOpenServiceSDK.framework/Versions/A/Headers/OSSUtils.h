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
#import "HttpMethod.h"
#import "OrderedDictionary.h"
@class ObjectMetadata;
@class ResponseHeaderOverrides;
/**
 OSSUtils通用处理类
 */
@interface OSSUtils : NSObject
{
    
}
/**
静态方法，返回DEFAULT_OBJECT_CONTENT_TYPE对应的字符串
 */
+(NSString*)DEFAULT_OBJECT_CONTENT_TYPE;

/**
 静态方法 验证Bucket名称是否有效
 @param bucketName NSString
 */
+(BOOL)validateBucketName:(NSString* )bucketName;
/**
 静态方法 验证Object名称是否有效
 @param key NSString
 */
+(BOOL)validateObjectKey:(NSString*) key;
/**
 静态方法 构造ResourcePath
 @param buckeName NSString
  @param objectName NSString
 */
+(NSString*) makeResourcePath:(NSString*) buckeName objectName:(NSString*) objectName;
/**
 静态方法 生成请求的Metadata
 @param dict NSMutableDictionary
 @param objectMetadata ObjectMetadata
 */
+(void)populateRequestMetadata:(NSMutableDictionary *) dict  objectMetadata:(ObjectMetadata *)objectMetadata;
/**
 静态方法 添加时间类型的头
 @param headers NSMutableDictionary
 @param key NSString
  @param date NSDate
 */
+(void) addDateHeader:(NSMutableDictionary *) headers key:(NSString*) key value:(NSDate*)  date;
/**
 静态方法 添加列表类型的头
 @param headers NSMutableDictionary
 @param key NSString
 @param list NSArray
 */
+(void) addListHeader:(NSMutableDictionary *) headers key:(NSString*)key value:(NSArray*)  list;
/**
 静态方法 去除字符串首尾的"号
 @param string NSString
 */
+(NSString*) trimQuotes:(NSString *)string;
/**
 静态方法 获取响应头的参数
 @param responseHeaderOverrides ResponseHeaderOverrides
 */
+(OrderedDictionary*) getResponseHeaderParameters:(ResponseHeaderOverrides*) responseHeaderOverrides;
/**
 静态方法 HttpMethod类型转成对应的String
 @param httpMethod HttpMethod
 */
+(NSString*) HttpMethod2String:(HttpMethod) httpMethod;

@end
