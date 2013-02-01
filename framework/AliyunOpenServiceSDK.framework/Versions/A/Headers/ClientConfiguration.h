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
 ClientConfiguration类，存储客户端相关参数
 */
@interface ClientConfiguration : NSObject
{
@private
    int         _connectionTimeout;// 建立连接的超时时间（单位：毫秒）。
    int         _maxConnections;//允许打开的最大HTTP连接数。   
    int         _maxErrorRetry;//一个值表示当可重试的请求失败后最大的重试次数。    
    NSString   *_proxyDomain;// 访问NTLM验证的代理服务器的Windows域名（可选）。  
    NSString   *_proxyHost;   //代理服务器主机地址。  
    NSString   *_proxyPassword; //代理服务器验证的密码。
    int         _proxyPort; //返回代理服务器端口。    
    NSString   *_proxyUsername; //代理服务器验证的用户名。    
    NSString   *_proxyWorkstation;//NTLM代理服务器的Windows工作站名称。    
    int         _socketTimeout; //通过打开的连接传输数据的超时时间（单位：毫秒）。    
    NSString   *_userAgent;  //用户代理。
}
/**
 建立连接的超时时间（单位：毫秒）
 */
@property(nonatomic,assign) int         connectionTimeout;
/**
 允许打开的最大HTTP连接数
 */
@property(nonatomic,assign) int         maxConnections;
/**
 一个值表示当可重试的请求失败后最大的重试次数。
 */
@property(nonatomic,assign) int         maxErrorRetry;
/**
 访问NTLM验证的代理服务器的Windows域名（可选）。
 */
@property(nonatomic,retain) NSString	*proxyDomain;
/**
 代理服务器主机地址。
 */
@property(nonatomic,retain) NSString	*proxyHost; 
/**
 代理服务器验证的密码
 */
@property(nonatomic,retain) NSString	*proxyPassword;
/**
 返回代理服务器端口
 */
@property(nonatomic,assign) int         proxyPort; 
/**
 代理服务器验证的用户名
 */
@property(nonatomic,retain) NSString	*proxyUsername; 
/**
NTLM代理服务器的Windows工作站名称。
 */
@property(nonatomic,retain) NSString	*proxyWorkstation;
/**
 通过打开的连接传输数据的超时时间（单位：毫秒）。
 */
@property(nonatomic,assign) int         socketTimeout; 
/**
 用户代理。
 */
@property(nonatomic,retain) NSString	*userAgent; 
/**
 静态初始化方法 返回autorelease 对象
 */
+(id) clientConfiguration;
@end
