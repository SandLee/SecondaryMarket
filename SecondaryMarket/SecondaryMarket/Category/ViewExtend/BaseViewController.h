//
//  BaseViewController.h
//  SunLightCloud
//
//  Created by wuxinyi on 14-10-31.
//  Copyright (c) 2014年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableview;
- (void)viewDidCurrentView;
@end
