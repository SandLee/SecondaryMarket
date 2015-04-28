//
//  HeaderView.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPinterest.h"
@interface HeaderView : UICollectionReusableView
/**
 *  需要展示和绑定的数据Model
 */
@property (nonatomic, strong) XHPinterest *pinterest;

-(void)setHeaderViewTable;
@end
