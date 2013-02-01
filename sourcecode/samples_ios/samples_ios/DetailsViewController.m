//
//  DetailsViewController.m
//  samples_ios
//
//  Created by baocai zhang on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()<OSSClientDelegate>

@end

@implementation DetailsViewController
@synthesize tableView = _tableView;
@synthesize client = _client;
@synthesize bucketName = _bucketName;
@synthesize objects = _objects;
@synthesize prefix = _prefix;
@synthesize folders = _folders;
-(void) dealloc
{
    self.client = nil;
    self.tableView = nil;
    self.bucketName = nil;
    self.objects = nil;
    self.prefix = nil;
    self.folders = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _client.delegate = self;
    ListObjectsRequest * lor = [[ListObjectsRequest alloc] initWithBucketName:self.bucketName prefix:self.prefix marker:nil maxKeys:0 delimiter:@"/"];
    [_client listObjects:lor];
    [lor release];
    lor = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if results is not nil and we have results, return that number
    int rtn =0;

    rtn = [self.folders count] +[self.objects count];

   

	return rtn;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *strIndex;
    if (indexPath.row < [self.folders count]) {
        NSString *strFolder = [self.folders objectAtIndex:indexPath.row];
       NSArray *sSplit = [strFolder componentsSeparatedByString:@"/"]; 
       strIndex =[NSString stringWithFormat:@"%@",[sSplit objectAtIndex:[sSplit count]-2] ];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    }
    else {
        OSSObjectSummary * obj = [self.objects objectAtIndex:indexPath.row-[self.folders count]];
        NSArray *sSplit2 = [obj.key componentsSeparatedByString:@"/"]; 
        NSString *strKey;
        if ([sSplit2 count] >1) {
             strKey =[NSString stringWithFormat:@"%@",[sSplit2 objectAtIndex:[sSplit2 count]-1] ];
        }
        else {
            strKey= obj.key;
        }
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
        strIndex =[NSString stringWithFormat:@"%@",strKey];
    }
   
	cell.textLabel.text = strIndex;
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [self.folders objectAtIndex:indexPath.row];
	DetailsViewController * detailsVC = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    detailsVC.client = _client;
    detailsVC.bucketName = self.bucketName;
    detailsVC.prefix = str;
    [self.navigationController pushViewController:detailsVC animated:YES];
    [detailsVC release];
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)bucketListObjectsFinish:(OSSClient*) client result:(ObjectListing*) result
{
    NSArray * objs = result.objectSummaries; 
    //去掉和prefix 同名的对象
    NSMutableArray * newobjs = [NSMutableArray arrayWithCapacity:[objs count]];
    for (int j =0; j< [objs count]; j++) {
        OSSObjectSummary * objSummary = [objs objectAtIndex:j];
        if (![objSummary.key isEqualToString:self.prefix]) {
            [newobjs addObject:objSummary];
        }
    }
    self.objects = newobjs;
    
    self.folders = result.commonPrefixes;
}

-(void)bucketListObjectsFailed:(OSSClient*) client error:(OSSError*) error
{

}

@end
