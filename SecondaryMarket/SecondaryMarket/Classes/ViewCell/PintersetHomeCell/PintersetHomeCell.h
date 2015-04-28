//
//  PintersetHomeCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHTransitionProtocol.h"
#import "XHWaterfallContainerView.h"
@class XHPinterest;
@interface PintersetHomeCell : UICollectionViewCell<XHTansitionWaterfallGridViewProtocol>
/**
 *  需要展示和绑定的数据Model
 */
@property (nonatomic, strong) XHPinterest *pinterest;

@property (nonatomic,strong)NSIndexPath* indexPath;

//文字描述
@property (nonatomic, strong)UILabel* descriptionLab;

@property (nonatomic, strong)UILabel *icon1Num;

@property (nonatomic, strong)UILabel *icon2Num;


@property (nonatomic, strong) XHWaterfallContainerView *waterfallContainerView;

-(void)setupPintersetHomeCell;
-(void)removePinterestCell;
@end
