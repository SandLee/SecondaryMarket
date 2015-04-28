//
//  ToMyBodyCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLScrollViewer.h"
#import "ToBuyView.h"
#import "ToSaleView.h"
#import "ToFavView.h"
@interface ToMyBodyCell : UITableViewCell
@property(nonatomic ,strong)XLScrollViewer *scroll;//如果无需外部调用XLScrollViewer的属性，则无需写此属性
@end
