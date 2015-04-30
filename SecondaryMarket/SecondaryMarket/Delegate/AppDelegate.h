//
//  AppDelegate.h
//  SecondaryMarket
//
//  Created by wuxinyi on 15/4/28.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICETutorialController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController    *tabbar;
@property (assign, nonatomic) BOOL bHomePageSkipDetails;
@property (strong, nonatomic) ICETutorialController *ICETviewController;
-(void)setupLeveyTabBarController;

@end

