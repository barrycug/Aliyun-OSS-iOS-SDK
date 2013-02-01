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
#import "NSArray+Bucketlist.h"
#import "TBXML.h"
#import "Bucket.h"
#import "Owner.h"
#import "DateUtil.h"
@implementation NSArray (Bucklist)
-(id) initWithBucketListXMLData:(NSData*) data
{
    if (data != nil)
    {
        NSMutableArray * interArray = [[NSMutableArray alloc] initWithCapacity:10];
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *ownerXMLElement = [TBXML childElementNamed:@"Owner" parentElement: rootXMLElement];
            TBXMLElement *ownerIDXMLElement= [TBXML childElementNamed:@"ID" parentElement: ownerXMLElement];
            NSString * strOwnerID = [TBXML textForElement:ownerIDXMLElement];
            TBXMLElement *ownerDisplayNameXMLElement= [TBXML childElementNamed:@"DisplayName" parentElement: ownerXMLElement];
            NSString * strDisplayName = [TBXML textForElement:ownerDisplayNameXMLElement];
            TBXMLElement *bucketsXMLElement = [TBXML childElementNamed:@"Buckets" parentElement: rootXMLElement];
            
            TBXMLElement *bucketXMLElement = bucketsXMLElement->firstChild;
            while (bucketXMLElement) {
                Owner * owner = [[Owner alloc] initWithOwnerID:strOwnerID displayName:strDisplayName];
                TBXMLElement *nameXMLElement= [TBXML childElementNamed:@"Name" parentElement: bucketXMLElement];
                NSString * strName = [TBXML textForElement:nameXMLElement];
                TBXMLElement *creationDateXMLElement= [TBXML childElementNamed:@"CreationDate" parentElement: bucketXMLElement];
                NSString * strCreationDate = [TBXML textForElement:creationDateXMLElement];
                Bucket * bucket = [[Bucket alloc] initWithName:strName owner:owner creationDate:[DateUtil parseIso8601Date:strCreationDate]];
                [owner release];
                [interArray addObject:bucket];
                [bucket release];
                bucketXMLElement = bucketXMLElement->nextSibling;
            }
            
        }
        [tbxml release];
        tbxml = nil;
        if (self =[self initWithArray:interArray]) 
        {
            
        }
        [interArray release];
        return self;
    }
                   
    else {
        return nil;
    }
}
@end
