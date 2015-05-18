//
//  ToMyHeaderView.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ToMyHeaderView.h"

@implementation ToMyHeaderView

- (void)awakeFromNib {
    // Initialization code
}
-(IBAction)login:(id)sender
{
    DLog(@"登陆");
}

-(IBAction)skipToBuy:(id)sender
{
    DLog(@"我买的");
}

-(IBAction)skipToSale:(id)sender
{
    DLog(@"我卖的");
}

-(IBAction)skipToFav:(id)sender
{
    DLog(@"收藏");
}
@end
