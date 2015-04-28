//
//  MessageViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"
#import "PersonMsgViewController.h"
#import "SystemMsgViewController.h"
@interface MessageViewController : UIViewController<QCSlideSwitchViewDelegate>
@property (nonatomic, strong) QCSlideSwitchView *slideSwitchView;
@property (nonatomic, strong) PersonMsgViewController *PersonMsg;//
@property (nonatomic, strong) SystemMsgViewController *SystemMsg;
@property (nonatomic, strong) BaseViewController *SelectView;

@end
