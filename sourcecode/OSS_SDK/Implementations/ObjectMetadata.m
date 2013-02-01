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
#import "ObjectMetadata.h"

@implementation ObjectMetadata
@synthesize userMetadata=_userMetadata;
@synthesize metadata=_metadata;
-(void) dealloc
{
    [_metadata release];
    _metadata = nil;
    self.userMetadata = nil;
    [super dealloc];
}
-(id) init
{
    if (self = [super init]) {
        _metadata = [[NSMutableDictionary alloc] initWithCapacity:10];
        _userMetadata = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return self;
}
-(void) addHeader:(NSString*)key value:(id) value
{
    [_metadata setObject:value forKey:key];
}
-(void) addUserMetadata:(NSString*)key value:(NSString*) value
{
    [_userMetadata setObject:value forKey:key];
}
-(NSDate *) lastModified
{
    return ((NSDate*)[_metadata objectForKey:@"Last-Modified"]);
}
-(void) setLastModified:(NSDate *)lastModified
{
    [_metadata setObject:lastModified forKey:@"Last-Modified"];
}
-(NSDate *) expirationTime
{
    return ((NSDate*)[_metadata objectForKey:@"Expires"]);
}
-(void) setExpirationTime:(NSDate *)expirationTime
{
    [_metadata setObject:expirationTime forKey:@"Expires"];
}
-(long) contentLength
{
    NSNumber * number = [_metadata objectForKey:@"Content-Length"];
    return [number longValue];
  
}
-(void) setContentLength:(long)contentLength
{
    NSAssert(!( contentLength > 5368709120L),@"长度不能查过5G");
    NSNumber * number = [NSNumber numberWithLong:contentLength];
    [_metadata setObject:number forKey:@"Content-Length"];
}
-(NSString*) contentType
{
    return [_metadata objectForKey:@"Content-Type"];
    
}
-(void) setContentType:(NSString *)contentType
{
    [_metadata setObject:contentType forKey:@"Content-Type"];
}
-(NSString*) contentEncoding
{
    return [_metadata objectForKey:@"Content-Encoding"];
}
-(void) setContentEncoding:(NSString *)contentEncoding
{
    [_metadata setObject:contentEncoding forKey:@"Content-Encoding"];
}
-(NSString*)cacheControl
{
    return [_metadata objectForKey:@"Cache-Control"];
}
-(void) setCacheControl:(NSString *)cacheControl
{
     [_metadata setObject:cacheControl forKey:@"Cache-Control"];
}
-(NSString*)contentDisposition
{
    return [_metadata objectForKey:@"Content-Disposition"];
}
-(void) setContentDisposition:(NSString *)contentDisposition
{
    [_metadata setObject:contentDisposition forKey:@"Content-Disposition"];
}
-(NSString*)eTag
{
    return [_metadata objectForKey:@"ETag"];
}

@end
