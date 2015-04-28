//
//  ToMyHeaderCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToMyViewController;
@interface ToMyHeaderCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView* FigureIcon;
@property(nonatomic,strong)IBOutlet UILabel* nicknamelab;
@property(nonatomic,strong)IBOutlet UILabel* Emaillab;
@property(nonatomic,strong)ToMyViewController* ToMyview;
-(IBAction)login:(id)sender;

@end
