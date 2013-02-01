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
 PartSummary 类，存储List part 方法返回结果中的Part摘要信息
 */
@interface PartSummary : NSObject
{
@private 
    int _partNumber;
    NSDate *_lastModified;
    NSString *_eTag;
    long _size;
}
/**
 part编号
 */
@property(nonatomic,assign) int partNumber;
/**
 最近修改时间
 */
@property(nonatomic,retain)NSDate *lastModified;
/**
eTag信息
 */
@property(nonatomic,retain)NSString *eTag;
/**
 part 大小
 */
@property(nonatomic,assign)long size;
/**
 初始化方法
 @param partNumber int
 @param lastModified NSDate
 @param eTag NSString
 @param size long
 */
-(id) initWithPartNumber:(int) partNumber  lastModified:(NSDate *)lastModified eTag:(NSString*)eTag  size:(long)size;
/**
 静态初始化方法 返回autorelease 对象
 @param partNumber int
 @param lastModified NSDate
 @param eTag NSString
 @param size long
 */
+(id) PartSummaryWithPartNumber:(int) partNumber  lastModified:(NSDate *)lastModified eTag:(NSString*)eTag  size:(long)size;
@end
