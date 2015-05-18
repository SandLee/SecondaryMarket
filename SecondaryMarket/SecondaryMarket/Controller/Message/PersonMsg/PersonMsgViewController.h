//
//  PersonMsgViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PersonMsgCell.h"
#import "CBTextView.h"
@interface PersonMsgViewController : BaseViewController<ReplyPageDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,retain)CBTextView *textView;

@end
