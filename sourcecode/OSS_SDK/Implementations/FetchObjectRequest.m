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
#import "FetchObjectRequest.h"
#import "ResponseHeaderOverrides.h"

@implementation FetchObjectRequest
@synthesize bucketName = _bucketName;
@synthesize key = _key;
@synthesize rang = _rang;
@synthesize matchingETagConstraints = _matchingETagConstraints;
@synthesize nonmatchingEtagConstraints = _nonmatchingEtagConstraints;
@synthesize unmodifiedSinceConstraint = _unmodifiedSinceConstraint;
@synthesize modifiedSinceConstraint = _modifiedSinceConstraint;
@synthesize responseHeaders = _responseHeaders;
-(void) dealloc
{
    self.bucketName = nil;
    self.key = nil;
    self.matchingETagConstraints = nil;
    self.nonmatchingEtagConstraints = nil;
    self.unmodifiedSinceConstraint = nil;
    self.modifiedSinceConstraint = nil;
    self.responseHeaders = nil;
    [super dealloc];
}
-(id) initWithBucketName:(NSString *) bucketName key:(NSString*) key
{
    if (self = [super init]) {
        _bucketName = bucketName;
        [_bucketName retain];
        _key = key;
        [_key retain];
        _matchingETagConstraints = [[NSMutableArray alloc] initWithCapacity:10];
        _nonmatchingEtagConstraints = [[NSMutableArray alloc] initWithCapacity:10];
        _rang.length = 0;
        _rang.location = 0;
    }
    return self;
}
+(id) FetchObjectRequestWithBucketName:(NSString *) bucketName key:(NSString*) key
{
    FetchObjectRequest * gor =[[FetchObjectRequest alloc] initWithBucketName:bucketName key:key];
    return [gor autorelease];
}
@end
