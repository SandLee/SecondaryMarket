//
//  SystemMsgCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemMsgCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel* DateLabel;
@property(nonatomic,strong)IBOutlet UIImageView* imgview;
@property(nonatomic,strong)IBOutlet UILabel* msgLabel;
@end
