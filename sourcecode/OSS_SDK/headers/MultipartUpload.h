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
 MultipartUpload 类，构造多点上传中每一部分的信息， MultipartUploadListing 中的一部分
 */
@interface MultipartUpload : NSObject
{
@private
    NSString*_key;
    NSString*_uploadId;
    NSString*_storageClass;
    NSDate *_initiated;
}
/**
 Object名称
 */
@property(nonatomic,retain)NSString*key;
/**
 上传ID
 */
@property(nonatomic,retain)NSString*uploadId;
/**
 存储类型
 */
@property(nonatomic,retain)NSString*storageClass;
/**
 初始化时间
 */
@property(nonatomic,retain)NSDate *initiated;
/**
 初始化方法
 @param key NSString
 @param uploadId NSString
 @param storageClass NSString
 @param initiated NSDate
 */
-(id) initWithKey:(NSString*)key uploadId:(NSString*)uploadId storageClass:(NSString*)storageClass initiated:(NSDate *)initiated;
/**
 静态初始化方法 返回autorelease 对象
 @param key NSString
 @param uploadId NSString
 @param storageClass NSString
 @param initiated NSDate
 */
+(id) MultipartUploadWithKey:(NSString*)key uploadId:(NSString*)uploadId storageClass:(NSString*)storageClass initiated:(NSDate *)initiated;
@end
