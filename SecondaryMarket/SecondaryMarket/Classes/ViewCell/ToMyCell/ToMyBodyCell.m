//
//  ToMyBodyCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ToMyBodyCell.h"

@implementation ToMyBodyCell

- (void)awakeFromNib {
    // Initialization code
    ToBuyView* tobuy = [[ToBuyView alloc] initWithFrame:CGRectMake(0, 0, 320, 30/2*145)];
    ToSaleView* toSale = [[ToSaleView alloc] initWithFrame:CGRectMake(0, 0, 320, 30/2*145)];
    ToFavView* tofav = [[ToFavView alloc] initWithFrame:CGRectMake(0, 0, 320, 30/2*145)];
    NSArray *views =@[tobuy,toSale,tofav];
    NSArray *names =@[@"我要买",@"我要卖",@"收藏"];
    //创建使用
    DLog(@"frame = %@",NSStringFromCGRect(self.bounds));
    self.scroll =[XLScrollViewer scrollWithFrame:CGRectMake(0, 0, 320, 30/2*145) withViews:views withButtonNames:names withThreeAnimation:111];//三中动画都选择
    
    //自定义各种属性。。打开查看
    self.scroll.xl_topBackImage =[UIImage imageNamed:@"1.jpeg"];
    self.scroll.xl_topBackColor =[UIColor yellowColor];
    self.scroll.xl_sliderColor =[UIColor clearColor];
    self.scroll.xl_buttonColorNormal =[UIColor redColor];
    self.scroll.xl_buttonColorSelected =[UIColor yellowColor];
    self.scroll.xl_buttonFont =18;
    self.scroll.xl_buttonToSlider =50;
    self.scroll.xl_sliderHeight =50;
    self.scroll.xl_topHeight =50;
    self.scroll.xl_isSliderCorner =NO;
    self.scroll.xl_isScaleButton = YES;
    //加入控制器视图
    [self addSubview:self.scroll];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
