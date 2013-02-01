//
//  ViewController.m
//  samples_ios
//
//  Created by baocai zhang on 12-8-22.
//  Copyright (c) 2012年 baocai zhang. All rights reserved.
//

//在此处修改自己的aliyun OSS服务的 AccessID 和AccessKey

#define accessid @"aaaaa"
#define accesskey @"bbbb="
//在此处修改自己的aliyun OTS服务的 AccessID 和AccessKey
#define accessid @"9e0g1wvcoc9889d4c685iyq3"
#define accesskey @"MzxWwbrsHrFxnQCgY3ET8suIqck="


#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController ()<OSSClientDelegate>

@end

@implementation ViewController
@synthesize tableView = _tableView;
@synthesize buckets = _buckets;
-(void)dealloc
{
    self.tableView = nil;
    [_client release];
    _client = nil;
    /*
    [_otsClient release];
    _otsClient = nil;
     */
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _client = [[OSSClient alloc] initWithAccessId:accessid andAccessKey:accesskey];
    _client.delegate = self;
    /*
    _otsClient = [[OTSClient alloc] initWithAccessId:otsaccessid andAccessKey:otsaccesskey];
    _otsClient.delegate = self;
     */
    [self listBucket];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"Buckets";
    [super viewDidAppear:animated];
    _client.delegate = self;
}
#pragma mark UITableView 委托/代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if results is not nil and we have results, return that number
	
	int rtn=0;
	
	rtn = [self.buckets count];
	
	
	return rtn;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Bucket *bucket = [self.buckets objectAtIndex:indexPath.row];

	NSString *strIndex =[NSString stringWithFormat:@"%@",bucket.name];
	cell.textLabel.text = strIndex;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.imageView.image = [UIImage imageNamed:@"bucket.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Bucket *bucket = [self.buckets objectAtIndex:indexPath.row];

	DetailsViewController * detailsVC = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    detailsVC.client = _client;
    detailsVC.bucketName = bucket.name;
    detailsVC.prefix = @"";
    [self.navigationController pushViewController:detailsVC animated:YES];
    [detailsVC release];
}


#pragma mark OSS相关方法调用示例
/*
 creatBucket
 */
