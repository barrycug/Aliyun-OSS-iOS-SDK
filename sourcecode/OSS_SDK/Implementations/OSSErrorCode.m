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
#import "OSSErrorCode.h"


@implementation OSSErrorCode
{
    
}
+(OSSErrorCodeType)OSSErrorCodeFromString:(NSString*)strErrorCodeType
{
    OSSErrorCodeType type = OSSErrorCodeType_INVALIED;
    if ([strErrorCodeType isEqualToString: @"AccessDenied"]) {
        type = OSSErrorCodeType_ACCESS_DENIED;
    }else if ([strErrorCodeType isEqualToString: @"BucketAlreadyExists"]) {
        type = OSSErrorCodeType_BUCKES_ALREADY_EXISTS;
    }else if ([strErrorCodeType isEqualToString: @"BucketNotEmpty"]) {
        type = OSSErrorCodeType_BUCKETS_NOT_EMPTY;
    }else if ([strErrorCodeType isEqualToString: @"FileGroupTooLarge"]) {
        type = OSSErrorCodeType_FILE_GROUP_TOO_LARGE;
    }else if ([strErrorCodeType isEqualToString: @"FilePartStale"]) {
        type = OSSErrorCodeType_FILE_PART_STALE;
    }else if ([strErrorCodeType isEqualToString: @"InvalidArgument"]) {
        type = OSSErrorCodeType_INVALID_ARGUMENT;
    }else if ([strErrorCodeType isEqualToString: @"InvalidAccessKeyId"]) {
        type = OSSErrorCodeType_INVALID_ACCESS_KEY_ID;
    }else if ([strErrorCodeType isEqualToString: @"InvalidBucketName"]) {
        type = OSSErrorCodeType_INVALID_BUCKET_NAME;
    }else if ([strErrorCodeType isEqualToString: @"InvalidObjectName"]) {
        type = OSSErrorCodeType_INVALID_OBJECT_NAME;
    }else if ([strErrorCodeType isEqualToString: @"InvalidPart"]) {
        type = OSSErrorCodeType_INVALID_PART;
    }else if ([strErrorCodeType isEqualToString: @"InvalidPartOrder"]) {
        type = OSSErrorCodeType_INVALID_PART_ORDER;
    }else if ([strErrorCodeType isEqualToString: @"InternalError"]) {
        type = OSSErrorCodeType_INTERNAL_ERROR;
    }else if ([strErrorCodeType isEqualToString: @"MissingContentLength"]) {
        type = OSSErrorCodeType_MISSING_CONTENT_LENGTH;
    }else if ([strErrorCodeType isEqualToString: @"NoSuchBucket"]) {
        type = OSSErrorCodeType_NO_SUCH_BUCKET;
    }else if ([strErrorCodeType isEqualToString: @"NoSuchKey"]) {
        type = OSSErrorCodeType_NO_SUCH_KEY;
    }else if ([strErrorCodeType isEqualToString: @"NotImplemented"]) {
        type = OSSErrorCodeType_NOT_IMPLEMENTED;
    }else if ([strErrorCodeType isEqualToString: @"PreconditionFailed"]) {
        type = OSSErrorCodeType_PRECONDITION_FAILED;
    }else if ([strErrorCodeType isEqualToString: @"RequestTimeTooSkewed"]) {
        type = OSSErrorCodeType_REQUEST_TIME_TOO_SKEWED;
    }else if ([strErrorCodeType isEqualToString: @"RequestTimeout"]) {
        type = OSSErrorCodeType_REQUEST_TIMEOUT;
    }else if ([strErrorCodeType isEqualToString: @"SignatureDoesNotMatch"]) {
        type = OSSErrorCodeType_SIGNATURE_DOES_NOT_MATCH;
    }else if ([strErrorCodeType isEqualToString: @"TooManyBuckets"]) {
        type = OSSErrorCodeType_TOO_MANY_BUCKETS;
    }
    return type;
    
}

+(NSString*) OSSErrorCodeToString:(OSSErrorCodeType)errorCodeType
{
    NSString * rtn=@"";
    switch (errorCodeType) {
            
        case OSSErrorCodeType_ACCESS_DENIED:
        {
            rtn = @"AccessDenied";
        }
            break;
        case OSSErrorCodeType_BUCKES_ALREADY_EXISTS:
        {
             rtn = @"BucketAlreadyExists";
        }
            break;
        case OSSErrorCodeType_BUCKETS_NOT_EMPTY:
        {
             rtn = @"BucketNotEmpty";
        }
            break;
        case OSSErrorCodeType_FILE_GROUP_TOO_LARGE:
        {
            rtn = @"FileGroupTooLarge";
        }
            break;
        case OSSErrorCodeType_FILE_PART_STALE:
        {
            rtn  = @"FilePartStale";
        }
            break;
        case OSSErrorCodeType_INVALID_ARGUMENT:
        {
            rtn = @"InvalidArgument";
         }
            break;
        case OSSErrorCodeType_INVALID_ACCESS_KEY_ID:
        {
            rtn = @"InvalidAccessKeyId";
        }
            break;
        case OSSErrorCodeType_INVALID_BUCKET_NAME:
        {
            rtn = @"InvalidBucketName";
        }
            break;
        case OSSErrorCodeType_INVALID_OBJECT_NAME:
        {
            rtn = @"InvalidObjectName";
        }
            break;
        case OSSErrorCodeType_INVALID_PART:
        {
            rtn = @"InvalidPart";
        }
            break;
        case OSSErrorCodeType_INVALID_PART_ORDER:
        {
            rtn = @"InvalidPartOrder";
         }
            break;
        case OSSErrorCodeType_INTERNAL_ERROR:
        {
            rtn = @"InternalError";            
        }
            break;
        case OSSErrorCodeType_MISSING_CONTENT_LENGTH:
        {
            rtn = @"MissingContentLength";
        }
            break;
        case OSSErrorCodeType_NO_SUCH_BUCKET:
        {
             rtn = @"NoSuchBucket";
        }
            break;
        case OSSErrorCodeType_NO_SUCH_KEY:
        {
             rtn = @"NoSuchKey";
        }
            break;
        case OSSErrorCodeType_NOT_IMPLEMENTED:
        {
            
            rtn = @"NotImplemented";
         }
            break;
        case OSSErrorCodeType_PRECONDITION_FAILED:
        {
             rtn = @"PreconditionFailed";
        }
            break;
        case OSSErrorCodeType_REQUEST_TIME_TOO_SKEWED:
        {
            rtn = @"RequestTimeTooSkewed";
        }
            break;
        case OSSErrorCodeType_REQUEST_TIMEOUT:
        {
            rtn = @"RequestTimeout";
        }
            break;
        case OSSErrorCodeType_SIGNATURE_DOES_NOT_MATCH:
        {
            rtn = @"SignatureDoesNotMatch";
        }
            break;
        case OSSErrorCodeType_TOO_MANY_BUCKETS:
        {
             rtn = @"TooManyBuckets";
        }
            break;  

            
        default:
            break;
    }
    return rtn;
}
@end
