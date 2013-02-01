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
 ListMultipartUploadsRequest 类，构造ListMultipartUploads的请求
 */
@interface ListMultipartUploadsRequest : NSObject
{
@private
    NSString *_bucketName;
    NSString *_delimiter;
    NSString *_prefix;
    int _maxUploads;
    NSString *_keyMarker;
    NSString *_uploadIdMarker;
}
/**
 bucket名称
 */
@property(nonatomic,retain)NSString *bucketName;
/**
 delimiter
 */
@property(nonatomic,retain)NSString *delimiter;
/**
 prefix
 */
@property(nonatomic,retain)NSString *prefix;
/**
 最大上传数
 */
@property(nonatomic,assign)int maxUploads;
/**
 keyMarker
 */
@property(nonatomic,retain)NSString *keyMarker;
/**
 uploadIdMarker
 */
@property(nonatomic,retain)NSString *uploadIdMarker;
/**
 初始化方法
 @param bucketName NSString
 @param delimiter NSString
 @param prefix NSString
 @param maxUploads int
 @param keyMarker NSString
 @param uploadIdMarker NSString
 */
-(id) initWithBucketName:(NSString*)bucketName
                 delimiter:(NSString *)delimiter
                    prefix:(NSString *)prefix
                maxUploads:(int) maxUploads
                 keyMarker:(NSString *)keyMarker
            uploadIdMarker:(NSString *)uploadIdMarker;
/**
 静态初始化方法 返回autorelease 对象
 @param bucketName NSString
 @param delimiter NSString
 @param prefix NSString
 @param maxUploads int
 @param keyMarker NSString
 @param uploadIdMarker NSString
 */
+(id) ListMultipartUploadsRequestWithBucketName:(NSString*)bucketName
                 delimiter:(NSString *)delimiter
                    prefix:(NSString *)prefix
                maxUploads:(int) maxUploads
                 keyMarker:(NSString *)keyMarker
            uploadIdMarker:(NSString *)uploadIdMarker;
@end
