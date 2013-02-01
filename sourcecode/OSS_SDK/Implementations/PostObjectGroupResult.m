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
#import "PostObjectGroupResult.h"
#import "TBXML.h"
#import "OSSUtils.h"
@implementation PostObjectGroupResult
@synthesize bucketName = _bucketName;
@synthesize key = _key;
@synthesize eTag = _eTag;
@synthesize size = _size;
-(id) initWithBucketName:(NSString*)bucketName key:(NSString*)key eTag:(NSString*)eTag size:(long long)size
{
    if (self = [super init]) {
        _bucketName = bucketName;
        [_bucketName retain];
        _key = key;
        [_key retain];
        _eTag = eTag;
        [_eTag retain];
        _size = size;
    }
    return self;
}
+(id) PostObjectGroupResultWithBucketName:(NSString*)bucketName key:(NSString*)key eTag:(NSString*)eTag size:(long long)size
{
    PostObjectGroupResult * pogr = [[PostObjectGroupResult alloc] initWithBucketName:bucketName key:key eTag:eTag size:size];
    return  [pogr autorelease];
}
-(id) initWithXMLData:(NSData*) data
{
    if (data != nil) {
        NSString * strBucketName = @"";
        NSString * strKey = @"";
        NSString * strSize = @"";
        long long size=0;
        NSString * strETag = @"";
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *bucketXMLElement = [TBXML childElementNamed:@"Bucket" parentElement: rootXMLElement];
            if (bucketXMLElement != nil) {
                strBucketName = [TBXML textForElement:bucketXMLElement];
            }
            TBXMLElement *keyXMLElement = [TBXML childElementNamed:@"Key" parentElement: rootXMLElement];
            if (keyXMLElement != nil) {
                strKey = [TBXML textForElement:keyXMLElement];
            }
            TBXMLElement *eTagXMLElement = [TBXML childElementNamed:@"ETag" parentElement: rootXMLElement];
            if (eTagXMLElement != nil) {
                strETag = [TBXML textForElement:eTagXMLElement];
                strETag  = [OSSUtils trimQuotes:strETag];
            }
            TBXMLElement *sizeXMLElement = [TBXML childElementNamed:@"Size" parentElement: rootXMLElement];
            if (sizeXMLElement != nil) {
                strSize = [TBXML textForElement:sizeXMLElement];
                size = [strSize longLongValue];
            }
        }
        [tbxml release];
        tbxml = nil;
        if (self = [self initWithBucketName:strBucketName key:strKey  eTag:strETag size:size]) {
            ;
        }
        return self;
    }
    else {
        return nil;
    }
}

@end
