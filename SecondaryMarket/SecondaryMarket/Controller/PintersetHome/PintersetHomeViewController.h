//
//  PintersetHomeViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHTransitionProtocol.h"

@interface PintersetHomeViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableArray *data;

@end
