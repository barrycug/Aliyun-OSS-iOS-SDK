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
#import "PartListing.h"
#import "Owner.h"
#import "TBXML.h"
#import "PartSummary.h"
#import "DateUtil.h"
#import "OSSUtils.h"
@implementation PartListing
@synthesize bucketName = _bucketName;
@synthesize key = _key;
@synthesize uploadId = _uploadId;
@synthesize maxParts = _maxParts;
@synthesize partNumberMarker = _partNumberMarker;
@synthesize owner = _owner;
@synthesize initiator = _initiator;
@synthesize storageClass = _storageClass;
@synthesize isTruncated = _isTruncated;
@synthesize nextPartNumberMarker = _nextPartNumberMarker;
@synthesize parts = _parts;
-(id) initWithBucketName:(NSString*)bucketName 
                     key:(NSString*)key 
                uploadId:(NSString*)uploadId 
                maxParts:(int)maxParts 
        partNumberMarker:(int)partNumberMarker 
                   owner:(Owner*)owner  
               initiator:(Owner*)initiator 
            storageClass:(NSString*)storageClass 
             isTruncated:(BOOL)isTruncated 
    nextPartNumberMarker:(int)nextPartNumberMarker 
                   parts:(NSMutableArray *)parts
{
    if (self =[super init]) {
        _bucketName = bucketName;
        [_bucketName retain];
        _key = key;
        [_key retain];
        _uploadId = uploadId;
        [_uploadId retain];
        _maxParts = maxParts;
        _partNumberMarker = partNumberMarker;
        _owner = owner;
        [_owner retain];
        _isTruncated = isTruncated;
        _initiator = initiator;
        [_initiator retain];
        _storageClass = storageClass;
        [_storageClass retain];
        _nextPartNumberMarker = nextPartNumberMarker;
        _parts = parts;
        [_parts retain];
        
    }
    return self;
}
+(id) PartListingWithBucketName:(NSString*)bucketName 
                            key:(NSString*)key 
                       uploadId:(NSString*)uploadId 
                       maxParts:(int)maxParts 
               partNumberMarker:(int)partNumberMarker 
                          owner:(Owner*)owner  
                      initiator:(Owner*)initiator 
                   storageClass:(NSString*)storageClass 
                    isTruncated:(BOOL)isTruncated 
           nextPartNumberMarker:(int)nextPartNumberMarker 
                          parts:(NSMutableArray *)parts
{
    PartListing * pl = [[PartListing alloc] initWithBucketName:bucketName key:key uploadId:uploadId maxParts:maxParts partNumberMarker:partNumberMarker owner:owner initiator:initiator storageClass:storageClass isTruncated:isTruncated nextPartNumberMarker:nextPartNumberMarker parts:parts];
    return [pl autorelease];
}

