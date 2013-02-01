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
#import "OSSError.h"
#import "TBXML.h"
@implementation OSSError
@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;
@synthesize errorStringToSignBytes = _errorStringToSignBytes;
@synthesize errorSignatureProvided = _errorSignatureProvided;
@synthesize errorStringToSign = _errorStringToSign;
@synthesize errorOSSAccessKeyId = _errorOSSAccessKeyId;
@synthesize errorRequestId = _errorRequestId;
@synthesize errorHostId = _errorHostId;
-(void) dealloc
{
    [_errorCode release]; _errorCode= nil;
    [_errorMessage release];_errorMessage = nil;
    [_errorStringToSignBytes release];_errorStringToSignBytes = nil;
    [_errorSignatureProvided release];_errorSignatureProvided = nil;
    [_errorStringToSign release];_errorStringToSign = nil;
    [_errorOSSAccessKeyId release];_errorOSSAccessKeyId = nil;
    [_errorRequestId release];_errorRequestId = nil;
    [_errorHostId release];_errorHostId = nil;
    [super dealloc];
}
-(id) initWithErrorCode:(NSString*) code 
                  message:(NSString*) message 
        stringToSignBytes:(NSString*) stringToSignBytes 
        signatureProvided:(NSString*) signatureProvided 
             stringToSign:(NSString*) stringToSign 
           ossAccessKeyId:(NSString*) ossAccessKeyId 
                requestId:(NSString*) requestId 
                   hostId:(NSString*) hostId
{
    if (self = [super init]) {
        _errorCode = code;
        [_errorCode retain];
        _errorMessage = message;
        [_errorMessage retain];
        _errorStringToSignBytes = stringToSignBytes;
        [_errorStringToSignBytes retain];
        _errorSignatureProvided = signatureProvided;
        [_errorSignatureProvided retain];
        _errorStringToSign = stringToSign;
        [_errorStringToSign retain];
        _errorOSSAccessKeyId = ossAccessKeyId;
        [_errorOSSAccessKeyId retain];
        _errorRequestId = requestId;
        [_errorRequestId retain];
        _errorHostId = hostId;
        [_errorHostId retain];
        
    }
    return self;
}

+(id) OSSErrorWithErrorCode:(NSString*) code 
                    message:(NSString*) message 
          stringToSignBytes:(NSString*) stringToSignBytes 
          signatureProvided:(NSString*) signatureProvided 
               stringToSign:(NSString*) stringToSign 
             ossAccessKeyId:(NSString*) ossAccessKeyId 
                  requestId:(NSString*) requestId 
                     hostId:(NSString*) hostId
{
    OSSError * error = [[OSSError alloc] initWithErrorCode:code 
                                                   message:message 
                                         stringToSignBytes:stringToSignBytes 
                                         signatureProvided:signatureProvided 
                                              stringToSign:stringToSign 
                                            ossAccessKeyId:ossAccessKeyId 
                                                 requestId:requestId 
                                                    hostId:hostId];
    return [error autorelease];
}
-(id) initWithData:(NSData *) data
{
    NSString * code = @"";
    NSString * message = @"";
    NSString * stringToSignBytes = @"";
    NSString * signatureProvided = @"";
    NSString  * stringToSign = @"";
    NSString * ossAccessKeyId = @"";
    NSString * requestId = @"";
    NSString * hostId = @"";
    if (data != nil) 
    {        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *codeXMLElement = [TBXML childElementNamed:@"Code" parentElement: rootXMLElement];
            if (codeXMLElement != nil) {
                 code = [TBXML textForElement:codeXMLElement];
            }
           
            TBXMLElement *messageXMLElement = [TBXML childElementNamed:@"Message" parentElement: rootXMLElement];
            if (messageXMLElement != nil) {
                message = [TBXML textForElement:messageXMLElement];
            }
             
            TBXMLElement *stringToSignBytesXMLElement = [TBXML childElementNamed:@"StringToSignBytes" parentElement: rootXMLElement];
            if (stringToSignBytesXMLElement != nil) {
                stringToSignBytes = [TBXML textForElement:stringToSignBytesXMLElement];
            }
            
            TBXMLElement *signatureProvidedXMLElement = [TBXML childElementNamed:@"SignatureProvided" parentElement: rootXMLElement];
            if(signatureProvidedXMLElement != nil)
            {
                signatureProvided = [TBXML textForElement:signatureProvidedXMLElement];
            }
            TBXMLElement *stringToSignXMLElement = [TBXML childElementNamed:@"StringToSign" parentElement: rootXMLElement];
            if (stringToSignXMLElement != nil) {
                 stringToSign = [TBXML textForElement:stringToSignXMLElement];
            }
           
            TBXMLElement *ossAccessKeyIdXMLElement = [TBXML childElementNamed:@"OSSAccessKeyId" parentElement: rootXMLElement];
            if (ossAccessKeyIdXMLElement != nil) {
                 ossAccessKeyId = [TBXML textForElement:ossAccessKeyIdXMLElement]; 
            }
           
            TBXMLElement *requestIdXMLElement = [TBXML childElementNamed:@"RequestId" parentElement: rootXMLElement];
            if (requestIdXMLElement != nil) {
                requestId = [TBXML textForElement:requestIdXMLElement]; 
            }
            
            TBXMLElement *hostIdXMLElement = [TBXML childElementNamed:@"HostId" parentElement: rootXMLElement];
            if (hostIdXMLElement != nil) {
                hostId = [TBXML textForElement:hostIdXMLElement];
            }
            
           
        }
        [tbxml release];
        tbxml = nil; 
    }

    if(self = [self initWithErrorCode:code 
                              message:message 
                    stringToSignBytes:stringToSignBytes 
                    signatureProvided:signatureProvided 
                         stringToSign:stringToSign
                       ossAccessKeyId:ossAccessKeyId 
                            requestId:requestId 
                               hostId:hostId]
       )
    {
        ;
    }
    return self;
}
+(id) OSSErrorWithData:(NSData *) data
{
    OSSError * error = [[OSSError alloc] initWithData:data];
    return [error autorelease];
}
@end
