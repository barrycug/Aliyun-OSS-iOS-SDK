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
@class ObjectMetadata;
/**
 CopyObjectRequest类，存储CopyObject方法的请求信息
 */
@interface CopyObjectRequest : NSObject
{
@private
    NSString *_sourceBucketName;
    NSString *_sourceKey;
    NSString *_destinationBucketName;
    NSString *_destinationKey;
    ObjectMetadata *_aNewObjectMetadata;
    NSMutableArray *_matchingETagConstraints;
    NSMutableArray *_nonmatchingEtagConstraints;
    NSDate *_unmodifiedSinceConstraint;
    NSDate *_modifiedSinceConstraint;
}
/**
 原始Bucket名称
 */
@property(nonatomic,retain)NSString *sourceBucketName;
/**
 原始Object名称
 */
@property(nonatomic,retain)NSString *sourceKey;
/**
 目标Bucket名称
 */
@property(nonatomic,retain)NSString *destinationBucketName;
/**
 目标Object名称
 */
@property(nonatomic,retain)NSString *destinationKey;
/**
 新的Object元数据
 */
@property(nonatomic,retain)ObjectMetadata *aNewObjectMetadata;
/**
 匹配的ETag约束数组
 如果源 Object 的 ETAG 值和用户提供的 ETAG 相 等,则执行拷贝操作;
 */
@property(nonatomic,retain)NSMutableArray *matchingETagConstraints;
/**
 不匹配的ETag约束数组
 如果源 Object 自从用户指定的时间以后就没有 被修改过,则执行拷贝操作
 */
@property(nonatomic,retain)NSMutableArray *nonmatchingEtagConstraints;
/**
 文件未修改时间 如果传入参数中的时间等于或者晚于文件实际 修改时间,则正常传输文件,并返回 200 OK
 */
@property(nonatomic,retain)NSDate *unmodifiedSinceConstraint;
/**
 文件修改时间 如果源 Object 自从用户指定的时间以后被修改 过,则执行拷贝操作
 */
@property(nonatomic,retain)NSDate *modifiedSinceConstraint;
/**
 初始化方法
 @param sourceBucketName NSString
 @param sourceKey NSString
 @param destinationBucketName NSString
 @param destinationKey NSString
 */
-(id) initWithSourceBucketName:(NSString *)sourceBucketName 
                     sourceKey:(NSString*)sourceKey 
         destinationBucketName:(NSString *)destinationBucketName 
                destinationKey:(NSString*)destinationKey;
/**
 静态初始化方法 返回autorelease 对象
 @param sourceBucketName NSString
 @param sourceKey NSString
 @param destinationBucketName NSString
 @param destinationKey NSString
 */
+(id) CopyObjectRequestSourceBucketName:(NSString *)sourceBucketName 
                     sourceKey:(NSString*)sourceKey 
         destinationBucketName:(NSString *)destinationBucketName 
                destinationKey:(NSString*)destinationKey;
@end
