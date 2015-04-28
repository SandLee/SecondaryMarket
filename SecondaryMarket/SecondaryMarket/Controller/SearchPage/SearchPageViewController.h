//
//  SearchPageViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableview;

@property (nonatomic,strong)NSMutableArray* RecentCategories;//最近的
@property (nonatomic,strong)NSMutableArray* AllCategories;//所有的
@end
