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
#import "ListObjectsRequest.h"

@implementation ListObjectsRequest

@synthesize bucketName = _bucketName;
@synthesize prefix = _prefix;
@synthesize marker = _marker;
@synthesize maxKeys = _maxKeys;
@synthesize delimiter = _delimiter; 
-(void) dealloc
{

    self.bucketName= nil;
    self.prefix= nil;
    self.marker= nil; 
    self.delimiter= nil;
    [super dealloc];
}
-(id) initWithBucketName:(NSString*) bucketName 
                  prefix:(NSString*)prefix 
                  marker:(NSString*) marker 
                 maxKeys:(int) maxKeys 
               delimiter:(NSString*)delimiter
{
    if (self = [super init]) {
        _bucketName = bucketName;
        [_bucketName retain];
        _prefix = prefix;
        [_prefix retain];
        _marker = marker;
        [_marker retain];
        _maxKeys = maxKeys;
        _delimiter = delimiter;
        [_delimiter retain];
    }
    return self;
}
+(id) ListObjectsRequestWithBucketName:(NSString*) bucketName 
                                prefix:(NSString*)prefix 
                                marker:(NSString*) marker 
                               maxKeys:(int) maxKeys 
                             delimiter:(NSString*)delimiter
{
    ListObjectsRequest * lor = [[ListObjectsRequest alloc] initWithBucketName:bucketName prefix:prefix marker:marker maxKeys:maxKeys delimiter:delimiter];
    return [lor autorelease];
}
-(void)setMaxKeys:(int)maxKeys
{
    if (_maxKeys <0 || _maxKeys >1000) {
        NSLog(@"ListObjectsRequest maxKeys > 1000 or < 0");
    }
    _maxKeys = maxKeys;
}
@end
