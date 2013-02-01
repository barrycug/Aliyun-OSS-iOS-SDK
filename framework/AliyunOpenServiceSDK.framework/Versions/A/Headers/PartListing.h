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
#import <Foundation/Foundation.h>
@class Owner;
/**
 PartListing 类，存储ListPart 方法返回的结果
 */
@interface PartListing : NSObject
{    
    NSString *_bucketName;
    NSString *_key;
    NSString *_uploadId;
    int _maxParts;
    int _partNumberMarker;
    Owner *_owner;
    Owner *_initiator;
    NSString *_storageClass;
    BOOL _isTruncated;
    int _nextPartNumberMarker;
    NSMutableArray *_parts;
}
/**
bucket 名称
 */
@property(nonatomic,retain) NSString *bucketName;
/**
 Object 名称
 */
@property(nonatomic,retain)NSString *key;
/**
上传ID
 */
@property(nonatomic,retain)NSString *uploadId;
/**
 maxParts
 */
@property(nonatomic,assign)int maxParts;
/**
 partNumberMarker
 */
@property(nonatomic,assign)int partNumberMarker;
/**
 所有者
 */
@property(nonatomic,retain)Owner *owner;
/**
 initiator
 */
@property(nonatomic,retain)Owner *initiator;
/**
 storageClass
 */
@property(nonatomic,retain)NSString *storageClass;
/**
 isTruncated
 */
@property(nonatomic,assign)BOOL isTruncated;
/**
 nextPartNumberMarker
 */
@property(nonatomic,assign)int nextPartNumberMarker;
/**
 parts 数组内对象为PartSummary类型
 */
@property(nonatomic,retain)NSMutableArray *parts;
/**
 初始化方法
 @param bucketName NSString
 @param key NSString
 @param uploadId NSString
 @param maxParts int
 @param partNumberMarker int
 @param owner Owner
 @param initiator Owner
 @param storageClass NSString
 @param isTruncated BOOL
 @param nextPartNumberMarker NSMutableArray
  @param parts int
 */
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
                   parts:(NSMutableArray *)parts;
/**
 静态初始化方法 返回autorelease 对象
 @param bucketName NSString
 @param key NSString
 @param uploadId NSString
 @param maxParts int
 @param partNumberMarker int
 @param owner Owner
 @param initiator Owner
 @param storageClass NSString
 @param isTruncated BOOL
 @param nextPartNumberMarker NSMutableArray
 @param parts int
 */
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
                   parts:(NSMutableArray *)parts;
@end
@interface PartListing(XMLData)
-(id) initWithXMLData:(NSData*) data;
@end
