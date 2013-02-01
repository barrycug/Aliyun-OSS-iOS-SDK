//
//  AppDelegate.h
//  samples_ios
//
//  Created by baocai zhang on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * naviController;
@property (strong, nonatomic) ViewController *viewController;

@end
