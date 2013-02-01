//
//  ViewController.h
//  samples_ios
//
//  Created by baocai zhang on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AliyunOpenServiceSDK/OSS.h>
 

@interface ViewController : UIViewController
{
    OSSClient * _client;

}
@property (strong,nonatomic) IBOutlet UITableView * tableView;
@property (strong,nonatomic) NSArray * buckets;
@end