-(void) creatBucket
{
    [_client createBucket:@"barrycc101"];

}
-(void) deleteBucket
{
    [_client deleteBucket:@"barrycc101"];
}
-(void)writeBucketAcl
{
    CannedAccessControlList * cAcl = [CannedAccessControlList cannedAclWithCannedAclType:CannedAclType_PublicReadWrite];
    [_client writeBucketAcl:@"barrycc101" cannedAccessControlList:cAcl];
}
-(void)readBucketAcl
{
    [_client readBucketAcl:@"barrycc101"];
}
-(void) listBucket
{
    [_client listBuckets];
}
-(void)isBucketExist
{
    [_client isBucketExist:@"barrycc101"];
}
-(void) listObjects
{
    ListObjectsRequest * lor = [[ListObjectsRequest alloc] initWithBucketName:@"barrycc101" prefix:nil marker:nil maxKeys:0 delimiter:nil];
      [_client listObjects:lor];
}
-(void) putObject
{
    NSData * data = [[NSString stringWithString:@"中国"]  dataUsingEncoding:NSUTF8StringEncoding];
    ObjectMetadata * objMetadata = [[ObjectMetadata alloc] init];
    [_client putObject:@"barrycc101" key:@"test222" data:data objectMetadata:objMetadata];
    [objMetadata release];
}
-(void) fetchObject
{
    [_client fetchObject:@"barrycc101" key:@"test222"];
}
-(void)fetchObjectMetadata
{
    [_client fetchObjectMetadata: @"barrycc101" key:@"test222"];
}
-(void) copyObject
{
    CopyObjectRequest *cor = [[CopyObjectRequest alloc] initWithSourceBucketName:@"barrycc101" sourceKey:@"test222" destinationBucketName:@"barrycug11" destinationKey:@"test222"];
    [_client copyObject:cor];
}
-(void) deleteObject
{
    [_client deleteObject:@"barrycc101" key:@"test222"];
}
-(void) deleteMultipleObjects
{
    [_client  deleteMultipleObjects:@"barrycc101" objectNames:[NSArray arrayWithObjects:@"a/",@"b/", nil] isQuiet:YES];
}
-(void)postObjectGroup
{
    //调用改方法前请使用fetchObject 方法获取object的etag
    NSString * etag =@"C13DCEABCB143ACD6C9298265D618A9F";
    NSString * etag2 =@"C13DCEABCB143ACD6C9298265D618A9F";
    ObjectGroupPartETag * epTag1 = [[ObjectGroupPartETag alloc] initWithPartNumber:1 partName:@"test222"eTag:etag];
    ObjectGroupPartETag * epTag2 = [[ObjectGroupPartETag alloc] initWithPartNumber:2 partName:@"test333"eTag:etag2];
    PostObjectGroupRequest * pogr = [[PostObjectGroupRequest alloc] initWithBucketName:@"barrycc101" objectGroupName:@"test444" objectGroupPartETags:[NSArray arrayWithObjects:epTag1,epTag2, nil]];
    [_client postObjectGroup:pogr];
}
-(void)fetchObjectGroupIndex
{
    [_client fetchObjectGroupIndex:@"barrycc101" key:@"test444"];
}
-(void)InitiateMultipartUpload
{
    InitiateMultipartUploadRequest * imur = [[InitiateMultipartUploadRequest alloc] initWithBuckName:@"barrycc101" key:@"mObj21" objectMetadata:nil];
    [_client initiateMultipartUpload:imur];
    [imur release];
}
-(void)AbortMultipartUpload
{
    //uploadid 为InitiateMultipartUpload 返回结果
    NSString * uploadid = @"0004C79E54E19021079B355DD09B54EF";
    AbortMultipartUploadRequest * amur = [[AbortMultipartUploadRequest alloc] initWithBuckName:@"barrycc101"  key:@"mObj21" uploadId:uploadid];

    [_client abortMultipartUpload:amur];
    [amur release];
}
-(void)UploadPart
{
     //uploadid 为InitiateMultipartUpload 返回结果
     NSString * uploadid = @"0004C79E54E19021079B355DD09B54EF";
    long len = 6*1024*1024; // 除去最后一个part的大小无限制外，其他part必须大于5m
     char * fileData = malloc(len);
    NSData * data1 =[NSData dataWithBytes:fileData length:len];
    UploadPartRequest *upr = [[UploadPartRequest alloc] initWithBucketName:@"barrycc101" key:@"mObj1" uploadId:uploadid partNumber:2 partSize:len md5Digest:[data1 md5] data:data1];
    free(fileData);

    [_client uploadPart:upr];
    [upr release];
}
-(void) ListParts
{
    //uploadid 为InitiateMultipartUpload 返回结果
    NSString * uploadid = @"0004C79E54E19021079B355DD09B54EF";
    ListPartsRequest * pr = [[ListPartsRequest alloc] initWithBuckName:@"barrycc101" key:@"mObj" uploadId:uploadid maxParts:2 partNumberMarker:1];
    [_client listParts:pr];
    [pr release];
}
-(void) ListMultipartUploads
{
    ListMultipartUploadsRequest * lmur =[[ListMultipartUploadsRequest alloc]initWithBucketName:@"barrycc101" delimiter:nil prefix:nil maxUploads:0 keyMarker:nil uploadIdMarker:nil ];
    [_client listMultipartUploads:lmur];
    [lmur release];
}
-(void) CompleteMultipartUpload
{
    //已经上传数据的etag
    NSString * etag =@"C13DCEABCB143ACD6C9298265D618A9F";
    NSString * etag2 =@"C13DCEABCB143ACD6C9298265D618A9F";

    //uploadid 为InitiateMultipartUpload 返回结果
    NSString * uploadid = @"0004C79E54E19021079B355DD09B54EF";
 PartETag * pe1 = [[PartETag alloc] initWithPartNumber:1 eTag:etag];
 PartETag * pe2 = [[PartETag alloc] initWithPartNumber:2 eTag:etag2];
 NSArray * array = [NSArray arrayWithObjects:pe1,pe2, nil];
 CompleteMultipartUploadRequest * cmur = [[CompleteMultipartUploadRequest alloc] initWithBuckName:@"barrycc101" key:@"mObj1" uploadId:uploadid partETags:array];
 [_client completeMultipartUpload:cmur];
    [pe1 release];
    [pe2 release];
    [cmur release];
 
}
-(void)bucketCreateFinish:(OSSClient*) client result:(Bucket*) bucket
{
    NSLog(@"%@",bucket.name);
}

