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
#import "DefaultServiceClient.h"
#import "ResponseMessage.h"
#import "Request.h"
#import "ExecutionContext.h"
#import "HttpClient.h"
#import "RequestMessage.h"
#import "IResultParser.h"
#import "IResponseHandler.h"
#import "HttpUtil.h"
#import "NSString+Starts.h"
#import "ClientConfiguration.h"
#import "OSSError.h"

@interface DefaultServiceClient()<HttpClientDelegate>
-(Request*) buildRequest:(RequestMessage*) requestMessage executionContext:(ExecutionContext*) executionContext;
-(void)sendRequestCore:(Request*)request executionContext:(ExecutionContext*) executionContext;
-(void) pause:(int) j;
-(void) handleResponse:(ResponseMessage*) responseMessage  responseHandlers:(NSArray*) responseHandlers;
-(BOOL)shouldRetryErrorCode: (int) errorCode retryTimes:( int) retryTimes;
@end
@implementation DefaultServiceClient
@synthesize delegate;
-(void) dealloc
{
    /*
    if (_httpClient != nil) {
        [_httpClient release];
        _httpClient = nil;
    }
     */
    [_config release];
    _config = nil;
    if (_resultParser != nil) {
        [_resultParser release];
        _resultParser = nil;

    }
    [super dealloc];
}
-(id) initWithClientConfiguration:(ClientConfiguration*)config
{
    if (self = [super init]) {
        _config = config;
        [_config retain];
        _retryCount = 0;
       
    }
    return self;
}
+(id) DefaultServiceClientWithClientConfiguration:(ClientConfiguration*)config 

{
    DefaultServiceClient * sc = [[DefaultServiceClient alloc ] initWithClientConfiguration:config ];
    return [sc autorelease];
}
-(void)sendRequestCore:(Request*)request executionContext:(ExecutionContext*) executionContext
{
    /*
    if (_httpClient != nil) {
        [_httpClient release];
        _httpClient = nil;
    }
     */
    HttpClient *httpClient = [[HttpClient alloc] initWithClientConfiguration:_config request:request executionContext:executionContext] ;
    httpClient.userInfo = request.userInfo;
    _retryCount = 0;
    httpClient.delegate = self;
    [httpClient excute];
   
}
-(void) httpClientFinished:(HttpClient*) httpClient responseMessage:(ResponseMessage*)responseMessage
{
    [self handleResponse:responseMessage responseHandlers:httpClient.executionContext.responseHandlers];
    responseMessage.userInfo = httpClient.userInfo;
    if ([self.delegate respondsToSelector:@selector(serviceClientRequestFinished:result:)]) {
        /*
        id obj;
        if (_resultParser != nil) {
            obj =[_resultParser getObject:responseMessage];
        }
        else {
            obj = responseMessage;
        }
        */
        id obj = responseMessage;
        [self.delegate serviceClientRequestFinished:self result:obj];
    
    }
    if (httpClient != nil) {
        [httpClient release];
    }
}
-(void) httpClientFailed:(HttpClient*) httpClient responseMessage:(ResponseMessage*)responseMessage
{
 
    [self pause:_retryCount];
    _retryCount++;
    //重试
    if ([self shouldRetryErrorCode:responseMessage.statusCode retryTimes:_retryCount]) 
    {
        [httpClient excute];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(serviceClientRequestFailed:error:)]) {
            /*
            OSSError *error = [[OSSError alloc] initWithErrorCode:[NSString stringWithFormat:@"%d",responseMessage.statusCode] message:@"Failed" stringToSignBytes:@"" signatureProvided:@"" stringToSign:@"" ossAccessKeyId:@"" requestId:@"" hostId:@""];
             */
            NSString * error = [NSString stringWithFormat:@"Failed-%d",responseMessage.statusCode];
            
            [self.delegate serviceClientRequestFailed:self error:error];
           // [error release];
        }
        if (httpClient != nil) {
            [httpClient release];
        }
        
    }
}
-(void) sendRequest:(RequestMessage*) requestMessage executionContext: (ExecutionContext*)executionContext resultParser:(id<IResultParser> )resultParser
{
    if (_resultParser != resultParser) {
        [_resultParser release];
    }
    _resultParser = resultParser;
    [_resultParser retain];
    
    if (executionContext.signer != nil) {
        [executionContext.signer sign:requestMessage];
    }
    Request * request = [self buildRequest:requestMessage executionContext: executionContext];
    [self sendRequestCore:request executionContext: executionContext];
       
}
-(void) sendRequest:(RequestMessage*) requestMessage executionContext: (ExecutionContext*)executionContext 
{
  
    if (executionContext.signer != nil) {
        [executionContext.signer sign:requestMessage];
    }
    Request * request = [self buildRequest:requestMessage executionContext: executionContext];
    [self sendRequestCore:request executionContext: executionContext];
    
}

-(Request*) buildRequest:(RequestMessage*) requestMessage executionContext:(ExecutionContext*) executionContext
{
    Request *localRequest = [[Request alloc] init ];
    localRequest.method =  requestMessage.method;
    localRequest.headers = requestMessage.headers;
    localRequest.userInfo = requestMessage.userInfo;
    if (localRequest.headers != nil)
    {
        [HttpUtil convertHeaderCharsetToIso88591:localRequest.headers];
    }
    NSString* str1 = requestMessage.endpoint;
    NSMutableString* strRes=[[NSMutableString alloc] initWithCapacity:200];
    [strRes appendString:str1];
    if ((![str1 endsWith:@"/"]) &&
        ((requestMessage.resourcePath != nil)||(![requestMessage.resourcePath startsWith:@"/"])))
    {
        [strRes appendString:@"/"];
    }
    
    if (requestMessage.resourcePath != nil)
    {
        [strRes appendString:requestMessage.resourcePath];
    }
    NSString *str2;
    
    str2 = [HttpUtil paramToQueryStringOrder:requestMessage.parameters  encoding:executionContext.charset];
    
    int i = requestMessage.content != nil ? 1 : 0;
  //  int i = 1;
    int j = (requestMessage.method == HttpMethod_POST) ? 1 : 0;
    int k = (j == 0) || (i != 0) ? 1 : 0;
    if ((str2 != nil) && (k != 0))
    {
        [strRes appendString:@"?"];
        [strRes appendString:str2];
    }
    localRequest.uri = strRes;
    [strRes release];
    if ((j != 0) && (requestMessage.content == nil) && (str2 != nil))
    {
        NSData * data = [[NSData alloc] initWithBytes:[str2 cStringUsingEncoding:executionContext.charset] length:strlen([str2 cStringUsingEncoding:executionContext.charset])];
        localRequest.content = data;
        localRequest.contentLength = [data length];
        [data release];
        
        
    }
    else
    {
        localRequest.content=requestMessage.content;
        localRequest.contentLength = requestMessage.contentLength;
    }
    return [localRequest autorelease];
}

-(void) pause:(int) j
{
    
    int i = 300;
    long l = pow(2.0, j) * i;
    [NSThread sleepForTimeInterval:l];
    
}
-(void) handleResponse:(ResponseMessage*) responseMessage  responseHandlers:(NSArray*) responseHandlers
{
    for(id<IResponseHandler> handle in responseHandlers)
    {     
        [handle handle:responseMessage];
    }
} 

-(BOOL)shouldRetryErrorCode: (int) errorCode retryTimes:( int) retryTimes
{
    if (retryTimes > _config.maxErrorRetry)
    {
        return NO;
    }
    if ((errorCode == 500) || (errorCode == 503))
    {
        
        return YES;
    }
    return NO;
}

@end
