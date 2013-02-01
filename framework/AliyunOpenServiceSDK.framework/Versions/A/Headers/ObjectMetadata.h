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
 ObjectMetadata 类，Object元数据
 */
@interface ObjectMetadata : NSObject
{
@private
    NSMutableDictionary * _userMetadata;
    NSMutableDictionary * _metadata;
}
/**
 用户元数据
 */
@property(nonatomic,retain)NSMutableDictionary * userMetadata;
/**
 最近修改时间
 */
@property(nonatomic,retain)NSDate * lastModified;
/**
 过期时间
 */
@property(nonatomic,retain)NSDate * expirationTime;
/**
 内容长度
 */
@property(nonatomic,assign)long contentLength;
/**
 内容类型
 */
@property(nonatomic,retain)NSString*contentType;
/**
 内容编码
 */
@property(nonatomic,retain)NSString*contentEncoding;
/**
 cacheControl
 */
@property(nonatomic,retain)NSString*cacheControl;
/**
 contentDisposition
 */
@property(nonatomic,retain)NSString*contentDisposition;
/**
 eTag信息
 */
@property(nonatomic,retain,readonly)NSString*eTag;
/**
 元数据
 */
@property(nonatomic,retain,readonly)NSMutableDictionary*metadata;

/**
 添加请求头
 @param key NSString
 @param value NSString
 */
-(void) addHeader:(NSString*)key value:(id) value;
/**
 添加用户元数据
 @param key NSString
 @param value NSString
 */
-(void) addUserMetadata:(NSString*)key value:(NSString*) value;
@end