-(void)bucketCreateFailed:(OSSClient*) client error:(OSSError*) error
{
     NSLog(@"%@",error.errorMessage);
}

-(void)bucketDeleteFinish:(OSSClient*) client result:(NSString*) bucketName
{
     NSLog(@"%@",bucketName);
}

-(void)bucketDeleteFailed:(OSSClient*) client error:(OSSError*) error
{
    NSLog(@"%@",error.errorMessage);
}


-(void)bucketWriteBucketAclFinish:(OSSClient*) client result:(CannedAccessControlList*) result
{
    NSLog(@"%d",result.cannedAclType);
}


-(void)bucketWriteBucketAclFailed:(OSSClient*) client error:(OSSError*) error
{
     NSLog(@"%@",error.errorMessage);
}

-(void)bucketListFinish:(OSSClient*) client result:(NSArray*) bucketList
{
    self.buckets = bucketList;
    [self.tableView reloadData];
}

-(void)bucketListFailed:(OSSClient*) client error:(OSSError*) error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.errorMessage delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    [alert release];
    alert = nil;
    
}

-(void)bucketReadBucketAclFinish:(OSSClient*) client result:(CannedAccessControlList*) result{
    
}
-(void)bucketReadBucketAclFailed:(OSSClient*) client error:(OSSError*) error{
    
}
-(void)bucketIsBucketExistFinish:(OSSClient*) client result:(BOOL) isBucketExist{
    
}
-(void)bucketIsBucketExistFailed:(OSSClient*) client error:(OSSError*) error{
    
}
-(void)bucketListObjectsFinish:(OSSClient*) client result:(ObjectListing*) result
{
    
}
-(void)bucketListObjectsFailed:(OSSClient*) client error:(OSSError*) error{
    
}
-(void)OSSObjectPutObjectFinish:(OSSClient*) client result:(PutObjectResult*) result
{
    
}

/**
 PutObject 方法执行失败，返回OSSError对象
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectPutObjectFailed:(OSSClient*) client error:(OSSError*) error
{
    
}

/**
 FetchObject 方法执行成功，返回OSSObject 对象 
 @param client OSSClient 
 @param result OSSObject
 */
-(void)OSSObjectFetchObjectFinish:(OSSClient*) client result:(OSSObject*) result
{
    
}

/**
 FetchObject 方法执行失败，返回OSSError 对象 
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectFetchObjectFailed:(OSSClient*) client error:(OSSError*) error
{
    
}

/**
 FetchObjectAndWriteToFile 方法执行成功，返回OSSObject 对象 和isWritedToFile对象
 @param client OSSClient 
 @param result OSSObject
 @param isWritedToFile BOOL
 */
-(void)OSSObjectFetchObjectAndWriteToFileFinish:(OSSClient*) client result:(OSSObject*) result isWritedToFile:(BOOL)isWritedToFile 
{
    
}

/**
 FetchObjectAndWriteToFile 方法执行失败，返回OSSError 对象 
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectFetchObjectAndWriteToFileFailed:(OSSClient*) client error:(OSSError*) error
{
    
}

/**
 FetchObjectMetadata 方法执行成功，返回ObjectMetadata 对象 
 @param client OSSClient 
 @param result ObjectMetadata
 */
-(void)OSSObjectFetchObjectMetadataFinish:(OSSClient*) client result:(ObjectMetadata*) result
{
    
}

/**
 FetchObjectMetadata 方法执行失败，返回OSSError 对象 
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectFetchObjectMetadataFailed:(OSSClient*) client error:(OSSError*) error
{
    
}

/**
 CopyObject 方法执行成功，返回CopyObjectResult 对象 
 @param client OSSClient 
 @param result CopyObjectResult
 */
-(void)OSSObjectCopyObjectFinish:(OSSClient*) client result:(CopyObjectResult*) result
{
    
}

/**
 CopyObject 方法执行失败，返回OSSError 对象  
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectCopyObjectFailed:(OSSClient*) client error:(OSSError*) error
{
    
}

/**
 DeleteObject 方法执行成功，返回删除的bucketName 和key
 @param client OSSClient 
 @param bucketName  NSString
 @param key  NSString
 */
-(void)OSSObjectDeleteObjectFinish:(OSSClient*) client bucketName:(NSString*) bucketName key:(NSString*)key
{
    
}