-(id) initWithXMLData:(NSData*) data
{
    if (data != nil) {
        NSString * strBucketName = @"";
        NSString * strKey = @"";
        NSString * strMaxParts = @"";
        int maxParts = 0;
        NSString * strNextPartNumberMarker = @"";
        int nextPartNumberMarker = 0;
        NSString * strPartNumberMarker= @"";
        int partNumberMarker=0;
        Owner *initiator=nil;
        Owner *owner=nil;
        NSString *strUploadId = @"";
         BOOL isTruncated=NO;
        NSString *strStorageClass = @"";
        NSMutableArray * parts = nil;
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *bucketXMLElement = [TBXML childElementNamed:@"Bucket" parentElement: rootXMLElement];
            if (bucketXMLElement != nil) {
                strBucketName = [TBXML textForElement:bucketXMLElement];
            }
            TBXMLElement *initiatorXMLElement = [TBXML childElementNamed:@"Initiator" parentElement: rootXMLElement];
            if (initiatorXMLElement != nil)
            {
                NSString * ownerID;
                NSString * displayName;
                TBXMLElement *ownerIDXMLElement = [TBXML childElementNamed:@"ID" parentElement: initiatorXMLElement];
                if (ownerIDXMLElement!= nil) {
                    ownerID = [TBXML textForElement:initiatorXMLElement];
                }
                TBXMLElement *displayNameXMLElement = [TBXML childElementNamed:@"DisplayName" parentElement: initiatorXMLElement];
                if (displayNameXMLElement!= nil) {
                    displayName = [TBXML textForElement:displayNameXMLElement];
                }
                initiator = [[Owner alloc] initWithOwnerID:ownerID displayName:displayName];
              
            }
            TBXMLElement *keyXMLElement = [TBXML childElementNamed:@"Key" parentElement: rootXMLElement];
            if (keyXMLElement!= nil) {
                strKey = [TBXML textForElement:keyXMLElement];
            }
            TBXMLElement *maxPartsXMLElement = [TBXML childElementNamed:@"MaxParts" parentElement: rootXMLElement];
            if (maxPartsXMLElement!= nil) {
                strMaxParts = [TBXML textForElement:maxPartsXMLElement];
                maxParts = [strMaxParts intValue];
            }
            TBXMLElement *nextPartNumberMarkerXMLElement = [TBXML childElementNamed:@"NextPartNumberMarker" parentElement: rootXMLElement];
            if (nextPartNumberMarkerXMLElement!= nil) {
                strNextPartNumberMarker = [TBXML textForElement:nextPartNumberMarkerXMLElement];
                nextPartNumberMarker = [strNextPartNumberMarker intValue];
            }
            TBXMLElement *ownerXMLElement = [TBXML childElementNamed:@"Owner" parentElement: rootXMLElement];
            if (ownerXMLElement != nil)
            {
                NSString * ownerID=@"";
                NSString * displayName=@"";
                TBXMLElement *ownerIDXMLElement = [TBXML childElementNamed:@"ID" parentElement: ownerXMLElement];
                if (ownerIDXMLElement!= nil) {
                    ownerID = [TBXML textForElement:initiatorXMLElement];
                }
                TBXMLElement *displayNameXMLElement = [TBXML childElementNamed:@"DisplayName" parentElement: ownerXMLElement];
                if (displayNameXMLElement!= nil) {
                    displayName = [TBXML textForElement:displayNameXMLElement];
                }
                owner = [[Owner alloc] initWithOwnerID:ownerID displayName:displayName];
                
            }
            TBXMLElement *partNumberMarkerXMLElement = [TBXML childElementNamed:@"PartNumberMarker" parentElement: rootXMLElement];
            if (partNumberMarkerXMLElement!= nil) {
                strPartNumberMarker = [TBXML textForElement:partNumberMarkerXMLElement];
                partNumberMarker = [strPartNumberMarker intValue];
            }
            TBXMLElement * partXMLElement = [TBXML childElementNamed:@"Part" parentElement: rootXMLElement];
            parts = [[NSMutableArray alloc] initWithCapacity:5];
            while (partXMLElement) {
                int partNum = 0;
                NSDate * lastModified = nil;
                NSString * strEtag1=@"" ;
                NSString * strPartNum =@"";
                NSString * strSize=@"";
                NSString * strLastModified=@"";
                long size=0;
                
                TBXMLElement *partNumberXMLElement = [TBXML childElementNamed:@"PartNumber" parentElement: partXMLElement];
                if (partNumberXMLElement!= nil) {
                    strPartNum = [TBXML textForElement:partNumberMarkerXMLElement];
                    partNum = [strPartNum intValue];
                }
                TBXMLElement *eTagXMLElement = [TBXML childElementNamed:@"ETag" parentElement: partXMLElement];
                if (eTagXMLElement!= nil) {
                    strEtag1 = [TBXML textForElement:eTagXMLElement];
                    strEtag1 =[OSSUtils trimQuotes:strEtag1];
                    
                }
                TBXMLElement *lastModifiedXMLElement = [TBXML childElementNamed:@"LastModified" parentElement: partXMLElement];
                if (lastModifiedXMLElement!= nil) {
                    strLastModified = [TBXML textForElement:lastModifiedXMLElement];
                    lastModified = [DateUtil parseIso8601Date:strLastModified];
                }
                TBXMLElement *sizeXMLElement = [TBXML childElementNamed:@"Size" parentElement: partXMLElement];
                if (sizeXMLElement!= nil) {
                    strSize= [TBXML textForElement:sizeXMLElement];
                    size = [strSize longLongValue];
                }
                PartSummary * ps = [[PartSummary alloc] initWithPartNumber:partNum lastModified:lastModified eTag:strEtag1 size:size];
                [parts addObject:ps];
                [ps release];
                partXMLElement = [TBXML nextSiblingNamed:@"Part" searchFromElement:partXMLElement];
            }
            
            TBXMLElement *storageClassXMLElement = [TBXML childElementNamed:@"StorageClass" parentElement: rootXMLElement];
            if (storageClassXMLElement!= nil) {
                strStorageClass= [TBXML textForElement:storageClassXMLElement];
            }
            NSString *strIsTruncated = @"";
           
            TBXMLElement *isTruncatedXMLElement = [TBXML childElementNamed:@"IsTruncated" parentElement: rootXMLElement];
            if (isTruncatedXMLElement!= nil) {
                strIsTruncated= [TBXML textForElement:isTruncatedXMLElement];
                if ([strIsTruncated isEqualToString:@"true"]) {
                    isTruncated = YES;
                }
                else
                {
                    isTruncated = NO;
                }
            }
            
           
            TBXMLElement *uploadIdXMLElement = [TBXML childElementNamed:@"UploadId" parentElement: rootXMLElement];
            if (uploadIdXMLElement!= nil) {
                strUploadId= [TBXML textForElement:uploadIdXMLElement];
                
            }
        }
        [tbxml release];
        tbxml = nil;
        if (self = [self initWithBucketName:strBucketName key:strKey uploadId:strUploadId maxParts:maxParts partNumberMarker:partNumberMarker owner:owner initiator:initiator storageClass:strStorageClass isTruncated:isTruncated nextPartNumberMarker:nextPartNumberMarker parts:parts]) {
            ;
        }
        [parts release];
        [owner release];
        [initiator release];
        return self;
    }
    else {
        return nil;
    }
}
@end
