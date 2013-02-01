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
#import "FetchObjectGroupIndexResult.h"
#import "TBXML.h"
#import "OSSUtils.h"
#import "FilePart.h"
/*
 <FileGroup> 
 <FilePart> 
 <Part> 
 <ETag>"C13DCEABCB143ACD6C9298265D618A9F"</ETag> 
 <PartName>test222</PartName> 
 <PartNumber>1</PartNumber> 
 <PartSize>6</PartSize> 
 </Part> 
 <Part> 
 <ETag>"C13DCEABCB143ACD6C9298265D618A9F"</ETag> 
 <PartName>test333</PartName> 
 <PartNumber>2</PartNumber> 
 <PartSize>6</PartSize> 
 </Part> 
 </FilePart> 
 <Bucket>barrycug11</Bucket> 
 <Key>test444</Key> 
 <ETag>"4CCC7C42E2072493F684C45C4ACC08DB"</ETag> 
 <FileLength>12</FileLength> 
 </FileGroup>
 */
@implementation FetchObjectGroupIndexResult
@synthesize bucketName = _bucketName;
@synthesize key = _key;
@synthesize eTag = _eTag;
@synthesize size = _size;
@synthesize filePartsArray = _filePartsArray;
-(id) initWithBucketName:(NSString*)bucketName key:(NSString*)key eTag:(NSString*)eTag size:(long long)size filePartsArray:( NSArray *)filePartsArray
{
    if (self = [super init]) {
        _bucketName = bucketName;
        [_bucketName retain];
        _key = key;
        [_key retain];
        _eTag = eTag;
        [_eTag retain];
        _size = size;
        _filePartsArray = filePartsArray;
        [filePartsArray retain];
    }
    return self;
}
+(id) FetchObjectGroupIndexResultWithBucketName:(NSString*)bucketName key:(NSString*)key eTag:(NSString*)eTag size:(long long)size filePartsArray:( NSArray *)filePartsArray
{
    FetchObjectGroupIndexResult * fogir =[[FetchObjectGroupIndexResult alloc] initWithBucketName:bucketName key:key eTag:eTag size:size filePartsArray:filePartsArray];
    return [fogir autorelease];
}
-(id) initWithXMLData:(NSData*) data
{
    if (data != nil) {
        NSString * strBucketName = @"";
        NSString * strKey = @"";
        NSString * strSize = @"";
        long long size=0;
        NSString * strETag = @"";
        NSMutableArray * filePartsArray = [[NSMutableArray alloc] initWithCapacity:5];
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
             TBXMLElement *filePartXMLElement = [TBXML childElementNamed:@"FilePart" parentElement: rootXMLElement];
            if (filePartXMLElement != nil) {
                TBXMLElement * partXMLElement = [TBXML childElementNamed:@"Part" parentElement: filePartXMLElement];
                while (partXMLElement) {
                    NSString * striEtag = @"";
                    NSString * striPartName = @"";
                    NSString * striPartNumber = @"";
                    NSString * striPartSize = @"";
                    int partNumber = 0;
                    int partSize = 0;
                    TBXMLElement * iETagXMLElement = [TBXML childElementNamed:@"ETag" parentElement: partXMLElement];
                    if (iETagXMLElement != nil) {
                        striEtag = [TBXML textForElement:iETagXMLElement];
                    }
                    TBXMLElement * iPartNameXMLElement = [TBXML childElementNamed:@"PartName" parentElement: partXMLElement];
                    if (iPartNameXMLElement != nil) {
                        striPartName = [TBXML textForElement:iPartNameXMLElement];
                    }
                    TBXMLElement * iPartNumberXMLElement = [TBXML childElementNamed:@"PartNumber" parentElement: partXMLElement];
                    if (iPartNumberXMLElement != nil) {
                        striPartNumber = [TBXML textForElement:iPartNumberXMLElement];
                        partNumber = [striPartNumber intValue];
                    }
                     TBXMLElement * iPartSizeXMLElement = [TBXML childElementNamed:@"PartSize" parentElement: partXMLElement];
                    if (iPartSizeXMLElement != nil) {
                        striPartSize = [TBXML textForElement:iPartSizeXMLElement];
                        partSize = [striPartSize intValue];
                    }
                    FilePart * fp = [[FilePart alloc] initWithPartNumber:partNumber partName:striPartName eTag:striEtag partSize:partSize];
                    [filePartsArray addObject:fp];
                    [fp release];
                    partXMLElement = [TBXML nextSiblingNamed:@"Part" searchFromElement:partXMLElement];
                }
            }
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
            TBXMLElement *sizeXMLElement = [TBXML childElementNamed:@"FileLength" parentElement: rootXMLElement];
            if (sizeXMLElement != nil) {
                strSize = [TBXML textForElement:sizeXMLElement];
                size = [strSize longLongValue];
            }
        }
        [tbxml release];
        tbxml = nil;
        if (self = [self initWithBucketName:strBucketName key:strKey  eTag:strETag size:size filePartsArray:filePartsArray]) {
            ;
        }
        [filePartsArray release];
        return self;
    }
    else {
        return nil;
    }

}
@end
