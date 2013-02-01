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
#import "Bucket.h"
#import "Owner.h"
@implementation Bucket
@synthesize name = _name;
@synthesize owner = _owner;
@synthesize creationDate = _creationDate;
-(void) dealloc
{
    self.name = nil;
    self.owner = nil;
    self.creationDate = nil;
    [super dealloc];
}
-(id) initWithName:(NSString*)name
{
    if (self = [self initWithName:name owner:nil creationDate:nil]) {
        
    };
    return self;
}
+(id) bucketWithName:(NSString*)name
{
     return [[[Bucket alloc] initWithName:name ] autorelease];
}
-(id) initWithName:(NSString*)name owner:(Owner*)owner creationDate:(NSDate*)creationDate
{
    if (self = [super init]) {
        self.name = name;
        self.owner = owner;
        self.creationDate = creationDate;      
    }
    return self;
}
+(id) bucketWithName:(NSString*)name owner:(Owner*)owner creationDate:(NSDate*)creationDate
{
    return [[[Bucket alloc] initWithName:name owner:owner creationDate:creationDate] autorelease];
}
@end
