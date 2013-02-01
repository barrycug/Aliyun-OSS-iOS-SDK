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
#import "ObjectListing.h"
#import "TBXML.h"
#import "OSSObjectSummary.h"
#import "DateUtil.h"
#import "Owner.h"
#import "OSSUtils.h"

@implementation ObjectListing
@synthesize objectSummaries = _objectSummaries;
@synthesize commonPrefixes = _commonPrefixes;
@synthesize bucketName = _bucketName;
@synthesize nextMarker = _nextMarker;
@synthesize isTruncated = _isTruncated;
@synthesize prefix = _prefix;
@synthesize marker = _marker;
@synthesize maxKeys = _maxKeys;
@synthesize delimiter = _delimiter; 
-(void) dealloc
{
    self.objectSummaries = nil;
    self.commonPrefixes= nil; 
    self.bucketName= nil;
    self.nextMarker= nil; 
    self.prefix= nil;
    self.marker= nil; 
    self.delimiter= nil;
    [super dealloc];
}
-(id) initWithObjectSummaries:(NSMutableArray *)objectSummaries 
               commonPrefixes:(NSMutableArray *)commonPrefixes 
                   bucketName:(NSString*) bucketName 
                   nextMarker:(NSString*) nextMarker 
                  isTruncated:(BOOL) isTruncated 
                       prefix:(NSString*)prefix 
                       marker:(NSString*) marker 
                      maxKeys:(int) maxKeys 
                    delimiter:(NSString*)delimiter
{
    if (self = [super init]) {
        _objectSummaries = objectSummaries;
        [_objectSummaries retain];
        _commonPrefixes = commonPrefixes;
        [_commonPrefixes retain];
        _bucketName = bucketName;
        [_bucketName retain];
        _nextMarker = nextMarker;
        [_nextMarker retain];
        _isTruncated = isTruncated;
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
+(id) ObjectListingWithObjectSummaries:(NSMutableArray *)objectSummaries 
                        commonPrefixes:(NSMutableArray *)commonPrefixes 
                            bucketName:(NSString*) bucketName 
                            nextMarker:(NSString*) nextMarker 
                           isTruncated:(BOOL) isTruncated 
                                prefix:(NSString*)prefix 
                                marker:(NSString*) marker 
                               maxKeys:(int) maxKeys 
                             delimiter:(NSString*)delimiter
{
    ObjectListing * ol = [[ObjectListing alloc] initWithObjectSummaries:objectSummaries commonPrefixes:commonPrefixes bucketName:bucketName nextMarker:nextMarker isTruncated:isTruncated prefix:prefix marker:marker maxKeys:maxKeys delimiter:delimiter];
    return [ol autorelease];
}
/*
 <ListBucketResult> 
 <Name>my_oss</Name> 
 <Prefix>fun/</Prefix> 
 <Marker></Marker> 
 <MaxKeys>100</MaxKeys> 
 <Delimiter>/</Delimiter>
 <IsTruncated>false</IsTruncated> 
 <Contents>
 <Key>fun/test.jpg</Key> <LastModified>2012-02-24T08:42:32.000Z</LastModified> <ETag>&quot;5B3C1A2E053D763E1B002CC607C5A0FE&quot;</ETag> <Type>Normal</Type>
 <Size>344606</Size>
 <StorageClass>Standard</StorageClass>
 <Owner>
 <ID>00220120222</ID>
 <DisplayName>oss_doc</DisplayName> </Owner>
 </Contents>
 <CommonPrefixes>
 <Prefix>fun/movie/</Prefix> </CommonPrefixes>
 </ListBucketResult>
 */
-(id) initWithXMLData:(NSData*)data
{
    if (data != nil) {
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        NSString * strName=@"";
        NSString * strPrefix=@"";
        NSString * strMarker=@"";
        NSString * strNextMarker=@"";
        NSString * strMaxKeys=@"";
        NSString * strDelimiter=@"";
        BOOL       isTruncated=NO;
        NSMutableArray * contents = [[NSMutableArray alloc] initWithCapacity:10];
        NSMutableArray * commPprefixs = [[NSMutableArray alloc] initWithCapacity:10];
        
        if (rootXMLElement != nil) {
            TBXMLElement *nameXMLElement = [TBXML childElementNamed:@"Name" parentElement: rootXMLElement];
             strName = [TBXML textForElement:nameXMLElement];
            TBXMLElement *prefixXMLElement = [TBXML childElementNamed:@"Prefix" parentElement: rootXMLElement];
            strPrefix = [TBXML textForElement:prefixXMLElement];
            TBXMLElement *nextMarkerXMLElement = [TBXML childElementNamed:@"NextMarker" parentElement: rootXMLElement];
            if (nextMarkerXMLElement != nil) {
                strNextMarker = [TBXML textForElement:nextMarkerXMLElement];
            }
            TBXMLElement *isTruncatedXMLElement = [TBXML childElementNamed:@"IsTruncated" parentElement: rootXMLElement];
            if (isTruncatedXMLElement != nil) 
            {
                NSString *strIsTruncated = [TBXML textForElement:isTruncatedXMLElement];
                if ([[strIsTruncated lowercaseString] isEqualToString:@"true"]) 
                {
                    isTruncated = YES;
                }
                else {
                    isTruncated = NO;
                }
            }
           
            TBXMLElement *markerXMLElement = [TBXML childElementNamed:@"Marker" parentElement: rootXMLElement];
             if (markerXMLElement != nil) 
             {
                 strMarker = [TBXML textForElement:markerXMLElement];
             }
            TBXMLElement *maxKeysXMLElement = [TBXML childElementNamed:@"MaxKeys" parentElement: rootXMLElement];
             if (maxKeysXMLElement != nil) 
             {
                 strMaxKeys = [TBXML textForElement:maxKeysXMLElement];
             }
            TBXMLElement *delimiterXMLElement = [TBXML childElementNamed:@"Delimiter" parentElement: rootXMLElement];
            if (delimiterXMLElement != nil) 
            {
                 strDelimiter = [TBXML textForElement:delimiterXMLElement];
            }
           
            TBXMLElement * contentElement =[TBXML  childElementNamed:@"Contents" parentElement:rootXMLElement];
            TBXMLElement *element  = contentElement;
            while (element != nil) {
                TBXMLElement *keyXMLElement = [TBXML childElementNamed:@"Key" parentElement: element];
                 NSString * strkey = @"";
                if (keyXMLElement != nil) 
                {
                    strkey  = [TBXML textForElement:keyXMLElement];
                }
                TBXMLElement *lastModifiedXMLElement = [TBXML childElementNamed:@"LastModified" parentElement: element];
                 NSString * strLastModified = @"";
                if (lastModifiedXMLElement != nil) 
                {
                    strLastModified  = [TBXML textForElement:lastModifiedXMLElement];
                }
               
                TBXMLElement *eTagXMLElement = [TBXML childElementNamed:@"ETag" parentElement: element];
                NSString * strETag = @"";
                if (eTagXMLElement != nil) 
                {
                  strETag = [TBXML textForElement:eTagXMLElement];
                    strETag =  [ OSSUtils trimQuotes:strETag];
                }
                TBXMLElement *sizeXMLElement = [TBXML childElementNamed:@"Size" parentElement: element];
                NSString * strSize = @"";
                if (sizeXMLElement != nil) {
                    strSize  = [TBXML textForElement:sizeXMLElement];
                }
               
                TBXMLElement *storageClassXMLElement = [TBXML childElementNamed:@"StorageClass" parentElement: element];
                NSString * strStorageClass = @"";
                if (storageClassXMLElement != nil) {
                     strStorageClass  = [TBXML textForElement:storageClassXMLElement];
                }
               
                TBXMLElement *ownerXMLElement = [TBXML childElementNamed:@"Owner" parentElement: element];
                TBXMLElement *ownerIDXMLElement= [TBXML childElementNamed:@"ID" parentElement: ownerXMLElement];
                NSString * strOwnerID = [TBXML textForElement:ownerIDXMLElement];
                TBXMLElement *ownerDisplayNameXMLElement= [TBXML childElementNamed:@"DisplayName" parentElement: ownerXMLElement];
                NSString * strDisplayName = [TBXML textForElement:ownerDisplayNameXMLElement];
                Owner * owner = [[Owner alloc] initWithOwnerID:strOwnerID displayName:strDisplayName];
                OSSObjectSummary *ossObjSunnary = [[OSSObjectSummary alloc] initWithBucketName:strName key:strkey eTag:strETag size:[strSize longLongValue] lastModified:[DateUtil parseIso8601Date:strLastModified] storageClass:strStorageClass owner:owner];
                [owner release];
                [contents addObject:ossObjSunnary];
                [ossObjSunnary release];
                element =[TBXML nextSiblingNamed:@"Contents" searchFromElement:element];
            }
            /*
             <CommonPrefixes>
             <Prefix>fun/movie/</Prefix> </CommonPrefixes>
             */
            TBXMLElement * commonPrefixesElement =[TBXML  childElementNamed:@"CommonPrefixes" parentElement:rootXMLElement];
            TBXMLElement *elementCommon  = commonPrefixesElement;
            while (elementCommon != nil) 
            {
                 TBXMLElement * prefixElement =[TBXML  childElementNamed:@"Prefix" parentElement:elementCommon];
                if (prefixElement != nil) 
                {
                    NSString * strPrefixNew = [TBXML textForElement:prefixElement];
                    [commPprefixs addObject:strPrefixNew];
                }               
                 elementCommon =[TBXML nextSiblingNamed:@"CommonPrefixes" searchFromElement:elementCommon];
            }
        }
        [tbxml release];
        tbxml = nil; 
        if (self = [self initWithObjectSummaries:contents commonPrefixes:commPprefixs bucketName:strName nextMarker:strNextMarker isTruncated:isTruncated prefix:strPrefix marker:strMarker maxKeys:[strMaxKeys intValue] delimiter:strDelimiter]) {
            
        }
        {
            ;
        }
        [contents release];
        [commPprefixs release];
        return self;
    }
    else {
        return  nil;
    }
}
@end
