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
#import "Owner.h"

@implementation Owner
@synthesize ownerID = _ownerID;
@synthesize displayName = _displayName;
-(void) dealloc
{
    self.ownerID = nil;
    self.displayName = nil;
    [super dealloc];
}
-(id) initWithOwnerID:(NSString *) ownerID displayName:(NSString *)displayName
{
    if (self =[ super init]) {
        _ownerID = ownerID;
        [_ownerID retain];
        _displayName = displayName;
        [_displayName retain];
    }
    return self;
}
+(id) OwnerWithOwnerID:(NSString *) ownerID displayName:(NSString *)displayName
{
    Owner * owner = [[Owner alloc] initWithOwnerID:ownerID displayName:displayName];
    return [owner autorelease];
}
- (BOOL)isEqual:(id)anObject
{
    BOOL isEqual = NO;
    if ([anObject isKindOfClass:[Owner class]] ) {
        Owner * obj = (Owner*)anObject;
        NSString * str1 = _ownerID;
        NSString * str2 = _displayName;
        NSString * str3 = obj.ownerID;
        NSString * str4 = obj.displayName;
        if (str1 == nil)
            str1 = @"";
        if (str2 == nil)
            str2 = @"";
        if (str3 == nil)
            str3 = @"";
        if (str4 == nil)
            str4 = @"";
        isEqual = ([str1 isEqualToString:str3] && [str2 isEqualToString:str4]);

    }
    return isEqual;
}
@end
