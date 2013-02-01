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
#import "CannedAccessControlList.h"
#import "TBXML.h"
@interface CannedAccessControlList()
-(NSString *) type2String:(CannedAclType) type;
@end
@implementation CannedAccessControlList

@synthesize cannedAclType = _cannedAclType;
-(void) dealloc
{
    [super dealloc];
}
/*
 <AccessControlPolicy> 
 <Owner> 
 <ID>1355944407736541</ID> 
 <DisplayName>1355944407736541</DisplayName> 
 </Owner> 
 <AccessControlList> 
 <Grant>public-read-write</Grant> 
 </AccessControlList> 
 </AccessControlPolicy>
 */
-(id) initWithXMLData:(NSData*)data
{
    NSString * strAcl = @"";
    if (data != nil) {
        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *aclXMLElement = [TBXML childElementNamed:@"AccessControlList" parentElement: rootXMLElement];
            TBXMLElement * grantXMLElement = [TBXML childElementNamed:@"Grant" parentElement: aclXMLElement]; 
            strAcl = [TBXML textForElement:grantXMLElement];
        }
        [tbxml release];
        tbxml = nil; 
        CannedAclType type = [CannedAccessControlList stringToType:strAcl];
        if (self = [self initWithCannedAclType:type]) {
            ;
        }
        return self;
         
    }
    else {
        return  nil;
    }
}
-(id) initWithCannedAclType:(CannedAclType ) cannedAclType
{
    if (self = [super init]) {
        _cannedAclType = cannedAclType;
    }
    return self;
}

+(id) cannedAclWithCannedAclType:(CannedAclType ) cannedAclType
{
    CannedAccessControlList * cannedAclList = [[CannedAccessControlList alloc] initWithCannedAclType:cannedAclType];
    return [cannedAclList autorelease];
}
+(CannedAclType) stringToType:(NSString*) strCannedAclType
{
    CannedAclType type = CannedAclType_Invalid;
    if (strCannedAclType!= nil) {
        if ([[strCannedAclType lowercaseString] isEqualToString:@"private"]) {
            type = CannedAclType_Private;
        }else  if ([[strCannedAclType lowercaseString] isEqualToString:@"public-read"]) {
            type = CannedAclType_PublicRead;
        }else if ([[strCannedAclType lowercaseString] isEqualToString:@"public-read-write"]) {
            type = CannedAclType_PublicReadWrite;
        }
    }
    return type;
}
-(NSString*)cannedAclString
{
    return [self type2String:_cannedAclType];
}
-(NSString *) type2String:(CannedAclType) type
{
    NSString * str = @"";
    switch (type) {
           
        case CannedAclType_Invalid:
        {
            str = @"invalid";
        }
            break;
        case CannedAclType_Private:
        {
            str = @"private";
        }
            break;
        case CannedAclType_PublicRead:
        {
            str = @"public-read";
        }
            break;
        case CannedAclType_PublicReadWrite:
        {
            str = @"public-read-write";
        }
            break;
        default:
            break;
    }
    return str;
}
@end
