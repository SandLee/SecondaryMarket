//
//  LoginViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-20.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView* tableview;
@end
