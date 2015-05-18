//
//  ArticlesPublishedViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-23.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLocateView.h"
#import "MessagePhotoView.h"
#import "ClassifyCell.h"
@interface ArticlesPublishedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MessagePhotoViewDelegate,TSLocateDelegate>
@property(nonatomic,strong)IBOutlet UITableView* tableview;
@property(nonatomic,strong) MessagePhotoView* photoView;

@end
