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
#import "AbortMultipartUploadRequest.h"
#import "Bucket.h"
#import "CannedAccessControlList.h"
#import "ClientConfiguration.h"
#import "CompleteMultipartUploadRequest.h"
#import "CompleteMultipartUploadResult.h"
#import "CopyObjectResult.h"
#import "CopyObjectRequest.h"
#import "DateUtil.h"
#import "DefaultServiceClient.h"
#import "DeleteObjectsResult.h"
#import "ExecutionContext.h"
#import "FetchObjectGroupIndexResult.h"
#import "FetchObjectRequest.h"
#import "FilePart.h"
#import "HttpUtil.h"
#import "HttpClient.h"
#import "HttpFactory.h"
#import "HttpMethod.h"
#import "HttpMesssage.h"
#import "HttpHeaders.h"
#import "HmacSHA1Signature.h"
#import "InitiateMultipartUploadResult.h"
#import "InitiateMultipartUploadRequest.h"
#import "IRequestSigner.h"
#import "IResponseHandler.h"
#import "IResultParser.h"
#import "IServiceSignature.h"
#import "ListPartsRequest.h"
#import "ListObjectsRequest.h"
#import "ListMultipartUploadsRequest.h"
#import "MultipartUpload.h"
#import "MultipartUploadListing.h"
#import "NSArray+Bucketlist.h"
#import "NSData+MD5.h"
#import "NSString+Starts.h"
#import "ObjectGroupPartETag.h"
#import "ObjectListing.h"
#import "ObjectMetadata.h"
#import "OSSBucketOperation.h"
#import "OSSClient.h"
#import "OSSError.h"
#import "OSSErrorCode.h"
#import "OSSErrorResponseHandler.h"
#import "OSSHeaders.h"
#import "OSSMultipartOperation.h"
#import "OSSObject.h"
#import "OSSObjectGroupOperation.h"
#import "OSSObjectOperation.h"
#import "OSSObjectSummary.h"
#import "OSSOperation.h"
#import "OSSRequestSigner.h"
#import "OSSUtils.h"
#import "Owner.h"
#import "PartETag.h"
#import "PartListing.h"
#import "PartSummary.h"
#import "PostObjectGroupRequest.h"
#import "PostObjectGroupResult.h"
#import "PutObjectResult.h"
#import "Request.h"
#import "RequestMessage.h"
#import "ResponseHeaderOverrides.h"
#import "ResponseMessage.h"
#import "ResponseParser.h"
#import "ServiceCredentials.h"
#import "SignUtils.h"
#import "UploadPartRequest.h"
#import "UploadPartResult.h"


