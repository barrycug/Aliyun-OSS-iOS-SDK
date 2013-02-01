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
#import "HttpClient.h"
#import "ASIHttpRequest.h"
#import "ClientConfiguration.h"
#import "Request.h"
#import "ResponseMessage.h"
#import "HttpUtil.h"

@interface HttpClient()<ASIHTTPRequestDelegate>
-(ResponseMessage*) makeResponseMessage:(ASIHTTPRequest *)request;
@end
@implementation HttpClient
@synthesize delegate;
@synthesize request = _request;
@synthesize executionContext = _executionContext;
@synthesize userInfo = _userInfo;
-(void) dealloc
{
    [_asirequest clearDelegatesAndCancel];
    [_asirequest release];
    _asirequest = nil;
    [_executionContext release];
    _executionContext = nil;
    [_request release];
    _request = nil;
    self.userInfo = nil;
    [super dealloc];
}
-(id) initWithClientConfiguration:(ClientConfiguration*) clientConfiguration request:(Request*) request executionContext: (ExecutionContext*) executionContext
{
    if (self = [super init]) {
        _request = request ;
        [_request retain];
        _executionContext = executionContext;
        [_executionContext retain];
        _asirequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:request.uri]];
        _asirequest.delegate = self;
        _asirequest.timeOutSeconds = clientConfiguration.connectionTimeout;
        _asirequest.userAgent = clientConfiguration.userAgent;
        
        if (clientConfiguration.proxyHost != nil && 
            (![clientConfiguration.proxyHost isEqualToString:@""]) &&
            clientConfiguration.proxyPort >0 ) {
            [_asirequest setProxyHost:clientConfiguration.proxyHost];
            [_asirequest setProxyPort:clientConfiguration.proxyPort];
            
            // Set a username and password for authenticating proxies
            [_asirequest setProxyUsername:clientConfiguration.proxyUsername];
            [_asirequest setProxyPassword:clientConfiguration.proxyPassword];
            
            // For NTLM proxies, you can also set the domain (NTLM proxies are untested!)
            [_asirequest setProxyDomain:clientConfiguration.proxyWorkstation];
        }
        switch (request.method) {
            case HttpMethod_GET:
            {
                [_asirequest setRequestMethod:@"GET"];
            }
                break;
            case HttpMethod_PUT:
            {
                [_asirequest setRequestMethod:@"PUT"];
                [_asirequest appendPostData:request.content]; 
            }
                break; 
            case HttpMethod_POST:
            {
                [_asirequest setRequestMethod:@"POST"];
                [_asirequest appendPostData:request.content];    

            }
                break;
            case HttpMethod_HEAD:
            {
                [_asirequest setRequestMethod:@"HEAD"];
            }
                break;
            case HttpMethod_DELETE:
            {
                [_asirequest setRequestMethod:@"DELETE"];
            }
                break;
            default:
                break;
        }
        NSMutableDictionary * dictHeaders= request.headers ;
        NSEnumerator * enumerator = [dictHeaders keyEnumerator];
        id key;
        NSString * str;
        while ((key = [enumerator nextObject]))   
        {  
            NSString * strKey = (NSString *) key;
            NSString * strValue = [dictHeaders objectForKey:key];
            str = [strKey lowercaseString];
            if ([str isEqualToString:[[NSString stringWithString:@"Content-Length"] lowercaseString]]||                
                [str isEqualToString:[[NSString stringWithString:@"Host"] lowercaseString]]
                
                ) 
            {
                continue;

            }
            [_asirequest addRequestHeader:strKey value:strValue];
        }
        NSString * strContentType = [[_asirequest requestHeaders] objectForKey:@"Content-Type"] ;
        if (strContentType == nil || [strContentType length] == 0) {
            [_asirequest addRequestHeader:@"Content-Type" value:@""]; 
        }
        
    }
return self;
}
-(void) requestFailed:(ASIHTTPRequest *)request 
{
    if ([self.delegate respondsToSelector:@selector(httpClientFailed:responseMessage:)] ) {
        ResponseMessage *responseMessage =  [self makeResponseMessage:request];
        [self.delegate httpClientFailed:self  responseMessage:responseMessage ];
    }
}
-(void) requestFinished:(ASIHTTPRequest *)request 
{
    if ([self.delegate respondsToSelector:@selector(httpClientFinished:responseMessage:)] ) {
        ResponseMessage *responseMessage =  [self makeResponseMessage:request];
        [self.delegate httpClientFinished:self  responseMessage:responseMessage ];
    }
   
}

-(ResponseMessage*) makeResponseMessage:(ASIHTTPRequest *)request
{
    ResponseMessage *responseMessage = [[ ResponseMessage alloc] init] ;
    responseMessage.uri = request.url.absoluteString;
    responseMessage.statusCode = request.responseStatusCode;
    NSData * content = [request.responseData copy];
    responseMessage.content = content;
    responseMessage.contentLength = [content length];
    [content release];
    NSDictionary * dict =[request.responseHeaders copy];
    NSMutableDictionary *headers =[[NSMutableDictionary alloc] initWithDictionary:dict ];
    [dict release];
    
    [HttpUtil convertHeaderCharsetFromIso88591:headers];
    responseMessage.headers = headers;
    [headers release];
    return [responseMessage autorelease];
}
+(id) HttpClientWithClientConfiguration:(ClientConfiguration*) clientConfiguration request:(Request*) request executionContext: (ExecutionContext*) executionContext
{
    HttpClient * httpClient = [[HttpClient alloc] initWithClientConfiguration:clientConfiguration request:request executionContext:executionContext];
    return [httpClient autorelease];
}
-(void) excute
{
    [_asirequest startAsynchronous];
}
@end
