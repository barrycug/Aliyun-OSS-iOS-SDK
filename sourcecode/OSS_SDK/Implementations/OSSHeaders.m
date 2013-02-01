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
#import "OSSHeaders.h"
/*
 public abstract interface OSSHeaders extends HttpHeaders
 {
 public static final String OSS_PREFIX = "x-oss-";
 public static final String OSS_USER_METADATA_PREFIX = "x-oss-meta-";
 public static final String OSS_CANNED_ACL = "x-oss-acl";
 public static final String STORAGE_CLASS = "x-oss-storage-class";
 public static final String OSS_VERSION_ID = "x-oss-version-id";
 public static final String GET_OBJECT_IF_MODIFIED_SINCE = "If-Modified-Since";
 public static final String GET_OBJECT_IF_UNMODIFIED_SINCE = "If-Unmodified-Since";
 public static final String GET_OBJECT_IF_MATCH = "If-Match";
 public static final String GET_OBJECT_IF_NONE_MATCH = "If-None-Match";
 public static final String COPY_OBJECT_SOURCE = "x-oss-copy-source";
 public static final String COPY_OBJECT_SOURCE_IF_MATCH = "x-oss-copy-source-if-match";
 public static final String COPY_OBJECT_SOURCE_IF_NONE_MATCH = "x-oss-copy-source-if-none-match";
 public static final String COPY_OBJECT_SOURCE_IF_UNMODIFIED_SINCE = "x-oss-copy-source-if-unmodified-since";
 public static final String COPY_OBJECT_SOURCE_IF_MODIFIED_SINCE = "x-oss-copy-source-if-modified-since";
 public static final String COPY_OBJECT_METADATA_DIRECTIVE = "x-oss-metadata-directive";
 }
 */
@implementation OSSHeaders
+(NSString *)OSS_PREFIX
{
    return @"x-oss-";
}
+(NSString *)OSS_USER_METADATA_PREFIX
{
    return @"x-oss-meta-";
}

+(NSString *)OSS_CANNED_ACL
{
     return @"x-oss-acl";
}

+(NSString *)STORAGE_CLASS
{
    return @"x-oss-storage-class";
}

+(NSString *)OSS_VERSION_ID
{
     return @"x-oss-version-id";
}

+(NSString *)GET_OBJECT_IF_MODIFIED_SINCE
{
    return @"If-Modified-Since";
}

+(NSString *)GET_OBJECT_IF_UNMODIFIED_SINCE
{
    return @"If-Unmodified-Since";
}

+(NSString *)GET_OBJECT_IF_MATCH
{
     return @"If-Match";
}

+(NSString *)GET_OBJECT_IF_NONE_MATCH
{
    return @"If-None-Match";
}

+(NSString *)COPY_OBJECT_SOURCE
{
    return @"x-oss-copy-source";
}

+(NSString *)COPY_OBJECT_SOURCE_IF_MATCH
{
    return @"x-oss-copy-source-if-match";
}

+(NSString *)COPY_OBJECT_SOURCE_IF_NONE_MATCH
{
    return @"x-oss-copy-source-if-none-match";
}

+(NSString *)COPY_OBJECT_SOURCE_IF_UNMODIFIED_SINCE
{
    return @"x-oss-copy-source-if-unmodified-since";
}

+(NSString *)COPY_OBJECT_SOURCE_IF_MODIFIED_SINCE
{
    return @"x-oss-copy-source-if-modified-since";
}

+(NSString *)COPY_OBJECT_METADATA_DIRECTIVE
{
    return @"x-oss-metadata-directive";
}

@end
