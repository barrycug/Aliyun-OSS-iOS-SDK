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

#import "CopyObjectResult.h"
#import "TBXML.h"
#import "DateUtil.h"
#import "OSSUtils.h"
@implementation CopyObjectResult
@synthesize lastModified = _lastModified;
@synthesize eTag = _eTag;
-(void) dealloc
{
    self.eTag = nil;
    self.lastModified = nil;
    [super dealloc];
}
-(id)initWithEtag:(NSString*)eTag lastModified:(NSDate *)lastModified
{
    if (self = [super init]) {
        _eTag = eTag;
        [_eTag retain];
        _lastModified = lastModified;
        [_lastModified retain];
    }
    return self;
}
+(id)CopyObjectResultWithEtag:(NSString*)eTag lastModified:(NSDate *)lastModified
{
    CopyObjectResult * cor =[[CopyObjectResult alloc] initWithEtag:eTag lastModified:lastModified];
    return [cor autorelease];
}
-(id) initWithXMLData:(NSData*)data
{
    if (data != nil) 
    {
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        NSString * strLastModified=@"";
        NSString * strETag=@"";
        if (rootXMLElement != nil) 
        {
            TBXMLElement *lastModifiedXMLElement = [TBXML childElementNamed:@"LastModified" parentElement: rootXMLElement];
            strLastModified = [TBXML textForElement:lastModifiedXMLElement];
            TBXMLElement *eTagXMLElement = [TBXML childElementNamed:@"ETag" parentElement: rootXMLElement];
            strETag = [TBXML textForElement:eTagXMLElement];
            strETag  = [OSSUtils trimQuotes:strETag];
        } 
        [tbxml release];
        tbxml = nil;
        if (self = [self initWithEtag:strETag lastModified:[DateUtil parseRfc822Date:strLastModified]]) {
            ;
        }
        return self;
    }
    else {
        return nil;
    }
    
}
@end
