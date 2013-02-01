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
 CannedAclType类型
 */
typedef enum
{
    CannedAclType_Invalid = 0,
    CannedAclType_Private ,
    CannedAclType_PublicRead,
    CannedAclType_PublicReadWrite
}CannedAclType;
/**
 CannedAccessControlList类 用来存储Canned Access Control List信息
 */
@interface CannedAccessControlList : NSObject
{
@private
    CannedAclType  _cannedAclType;
}

/**
 CannedAccessControlList的字符串表达
 */
@property(nonatomic,assign,readonly)  NSString * cannedAclString;
/**
  CannedAccessControlList的类型
 */
@property(nonatomic,assign,readonly)  CannedAclType  cannedAclType;
/**
 初始化方法
 @param cannedAclType CannedAclType
 */
-(id) initWithCannedAclType:(CannedAclType ) cannedAclType;
/**
 静态初始化方法 返回autorelease 对象
@param cannedAclType CannedAclType
 */
+(id) cannedAclWithCannedAclType:(CannedAclType ) cannedAclType;
/**
 静态方法 实现字符串到CannedAclType类型的转换
 @param strCannedAclType NSString
 */
+(CannedAclType) stringToType:(NSString*) strCannedAclType;
@end
/**
 CannedAccessControlList XMLData 分类
 */
@interface CannedAccessControlList(XMLData)
/**
 初始化方法，使用XML数据初始化
 @param data NSData
 */
-(id) initWithXMLData:(NSData*)data;
@end
