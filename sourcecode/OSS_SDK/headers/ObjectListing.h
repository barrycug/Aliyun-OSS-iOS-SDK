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
/**
 ObjectListing 类，List Object方法的返回结果
 */
@interface ObjectListing : NSObject
{
@private
    NSMutableArray *_objectSummaries;
    NSMutableArray *_commonPrefixes;
    NSString* _bucketName;
    NSString* _nextMarker;
    BOOL _isTruncated;
    NSString* _prefix;
    NSString* _marker;
    int _maxKeys;
    NSString* _delimiter;     
}
/**
 objectSummaries 数组内存储对象类型为NSString
 */
@property(nonatomic,retain)NSMutableArray *objectSummaries;
/**
 commonPrefixes 数组内存储对象类型为NSString
 */
@property(nonatomic,retain)NSMutableArray *commonPrefixes;
/**
 bucketName
 */
@property(nonatomic,retain)NSString* bucketName;
/**
 nextMarker
 */
@property(nonatomic,retain)NSString* nextMarker;
/**
 isTruncated
 */
@property(nonatomic,assign)BOOL isTruncated;
/**
 prefix
 */
@property(nonatomic,retain)NSString* prefix;
/**
 marker
 */
@property(nonatomic,retain)NSString* marker;
/**
 maxKeys
 */
@property(nonatomic,assign)int maxKeys;
/**
 delimiter
 */
@property(nonatomic,retain)NSString* delimiter;

-(id) initWithObjectSummaries:(NSMutableArray *)objectSummaries 
               commonPrefixes:(NSMutableArray *)commonPrefixes 
                   bucketName:(NSString*) bucketName 
                   nextMarker:(NSString*) nextMarker 
                  isTruncated:(BOOL) isTruncated 
                       prefix:(NSString*)prefix 
                       marker:(NSString*) marker 
                      maxKeys:(int) maxKeys 
                    delimiter:(NSString*)delimiter;
+(id) ObjectListingWithObjectSummaries:(NSMutableArray *)objectSummaries 
               commonPrefixes:(NSMutableArray *)commonPrefixes 
                   bucketName:(NSString*) bucketName 
                   nextMarker:(NSString*) nextMarker 
                  isTruncated:(BOOL) isTruncated 
                       prefix:(NSString*)prefix 
                       marker:(NSString*) marker 
                      maxKeys:(int) maxKeys 
                    delimiter:(NSString*)delimiter;
@end
@interface ObjectListing(XMLData)
-(id) initWithXMLData:(NSData*)data;
@end
