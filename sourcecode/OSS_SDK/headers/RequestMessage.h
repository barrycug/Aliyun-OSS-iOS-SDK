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
#import "HttpMesssage.h"
#import "HttpMethod.h"
#import "OrderedDictionary.h"
/**
 RequestMessage 类，构造web请求头信息
 */
@interface RequestMessage : HttpMesssage
{
@private
    HttpMethod _method;
    NSString *_endpoint;
    NSString *_resourcePath;
    OrderedDictionary *_parameters;
    NSDictionary *_userInfo;
}
/**
 请求方法
 */
@property(nonatomic,assign) HttpMethod method;
/**
 url地址
 */
@property(nonatomic,retain) NSString *endpoint;
/**
请求资源路径
 */
@property(nonatomic,retain) NSString *resourcePath;
/**
 请求参数
 */
@property(nonatomic,retain) OrderedDictionary *parameters;
/**
 用户自定义信息
 */
@property(nonatomic,retain) NSDictionary *userInfo;
/**
 能否重复请求
 */
-(BOOL)  isRepeatable ;
@end
