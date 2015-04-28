//
//  imagetextView.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHPinterest;

@interface imagetextView : UIView
@property (nonatomic, strong) UILabel* titlelabel;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) XHPinterest *displayPinterest;

@end
