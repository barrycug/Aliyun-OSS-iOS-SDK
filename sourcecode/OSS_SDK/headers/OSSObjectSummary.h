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
@class Owner;
/**
 OSSObjectSummary 类，Object摘要信息
 */
@interface OSSObjectSummary : NSObject
{
@private
    NSString* _bucketName;
    NSString* _key;
    NSString* _eTag;
    long _size;
    NSDate* _lastModified;
    NSString* _storageClass;
    Owner* _owner;
}
/**
 bucket名称
 */
@property(nonatomic,retain)NSString* bucketName;
/**
 Object名称
 */
@property(nonatomic,retain)NSString* key;
/**
 Object eTag信息
 */
@property(nonatomic,retain)NSString* eTag;
/**
 Object大小
 */
@property(nonatomic,assign)long size;
/**
 Object最后修改时间
 */

@property(nonatomic,retain)NSDate* lastModified;
/**
 Object存储类型
 */

@property(nonatomic,retain)NSString* storageClass;
/**
 Object所有者
 */
@property(nonatomic,retain)Owner* owner;
/**
 初始化方法
 @param bucketName NSString
 @param key NSString
 @param eTag NSString
 @param size long
 @param lastModified NSDate
 @param storageClass NSString
 @param bucketName NSString
 @param owner Owner
 */
-(id) initWithBucketName:(NSString*)bucketName 
                     key:(NSString*)key 
                    eTag:(NSString*)eTag 
                    size:(long) size 
            lastModified:(NSDate*) lastModified
            storageClass:(NSString*) storageClass
                   owner:(Owner*)owner;
/**
 静态初始化方法 返回autorelease 对象
 @param bucketName NSString
 @param key NSString
 @param eTag NSString
 @param size long
 @param lastModified NSDate
 @param storageClass NSString
 @param bucketName NSString
 @param owner Owner
 */
+(id)OSSObjectSummaryWithBucketName:(NSString*)bucketName 
                                key:(NSString*)key 
                               eTag:(NSString*)eTag 
                               size:(long) size 
                       lastModified:(NSDate*) lastModified
                       storageClass:(NSString*) storageClass
                              owner:(Owner*)owner;
@end