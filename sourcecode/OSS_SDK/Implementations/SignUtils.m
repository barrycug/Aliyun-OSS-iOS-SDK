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
#import "SignUtils.h"
#import "RequestMessage.h"
#import "NSString+Starts.h"
#import "OSSUtils.h"
static  SignUtils *g_signUtils = nil;
@interface SignUtils()
-(NSString*) buildCanonicalizedResourcePath:(NSString*) resourcePath params:(NSDictionary*) params;

-(BOOL) isStringInArray:(NSArray*) array string:(NSString*) string;
@end
@implementation SignUtils
-(void) dealloc
{
    [_signedParamters release];
    _signedParamters = nil;
    [super dealloc];
}
-(id) init
{
    if (self = [super init]) 
    {
        _newLine = @"\n";
        _signedParamters = [[NSArray alloc] initWithObjects:@"group",@"delete",@"acl",@"uploadId",@"partNumber",@"uploads", @"response-cache-control",@"response-content-disposition",@"response-content-encoding", @"response-content-language",@"response-content-type",@"response-expires" ,nil];
    }
    return  self;
}
+(id) defaultSignUtils
{
    if (g_signUtils == nil) {
        g_signUtils = [[SignUtils alloc] init];
    }
    return g_signUtils ;
}
-(NSString*) buildCanonicalString:(HttpMethod)httpMethod resourcePath:(NSString*) resourcePath  requestMessage:(RequestMessage*) requestMessage
{
    NSMutableString * strRtn = [[NSMutableString alloc] initWithString:@""];
    NSString * strHttpMethod = [OSSUtils HttpMethod2String:httpMethod];
    [strRtn appendString:strHttpMethod];
    [strRtn appendString:_newLine];
    NSAssert(!(requestMessage == nil),@"requestMessage nil");
    NSDictionary * localDict = requestMessage.headers;
  
    NSMutableDictionary * passHeaders = [NSMutableDictionary dictionaryWithCapacity:[localDict count]];
    NSEnumerator *enumerator = [localDict keyEnumerator];  
    id key;  
    NSString *str=@"";
    while ((key = [enumerator nextObject]))   
    {  
        NSString * strKey = (NSString *) key;
        str = [strKey lowercaseString];
        if ([str isEqualToString:[[NSString stringWithString:@"Content-Type"] lowercaseString]]||
            [str isEqualToString:[[NSString stringWithString:@"Content-MD5"] lowercaseString]]||
            [str isEqualToString:[[NSString stringWithString:@"Date"] lowercaseString]]||
            [str startsWith:@"x-oss-"]
            ) 
        {
            [passHeaders setObject:[localDict objectForKey:key] forKey:key];
        }
    }
    if ([passHeaders objectForKey:@"Content-Type"] == nil) {
         [passHeaders setObject:@"" forKey:@"Content-Type"];
    }
    if ([passHeaders objectForKey:@"Content-MD5"] == nil) {
        [passHeaders setObject:@"" forKey:@"Content-MD5"];
    }
    NSDictionary * paramDict = requestMessage.parameters;
    if (requestMessage != nil &&  paramDict!= nil) {
        NSEnumerator *enumeratorParam = [paramDict keyEnumerator];  
        id keyParam;  
        NSString *str=@"";
        while ((keyParam = [enumeratorParam nextObject]))   
        {
            NSString * strKeyParam = (NSString *) keyParam;
            str = [strKeyParam lowercaseString];
            if ([str startsWith:@"x-oss-"]) {
                 [passHeaders setObject:str forKey:[paramDict objectForKey:keyParam]];
            }
        }
    }
    NSArray *sortArray =[[passHeaders allKeys] sortedArrayUsingComparator:^(id a, id b)
                         {
                             return [a compare:b];
                         }];
    for (NSString * keyPass in sortArray) 
    {
       
        NSString * value = [passHeaders objectForKey:keyPass];
        if ([keyPass startsWith:@"x-oss-"]) {
            [strRtn appendString:keyPass];
            [strRtn appendString:@":"];
            [strRtn appendString:value];
        }
        else {
            [strRtn appendString:value];
        }
        [strRtn appendString:_newLine];
    
    }
  //  [strRtn appendString:_newLine];
    [strRtn appendString:[self buildCanonicalizedResourcePath:resourcePath  params:paramDict]];
    return [strRtn autorelease];

}
-(BOOL) isStringInArray:(NSArray*) array string:(NSString*) string
{
    NSAssert(!(string==nil),@"");
    BOOL identicalStringFound = NO;
    for (NSString *someString in array) {
        if ([someString isEqualToString:string]) {
            identicalStringFound = YES;
            break;
        }
    }
    return identicalStringFound;
}
-(NSString*) buildCanonicalizedResourcePath:(NSString*) resourcePath params:(NSDictionary*) params
{
    NSAssert([resourcePath startsWith:@"/"],@"resourcePath no /");
    NSMutableString * strRtn = [[NSMutableString alloc] initWithString:@""];
    [strRtn appendString:resourcePath];
    if (params != nil) {
         //按key排序 从小到大
        NSArray *sortArray =[[params allKeys] sortedArrayUsingComparator:^(id a, id b)
                             {
                                 return [a compare:b];
                             }];
        NSString * c = @"?";
        for (NSString * key in sortArray) {
            NSString * value = [params objectForKey:key];
            if (![self isStringInArray:_signedParamters string:key]) {
                 continue;
            }
            
            [strRtn appendString:c];
            [strRtn appendString:key];
            if (value != nil &&(![value isEqualToString:@""])) {
                [strRtn appendString:@"="];
                [strRtn appendString:value];
            }           
            c = @"&";

        }
    }
    return  [strRtn autorelease];
    
}



@end
