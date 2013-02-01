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
 DateUtil通用类，用来处理时间相关的方法
 */
@interface DateUtil : NSObject
{
    
}
/**
 静态方法，返回RFC822时间格式串
 */
+(NSString*) RFC822_DATE_FORMAT;
/**
 静态方法，返回ISO8601时间格式串
 */
+(NSString*) ISO8601_DATE_FORMAT;
/**
 静态方法，返回ALTERNATIVE_ISO8601时间格式串
 */
+(NSString*) ALTERNATIVE_ISO8601_DATE_FORMAT ;

/**
 静态方法，将时间转换成Rfc822格式字符串
@param date NSDate
 */
+(NSString*) formatRfc822Date:(NSDate*) date;
/**
 静态方法，将Rfc822格式字符串转换成时间
 @param string NSString
 */
+(NSDate*) parseRfc822Date:(NSString*) string;
/**
 静态方法，将Iso8601格式字符串转换成时间
  @param string NSString
 */
+(NSDate*) parseIso8601Date:(NSString*) string;
@end
