//
//  PinteretDetailsViewController.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHTransitionProtocol.h"
#import "PintersetDetailsCell.h"
@interface PinteretDetailsViewController : UIViewController<XHTransitionProtocol, XHHorizontalPageViewControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource,HideNavAndTabbarDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *items;

- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)collectionViewFlowLayout currentIndexPath:(NSIndexPath *)indexPath;

@end
