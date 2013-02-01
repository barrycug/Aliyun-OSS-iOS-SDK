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
 OSSErrorCodeType枚举类型，定义错误码
 */
typedef enum
{
    OSSErrorCodeType_INVALIED = 4999,
    OSSErrorCodeType_ACCESS_DENIED = 5000,
    OSSErrorCodeType_BUCKES_ALREADY_EXISTS=5001,
    OSSErrorCodeType_BUCKETS_NOT_EMPTY  =   5002,
    OSSErrorCodeType_FILE_GROUP_TOO_LARGE =5003,
    OSSErrorCodeType_FILE_PART_STALE =5004,
    OSSErrorCodeType_INVALID_ARGUMENT= 5005,
    OSSErrorCodeType_INVALID_ACCESS_KEY_ID= 5006,
    OSSErrorCodeType_INVALID_BUCKET_NAME =5007,
    OSSErrorCodeType_INVALID_OBJECT_NAME =5008,
    OSSErrorCodeType_INVALID_PART = 5009,
    OSSErrorCodeType_INVALID_PART_ORDER = 5010,
    OSSErrorCodeType_INTERNAL_ERROR = 50011,
    OSSErrorCodeType_MISSING_CONTENT_LENGTH = 5012,
    OSSErrorCodeType_NO_SUCH_BUCKET = 5013,
    OSSErrorCodeType_NO_SUCH_KEY = 5014,
    OSSErrorCodeType_NOT_IMPLEMENTED = 5015,
    OSSErrorCodeType_PRECONDITION_FAILED = 5016,
    OSSErrorCodeType_REQUEST_TIME_TOO_SKEWED = 5017,
    OSSErrorCodeType_REQUEST_TIMEOUT = 5018,
    OSSErrorCodeType_SIGNATURE_DOES_NOT_MATCH = 5019,
    OSSErrorCodeType_TOO_MANY_BUCKETS=5020
}OSSErrorCodeType;
/**
 OSSErrorCode类，处理错误码相关操作
 */
@interface OSSErrorCode : NSObject
{
    
}
/**
 静态方法，错误码转成成对应的字符串
  @param errorCodeType OSSErrorCodeType
 */
+(NSString*) OSSErrorCodeToString:(OSSErrorCodeType)errorCodeType;
/**
 静态方法，字符串转成成对应的错误码
  @param strErrorCodeType NSString
 */
+(OSSErrorCodeType)OSSErrorCodeFromString:(NSString*)strErrorCodeType;
@end
