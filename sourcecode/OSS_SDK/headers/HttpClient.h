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
@class ASIHTTPRequest;
@class ClientConfiguration;
@class Request;
@class ExecutionContext;
@class HttpClient;
@class ResponseMessage;
@class ExecutionContext;
@class Request;
/**
 HttpClientDelegate HttpClient代理，用来声明HttpClient请求的响应方法
 */
@protocol HttpClientDelegate <NSObject>
@required
/**
 HttpClient请求成功
 @param httpClient HttpClient
 @param responseMessage ResponseMessage
 */
-(void) httpClientFinished:(HttpClient*) httpClient responseMessage:(ResponseMessage*)responseMessage; 
/**
 HttpClient请求失败
 @param httpClient HttpClient
 @param responseMessage ResponseMessage
 */
-(void) httpClientFailed:(HttpClient*) httpClient responseMessage:(ResponseMessage*)responseMessage;
@end
/**
 HttpClient 实现Http相关操作
 */
@interface HttpClient : NSObject
{
@private
    ASIHTTPRequest *_asirequest;
    id<HttpClientDelegate> delegate;
    ExecutionContext* _executionContext;
    Request         *_request;
    NSDictionary    *_userInfo;
}
/**
 HttpClientDelegate 代理对象
 */
@property(nonatomic,assign)id<HttpClientDelegate> delegate;
/**
 ExecutionContext 对象
 */
@property(nonatomic,retain,readonly)ExecutionContext* executionContext;
/**
 Request 对象
 */
@property(nonatomic,retain,readonly)Request         *request;
/**
 用户自定义信息，用于在请求和响应直接传递信息
 */
@property(nonatomic,retain)NSDictionary    *userInfo;
/**
 初始化方法
 @param clientConfiguration ClientConfiguration
 @param request Request
 @param executionContext ExecutionContext
 */
-(id) initWithClientConfiguration:(ClientConfiguration*) clientConfiguration request:(Request*) request executionContext: (ExecutionContext*) executionContext;
/**
 静态初始化方法 返回autorelease 对象
 @param clientConfiguration ClientConfiguration
 @param request Request
 @param executionContext ExecutionContext
 */
+(id) HttpClientWithClientConfiguration:(ClientConfiguration*) clientConfiguration request:(Request*) request executionContext: (ExecutionContext*) executionContext;

/**
 执行web请求操作
 */
-(void) excute;
@end