/**
 DeleteObject 方法执行失败，返回OSSError 对象  
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectDeleteObjectFailed:(OSSClient*) client error:(OSSError*) error
{
    
}

/**
 DeleteMultipleObjects 方法执行成功，返回DeleteObjectsResult对象
 @param client OSSClient 
 @param result DeleteObjectsResult
 @param bucketName NSString
 */
-(void)OSSObjectDeleteMultipleObjectsFinish:(OSSClient*) client  bucketName:(NSString*) bucketName result:(DeleteObjectsResult*) result
{
    
}

/**
 DeleteMultipleObjects 方法执行失败，返回OSSError 对象  
 @param client OSSClient 
 @param error OSSError
 */
-(void)OSSObjectDeleteMultipleObjectsFailed:(OSSClient*) client error:(OSSError*) error
{
    
}
/**
 AbortMultipartUpload 方法执行成功，返回uploadId
 @param client OSSClient 
 @param uploadId NSString
 */
-(void) OSSMultipartAbortMultipartUploadFinished:(OSSClient*) client result:(NSString*) uploadId
{
    
}

/**
 AbortMultipartUpload 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartAbortMultipartUploadFailed:(OSSClient*) client error:(OSSError *) error
{
    
}

/**
 CompleteMultipartUpload 方法执行成功，返回CompleteMultipartUploadResult 对象
 @param client OSSClient 
 @param result CompleteMultipartUploadResult
 */
-(void) OSSMultipartCompleteMultipartUploadFinished:(OSSClient*) client result:(CompleteMultipartUploadResult*) result
{
    
}

/**
 CompleteMultipartUpload 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartCompleteMultipartUploadFailed:(OSSClient*) client  error:(OSSError *) error
{
    
}

/**
 InitiateMultipartUpload 方法执行成功，返回InitiateMultipartUploadResult 对象
 @param client OSSClient 
 @param result InitiateMultipartUploadResult
 */
-(void) OSSMultipartInitiateMultipartUploadFinished:(OSSClient*) client result:(InitiateMultipartUploadResult*) result
{
    
}

/**
 InitiateMultipartUpload 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartInitiateMultipartUploadFailed:(OSSClient*) client  error:(OSSError *) error
{
    
}

/**
 ListMultipartUploads 方法执行成功，返回MultipartUploadListing 对象
 @param client OSSClient 
 @param result MultipartUploadListing
 */
-(void) OSSMultipartListMultipartUploadsFinished:(OSSClient*) client result:(MultipartUploadListing*) result
{
    
}

/**
 ListMultipartUploads 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartListMultipartUploadsFailed:(OSSClient*) client  error:(OSSError *) error
{
    
}

/**
 ListParts 方法执行成功，返回PartListing 对象 
 @param client OSSClient 
 @param result PartListing
 */
-(void) OSSMultipartListPartsFinished:(OSSClient*) client result:(PartListing*) result
{
    
}

/**
 ListParts 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartListPartsFailed:(OSSClient*) client  error:(OSSError *) error
{
    
}

/**
 UploadPart 方法执行成功，返回UploadPartResult 对象
 @param client OSSClient 
 @param result UploadPartResult
 */
-(void) OSSMultipartUploadPartFinished:(OSSClient*) client result:(UploadPartResult*) result
{
    
}

/**
 UploadPart 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSMultipartUploadPartFailed:(OSSClient*) client  error:(OSSError *) error
{
    
}

/**
 GroupPostObject 方法执行成功，返回PostObjectGroupResult 对象
 @param client OSSClient 
 @param result PostObjectGroupResult 
 */
-(void) OSSObjectGroupPostObjectGroupFinish:(OSSClient*) client result:(PostObjectGroupResult *) result
{
    
}

/**
 GroupPostObject 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSObjectGroupPostObjectGroupFailed:(OSSClient*) client error:(OSSError *) error
{
    
}

/**
 FetchObjectGroupIndex 方法执行成功，返回FetchObjectGroupIndex 对象
 @param client OSSClient 
 @param result FetchObjectGroupIndexResult 
 */
-(void) OSSObjectGroupFetchObjectGroupIndexFinish:(OSSClient*) client result:(FetchObjectGroupIndexResult *) result
{
    
}

/**
 FetchObjectGroupIndex 方法执行失败，返回OSSError 对象
 @param client OSSClient 
 @param error OSSError
 */
-(void) OSSObjectGroupFetchObjectGroupIndexFailed:(OSSClient*) client error:(OSSError *) error
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
