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

@class HttpClient;
@class ClientConfiguration;
@class ExecutionContext;
@class RequestMessage;
@class DefaultServiceClient;
@protocol IResultParser ;
@class OSSError;

 /**
 
 ServiceClientDelegate, DefaultServiceClient 实现的代理方法，用来响应ServiceClient发送的操作请求
 
 Version: 1.0
 */
@protocol ServiceClientDelegate <NSObject>

@required
/**
 serviceClient 请求成功
 @param defaultServiceClient DefaultServiceClient
 @param result id
 */
-(void)serviceClientRequestFinished:(DefaultServiceClient*)defaultServiceClient result:(id) result;
/**
 serviceClient 请求失败
 @param defaultServiceClient DefaultServiceClient
 @param error id
 */
-(void)serviceClientRequestFailed:(DefaultServiceClient*)defaultServiceClient error:(id) error;
@end
/**
 DefaultServiceClient类，实现基本的Web请求
 */
@interface DefaultServiceClient : NSObject
{
    @private
  //  HttpClient * _httpClient;
    ClientConfiguration *_config;
    int _retryCount;
    id<IResultParser> _resultParser;
    id<ServiceClientDelegate> delegate;
}
/**
 ServiceClientDelegate 代理对象
 */
@property(nonatomic,assign)id<ServiceClientDelegate> delegate;
/**
 初始化方法
 @param config ClientConfiguration
 */
-(id) initWithClientConfiguration:(ClientConfiguration*)config;
/**
 静态初始化方法 返回autorelease 对象
 @param config ClientConfiguration
 */
+(id) DefaultServiceClientWithClientConfiguration:(ClientConfiguration*)config ;

/**
 发送Web请求 resultParser参数暂不使用
 @param requestMessage RequestMessage
 @param executionContext executionContext
 @param resultParser id<IResultParser> 
 */
-(void) sendRequest:(RequestMessage*) requestMessage executionContext: (ExecutionContext*)executionContext resultParser:(id<IResultParser> )resultParser;
/**
 发送Web请求 
 @param requestMessage RequestMessage
 @param executionContext executionContext
 */
-(void) sendRequest:(RequestMessage*) requestMessage executionContext: (ExecutionContext*)executionContext;
@end
