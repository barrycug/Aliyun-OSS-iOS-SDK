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
#import "DefaultServiceClient.h"

@class ServiceCredentials;
@class DefaultServiceClient;

/**
 OSSOperation 类，OSS相关操作的基类实现基本的初始化工作和web请求发送工作
 */
@interface OSSOperation : NSObject<ServiceClientDelegate>
{
    @private
    NSString * _endpoint;
    ServiceCredentials *_credentials;
    DefaultServiceClient *_client;
}
/**
 初始化方法
 @param endpoint NSString
 @param credentials ServiceCredentials
  @param client DefaultServiceClient
 */
-(id) initWithEndPoint:(NSString * ) endpoint credentials:(ServiceCredentials *)credentials client:(DefaultServiceClient *)client;

/**
 发送web请求
 @param httpMethod HttpMethod
 @param buckName NSString
 @param objectName NSString
 @param headers NSMutableDictionary
 @param params NSMutableDictionary
 @param content NSData
 @param contentLength long
 @param userInfo NSDictionary
 */
-(void)request:(HttpMethod) httpMethod buckName:(NSString*) buckName objectName:(NSString*) objectName headers:(NSMutableDictionary*) headers   params:(NSMutableDictionary*) params  content:(NSData *) content  contentLength:(long) contentLength userInfo:(NSDictionary*)userInfo;
@end
