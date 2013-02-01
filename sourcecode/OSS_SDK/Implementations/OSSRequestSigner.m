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
#import "OSSRequestSigner.h"
#import "ServiceCredentials.h"
#import "SignUtils.h"
#import "HmacSHA1Signature.h"
@implementation OSSRequestSigner
-(void) dealloc
{
    [_resourcePath release]; 
    _resourcePath = nil;
    [_credentials release];
    _credentials = nil;   
    [_serviceSignature release];
    _serviceSignature = nil;
    [super dealloc];
}
-(id) init{
    if (self = [self initWithHttpMethod:HttpMethod_GET resourcePath:@"" credentials:nil]) {
        ;
    }
    return self;
}
-(id) initWithHttpMethod:(HttpMethod)httpMethod resourcePath:(NSString*)resourcePath credentials:(ServiceCredentials*)credentials
{
    if (self = [super init]) {
        _httpMethod = httpMethod;
        _resourcePath = resourcePath;
        [_resourcePath retain];
        _credentials = credentials;
        _serviceSignature = [[HmacSHA1Signature defaultHmacSHA1Signature] retain];
        [credentials retain];
    }
    return self;
}
+(id) OSSRequestSignerWithHttpMethod:(HttpMethod)httpMethod resourcePath:(NSString*)resourcePath credentials:(ServiceCredentials*)credentials
{
    OSSRequestSigner * ors=[[OSSRequestSigner alloc] initWithHttpMethod:httpMethod resourcePath:resourcePath credentials:credentials];
    return [ors autorelease];
}
-(void) sign:(RequestMessage*) requestMessage
{
    NSString * aKey = _credentials.accessKey;
    NSString * aID  = _credentials.accessID;
    SignUtils * signUtils = [SignUtils defaultSignUtils];
    if (([aID length] > 0 ) && ([aKey length] > 0)) {
       NSString*canonicalString=  [signUtils buildCanonicalString:_httpMethod resourcePath:_resourcePath requestMessage:requestMessage];
      
        NSString * signString =[_serviceSignature computeSignature:canonicalString withSecret:aKey];

        [requestMessage addHeader:@"Authorization" value:[NSString stringWithFormat:@"OSS %@:%@",aID,signString] ];
        
    }
    else if([aID length] > 0) {
        [requestMessage addHeader:@"Authorization" value:aID];
    }
}

@end
