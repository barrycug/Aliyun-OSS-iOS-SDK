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
#import "MultipartUploadListing.h"
#import "TBXML.h"
#import "MultipartUpload.h"
#import "DateUtil.h"
@implementation MultipartUploadListing
@synthesize  bucketName = _bucketName;
@synthesize  delimiter = _delimiter;
@synthesize  prefix = _prefix;
@synthesize  maxUploads = _maxUploads;
@synthesize  keyMarker = _keyMarker;
@synthesize  uploadIdMarker = _uploadIdMarker;
@synthesize isTruncated = _isTruncated;
@synthesize nextKeyMarker = _nextKeyMarker;
@synthesize nextUploadIdMarker = _nextUploadIdMarker;
@synthesize multipartUploads = _multipartUploads;
@synthesize commonPrefixes = _commonPrefixes;
-(void) dealloc
{
    self.bucketName = nil;
    self.delimiter = nil;
    self.prefix = nil;
    self.keyMarker = nil;
    self.uploadIdMarker = nil;
    self.nextKeyMarker = nil;
    self.nextUploadIdMarker = nil;
    self.multipartUploads = nil;
    self.commonPrefixes = nil;
    [super dealloc];
}
-(id) initWithBucketName:(NSString*)bucketName
               delimiter:(NSString *)delimiter
                  prefix:(NSString *)prefix
              maxUploads:(int) maxUploads
               keyMarker:(NSString *)keyMarker
          uploadIdMarker:(NSString *)uploadIdMarker
             isTruncated:(BOOL)isTruncated
           nextKeyMarker:(NSString *)nextKeyMarker
      nextUploadIdMarker:(NSString*)nextUploadIdMarker
        multipartUploads:(NSMutableArray*)multipartUploads
          commonPrefixes:(NSMutableArray*)commonPrefixes
{
    if (self = [super init]) {
        _bucketName = bucketName;
        [_bucketName retain];
        _delimiter = delimiter;
        [_delimiter retain];
        _prefix = prefix;
        [_prefix retain];
        _maxUploads = maxUploads;
        _keyMarker = keyMarker;
        [_keyMarker retain];
        _uploadIdMarker = uploadIdMarker;
        [_uploadIdMarker retain];
        _isTruncated = isTruncated;
        _nextKeyMarker = nextKeyMarker;
        [_nextKeyMarker retain];
        _nextUploadIdMarker = nextUploadIdMarker;
        [_nextUploadIdMarker retain];
        _multipartUploads = multipartUploads;
        [_multipartUploads retain];
        if (commonPrefixes == nil) {
            _commonPrefixes = [[NSMutableArray alloc] initWithCapacity:10];
        }
        else {
            _commonPrefixes = commonPrefixes;
            [_commonPrefixes retain];
        }
        
    }
    return self;
}
+(id) MultipartUploadListingWithBucketName:(NSString*)bucketName
                                 delimiter:(NSString *)delimiter
                                    prefix:(NSString *)prefix
                                maxUploads:(int) maxUploads
                                 keyMarker:(NSString *)keyMarker
                            uploadIdMarker:(NSString *)uploadIdMarker
                               isTruncated:(BOOL)isTruncated
                             nextKeyMarker:(NSString *)nextKeyMarker
                        nextUploadIdMarker:(NSString*)nextUploadIdMarker
                          multipartUploads:(NSMutableArray*)multipartUploads
                            commonPrefixes:(NSMutableArray*)commonPrefixes
{
    MultipartUploadListing * mul = [[MultipartUploadListing alloc] initWithBucketName:bucketName delimiter:delimiter prefix:prefix maxUploads:maxUploads keyMarker:keyMarker uploadIdMarker:uploadIdMarker isTruncated:isTruncated nextKeyMarker:nextKeyMarker nextUploadIdMarker:nextUploadIdMarker multipartUploads:multipartUploads commonPrefixes:commonPrefixes];
    return  [mul autorelease];
}
-(id) initWithXMLData:(NSData*)data
{
    if (data != nil) {
        NSString * strBucketName = @"";
        NSString * strPrefix=@"";
        NSString * strKeyMarker=@"";
        NSString * strNextMarker=@"";
        NSString * strDelimiter=@"";
        NSString * strNextUploadIdMarker=@"";
        NSString * strUploadIdMarker=@"";
        int maxUploads = 0;
        BOOL       isTruncated=NO;
        NSMutableArray * commPprefixs = [[NSMutableArray alloc] initWithCapacity:10];
        NSMutableArray * uploads = [[NSMutableArray alloc] initWithCapacity:10];
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *bucketXMLElement = [TBXML childElementNamed:@"Bucket" parentElement: rootXMLElement];
            if (bucketXMLElement != nil) {
                strBucketName = [TBXML textForElement:bucketXMLElement];
            }
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
                elementCommon =[TBXML nextSiblingNamed:@"Prefix" searchFromElement:elementCommon];
            }
            TBXMLElement *markerXMLElement = [TBXML childElementNamed:@"KeyMarker" parentElement: rootXMLElement];
            if (markerXMLElement != nil) 
            {
                strKeyMarker = [TBXML textForElement:markerXMLElement];
            }
            TBXMLElement *maxKeysXMLElement = [TBXML childElementNamed:@"MaxUploads" parentElement: rootXMLElement];
            if (maxKeysXMLElement != nil) 
            {
                NSString *strMaxUploads = [TBXML textForElement:maxKeysXMLElement];
                maxUploads = [strMaxUploads intValue];
            }
            TBXMLElement *delimiterXMLElement = [TBXML childElementNamed:@"Delimiter" parentElement: rootXMLElement];
            if (delimiterXMLElement != nil) 
            {
                strDelimiter = [TBXML textForElement:delimiterXMLElement];
            }
            TBXMLElement * uploadElement =[TBXML  childElementNamed:@"Upload" parentElement:rootXMLElement];
            TBXMLElement *element  = uploadElement;
            while (element != nil) 
            {
                NSString * striKey = @"";
                NSString * strInitiated = @"";
                NSString * strStorageClass = @"";
                NSString * strUploadId=@"";
                NSDate    * initiated=nil;
                
                TBXMLElement * iKeyElement =[TBXML  childElementNamed:@"Key" parentElement:element];
                if (iKeyElement != nil) 
                {
                    striKey = [TBXML textForElement:iKeyElement];
                   
                } 
                TBXMLElement * iInitiatedElement =[TBXML  childElementNamed:@"Initiated" parentElement:element];
                if (iInitiatedElement != nil) 
                {
                    strInitiated = [TBXML textForElement:iInitiatedElement];
                    initiated = [DateUtil parseRfc822Date:strInitiated];
                    
                } 
                TBXMLElement * iStorageClassElement =[TBXML  childElementNamed:@"StorageClass" parentElement:element];
                if (iStorageClassElement != nil) 
                {
                    strStorageClass = [TBXML textForElement:iStorageClassElement];
                    
                } 
                TBXMLElement * iUploadIdElement =[TBXML  childElementNamed:@"UploadId" parentElement:element];
                if (iUploadIdElement != nil) 
                {
                    strUploadId = [TBXML textForElement:iUploadIdElement];
                    
                } 
                MultipartUpload *upload = [[MultipartUpload alloc] initWithKey:striKey uploadId:strUploadId storageClass:strStorageClass initiated:initiated];
                [uploads addObject:upload];
                [upload release];
                element =[TBXML nextSiblingNamed:@"Upload" searchFromElement:element];
            }
            TBXMLElement *prefixXMLElement = [TBXML childElementNamed:@"Prefix" parentElement: rootXMLElement];
            strPrefix = [TBXML textForElement:prefixXMLElement];
            TBXMLElement *nextMarkerXMLElement = [TBXML childElementNamed:@"NextKeyMarker" parentElement: rootXMLElement];
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
            
            TBXMLElement *uploadIdXMLElement = [TBXML childElementNamed:@"UploadIdMarker" parentElement: rootXMLElement];
            if (uploadIdXMLElement != nil) 
            {
                strUploadIdMarker = [TBXML textForElement:uploadIdXMLElement];
            }
            TBXMLElement *nextUploadIdXMLElement = [TBXML childElementNamed:@"NextUploadIdMarker" parentElement: rootXMLElement];
            if (nextUploadIdXMLElement != nil) 
            {
                strNextUploadIdMarker = [TBXML textForElement:nextUploadIdXMLElement];
            }
        

        }
        [tbxml release];
        tbxml = nil;
        if (self = [self initWithBucketName:strBucketName delimiter:strDelimiter prefix:strPrefix maxUploads:maxUploads keyMarker:strKeyMarker uploadIdMarker:strUploadIdMarker isTruncated:isTruncated nextKeyMarker:strNextMarker nextUploadIdMarker:strNextUploadIdMarker multipartUploads:uploads commonPrefixes:commPprefixs]) {
            ;
        }
        [uploads release];
        [commPprefixs release];
        return self;
    }
    else {
        return nil;
    }
}
/*
 localMultipartUploadListing.setBucketName(localElement1.getChildText("Bucket"));
 List localList = localElement1.getChildren("CommonPrefixes");
 Object localObject1 = localList.iterator();
 while (((Iterator)localObject1).hasNext())
 {
 localObject2 = (Element)((Iterator)localObject1).next();
 localMultipartUploadListing.getCommonPrefixes().add(((Element)localObject2).getChildText("Prefix"));
 }
 localMultipartUploadListing.setDelimiter(localElement1.getChildText("Delimiter"));
 localMultipartUploadListing.setKeyMarker(localElement1.getChildText("KeyMarker"));
 localMultipartUploadListing.setMaxUploads(Integer.valueOf(localElement1.getChildText("MaxUploads")).intValue());
 localObject1 = new ArrayList();
 localMultipartUploadListing.setMultipartUploads((List)localObject1);
 Object localObject2 = localElement1.getChildren("Upload").iterator();
 while (((Iterator)localObject2).hasNext())
 {
 Element localElement2 = (Element)((Iterator)localObject2).next();
 MultipartUpload localMultipartUpload = new MultipartUpload();
 if (localElement2.getChild("Initiated") == null)
 continue;
 ((List)localObject1).add(localMultipartUpload);
 localMultipartUpload.setInitiated(DateUtil.parseIso8601Date(localElement2.getChildText("Initiated")));
 localMultipartUpload.setKey(localElement2.getChildText("Key"));
 localMultipartUpload.setStorageClass(localElement2.getChildText("StorageClass"));
 localMultipartUpload.setUploadId(localElement2.getChildText("UploadId"));
 }
 localMultipartUploadListing.setNextKeyMarker(localElement1.getChildText("NextKeyMarker"));
 localMultipartUploadListing.setNextUploadIdMarker(localElement1.getChildText("NextUploadIdMarker"));
 localMultipartUploadListing.setPrefix(localElement1.getChildText("Prefix"));
 localMultipartUploadListing.setTruncated(Boolean.valueOf(localElement1.getChildText("IsTruncated")).booleanValue());
 localMultipartUploadListing.setUploadIdMarker(localElement1.getChildText("UploadIdMarker"));
 */
@end
