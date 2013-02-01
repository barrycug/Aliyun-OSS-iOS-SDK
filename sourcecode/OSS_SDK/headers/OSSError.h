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
 OSSError 类，存储请求返回的错误信息
 */
@interface OSSError : NSObject
{
    @private 
    NSString * _errorCode;
    NSString * _errorMessage;
    NSString * _errorStringToSignBytes;
    NSString * _errorSignatureProvided;
    NSString * _errorStringToSign;
    NSString * _errorOSSAccessKeyId;
    NSString * _errorRequestId;
    NSString * _errorHostId;
}
/**
 错误码
 */
@property(nonatomic,retain,readonly) NSString * errorCode;
/**
 错误消息
 */
@property(nonatomic,retain,readonly) NSString * errorMessage;
/**
 错误的签名数据
 */
@property(nonatomic,retain,readonly) NSString * errorStringToSignBytes;
/**
 错误签名提供者
 */
@property(nonatomic,retain,readonly) NSString * errorSignatureProvided;
/**
 错误签名字符串
 */
@property(nonatomic,retain,readonly) NSString * errorStringToSign;
/**
 AccessKey
 */
@property(nonatomic,retain,readonly) NSString * errorOSSAccessKeyId;
/**
 RequestId
 */
@property(nonatomic,retain,readonly) NSString * errorRequestId;
/**
HostId
 */
@property(nonatomic,retain,readonly) NSString * errorHostId;
/**
 初始化方法
 @param code NSString
 @param message NSString
 @param stringToSignBytes NSString
 @param signatureProvided NSString
 @param stringToSign NSString
 @param ossAccessKeyId NSString
 @param requestId NSString
 @param hostId NSString

 */
-(id) initWithErrorCode:(NSString*) code 
                  message:(NSString*) message 
        stringToSignBytes:(NSString*) stringToSignBytes 
        signatureProvided:(NSString*) signatureProvided
             stringToSign:(NSString*) stringToSign 
           ossAccessKeyId:(NSString*) ossAccessKeyId 
                requestId:(NSString*) requestId 
                   hostId:(NSString*) hostId; 
/**
 静态初始化方法 返回autorelease 对象
 @param code NSString
 @param message NSString
 @param stringToSignBytes NSString
 @param signatureProvided NSString
 @param stringToSign NSString
 @param ossAccessKeyId NSString
 @param requestId NSString
 @param hostId NSString
 */
+(id) OSSErrorWithErrorCode:(NSString*) code 
                    message:(NSString*) message 
          stringToSignBytes:(NSString*) stringToSignBytes 
          signatureProvided:(NSString*) signatureProvided 
               stringToSign:(NSString*) stringToSign 
             ossAccessKeyId:(NSString*) ossAccessKeyId 
                  requestId:(NSString*) requestId 
                     hostId:(NSString*) hostId; 

@end
/**
 OSSError XMLData分类
 */
@interface OSSError(XMLData)
/**
 初始化方法 从XML Data初始化
 @param data NSData
 */
-(id) initWithData:(NSData *) data;
/**
静态初始化方法 返回autorelease 对象从XML Data初始化
 @param data NSData
 */
+(id) OSSErrorWithData:(NSData *) data;
@end

