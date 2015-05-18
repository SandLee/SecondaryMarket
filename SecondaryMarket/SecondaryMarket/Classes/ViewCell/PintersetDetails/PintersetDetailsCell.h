//
//  PintersetDetailsCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHTransitionProtocol.h"

@protocol HideNavAndTabbarDelegate <NSObject>

- (void) sethideNavAndTabbar:(BOOL)isHide;

@end


@class XHPinterest;
@class PinteretDetailsViewController;
// Block
typedef void(^XHPullDownAction)(CGPoint offset);
typedef void(^XHDidSelectedSubItemAction)(UICollectionView* collection,XHPinterest *currentPinterest,NSIndexPath* indexPath);

@interface PintersetDetailsCell : UICollectionViewCell<XHTansitionWaterfallGridViewProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  需要展示和绑定的数据Model
 */
@property (nonatomic, strong) XHPinterest *pinterest;

/**
 *  详情页面，下拉scrollView到一定程度的回调
 */
@property (nonatomic, copy) XHPullDownAction pullDownAction;

/**
 *  点击详情页面的其他item的回调
 */
@property (nonatomic, copy) XHDidSelectedSubItemAction didSelectedSubItemAction;

@property (nonatomic,assign)id<HideNavAndTabbarDelegate> delegate;

@property (nonatomic, strong)PinteretDetailsViewController* PinteretDetails;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic,strong)NSIndexPath* indexPath;
-(void)setDetailsCell;
@end
