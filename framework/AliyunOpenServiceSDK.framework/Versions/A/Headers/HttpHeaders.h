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
/*
 public static final String AUTHORIZATION = "Authorization";
 public static final String CACHE_CONTROL = "Cache-Control";
 public static final String CONTENT_DISPOSITION = "Content-Disposition";
 public static final String CONTENT_ENCODING = "Content-Encoding";
 public static final String CONTENT_LENGTH = "Content-Length";
 public static final String CONTENT_MD5 = "Content-MD5";
 public static final String CONTENT_TYPE = "Content-Type";
 public static final String DATE = "Date";
 public static final String ETAG = "ETag";
 public static final String EXPIRES = "Expires";
 public static final String HOST = "Host";
 public static final String LAST_MODIFIED = "Last-Modified";
 public static final String RANGE = "Range";
 public static final String LOCATION = "Location";
 */
/**
 HttpHeaders 类，定义基本的HTTPHeader字符串
 */
@interface HttpHeaders : NSObject
{
    
}
/**
 静态方法，返回 AUTHORIZATION 字符串
 */
+(NSString*)AUTHORIZATION;
/**
 静态方法，返回 CACHE_CONTROL 字符串
 */
+(NSString*)CACHE_CONTROL;
/**
 静态方法，返回 CONTENT_DISPOSITION 字符串
 */
+(NSString*)CONTENT_DISPOSITION;
/**
 静态方法，返回 CONTENT_ENCODING 字符串
 */
+(NSString*)CONTENT_ENCODING;
/**
 静态方法，返回 CONTENT_LENGTH 字符串
 */
+(NSString*)CONTENT_LENGTH;
/**
 静态方法，返回 CONTENT_MD5 字符串
 */
+(NSString*)CONTENT_MD5;
/**
 静态方法，返回 CONTENT_TYPE 字符串
 */
+(NSString*) CONTENT_TYPE;
/**
 静态方法，返回 DATE 字符串
 */
+(NSString*)DATE;
/**
 静态方法，返回 ETAG 字符串
 */
+(NSString*)ETAG;
/**
 静态方法，返回 EXPIRES 字符串
 */
+(NSString*)EXPIRES;
/**
 静态方法，返回 HOST 字符串
 */
+(NSString*)HOST;
/**
 静态方法，返回 LAST_MODIFIED 字符串
 */
+(NSString*)LAST_MODIFIED;
/**
 静态方法，返回 RANGE 字符串
 */
+(NSString*)RANGE;
/**
 静态方法，返回 LOCATION 字符串
 */
+(NSString*)LOCATION;
@end
