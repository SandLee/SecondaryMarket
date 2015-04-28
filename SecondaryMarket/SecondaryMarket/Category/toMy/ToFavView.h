//
//  ToFavView.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToFavView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView* collectionView;

@end
