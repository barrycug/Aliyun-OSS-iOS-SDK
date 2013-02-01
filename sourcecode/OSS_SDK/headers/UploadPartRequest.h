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
 UploadPart 类，构造UploadPart方法的请求参数
 */
@interface UploadPartRequest : NSObject
{
@private
    NSString*_bucketName;
    NSString*_key;
    NSString*_uploadId;
    int _partNumber;
    long _partSize;
    NSString*_md5Digest;
    NSData *_data;
}
/**
 bucket名称
 */
@property(nonatomic,retain)NSString*bucketName;
/**
 object名称
 */
@property(nonatomic,retain)NSString*key;
/**
 上传ID
 */

@property(nonatomic,retain)NSString*uploadId;
/**
 part编号
 */

@property(nonatomic,assign)int partNumber;
/**
 part大小
 */

@property(nonatomic,assign)long partSize;
/**
part 数据内容的md5值
 */

@property(nonatomic,retain)NSString*md5Digest;
/**
part 数据内容
 */

@property(nonatomic,retain)NSData *data;
/**
 初始化方法
 @param bucketName NSString
 @param key NSString
 @param uploadId NSString
 @param partNumber int
 @param partSize long
 @param md5Digest NSString
 @param data NSData

 */
-(id) initWithBucketName:(NSString*)bucketName 
                     key:(NSString*)key 
                uploadId:(NSString*)uploadId 
              partNumber:(int)partNumber 
                partSize:(long)partSize 
               md5Digest:(NSString*)md5Digest 
                    data:(NSData*)data;
/**
 静态初始化方法 返回autorelease 对象
 @param bucketName NSString
 @param key NSString
 @param uploadId NSString
 @param partNumber int
 @param partSize long
 @param md5Digest NSString
 @param data NSData
 */
+(id) UploadPartRequestWithBucketName:(NSString*)bucketName 
                     key:(NSString*)key 
                uploadId:(NSString*)uploadId 
              partNumber:(int)partNumber 
                partSize:(long)partSize 
               md5Digest:(NSString*)md5Digest 
                    data:(NSData*)data;
@end
