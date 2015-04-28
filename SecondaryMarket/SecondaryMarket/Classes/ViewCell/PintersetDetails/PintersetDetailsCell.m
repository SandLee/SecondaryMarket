//
//  PintersetDetailsCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "PintersetDetailsCell.h"
#import "PintersetHomeCell.h"
#import "CHTCollectionViewWaterfallLayout.h"

#import "XHUIKitMacro.h"
#import "XHWaterfallContainerView.h"

#import "XHPinterest.h"
#import "HeaderView.h"
#import "YIFullScreenScroll.h"
#define kXHContainerViewIdentifier @"XHContainerViewIdentifier"


@interface PintersetDetailsCell () <CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) CHTCollectionViewWaterfallLayout *layout;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) HeaderView *reusableView;

@end
@implementation PintersetDetailsCell
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
}
#pragma mark - Propertys

- (void)setPinterest:(XHPinterest *)pinterest {
    _pinterest = pinterest;
    self.layout.headerHeight = 0;
    CGFloat imageHeight = pinterest.image.size.height * kXHScreenWidth / pinterest.image.size.width;
    self.layout.headerHeight = imageHeight + 233;
    DLog(@"self.layout.headerHeight = %f",self.layout.headerHeight);
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
        for (NSInteger i = 1; i <= XH_CELL_COUNT; i++) {
            XHPinterest *pinterest = [[XHPinterest alloc] initWithImageName:[NSString stringWithFormat:@"%ld.jpeg", (long)i]
                                                                      title:[NSString stringWithFormat:@"Jack is cool man Jack is cJack is cool man Jack is cJack is cool man Jack is cJack is cool man Jack is cJack is cool man Jack is cJack is cool man Jack is c: %ld", (long)i]];
            [_items addObject:pinterest];
        }
    }
    return _items;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        _layout.minimumColumnSpacing = 10;
        _layout.minimumInteritemSpacing = 10;
        _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
//        _collectionView.frame = CGRectMake(0, 0, 320, 548);
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        [_collectionView registerClass:[PintersetHomeCell class]
            forCellWithReuseIdentifier:XH_CELL_IDENTIFIER];
        
        [_collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:kXHContainerViewIdentifier];
        
        
        
    }
    return _collectionView;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
    
        
    }
    return self;
}
-(void)setDetailsCell
{
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    [self addSubview:self.collectionView];
    
    
}
#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (-scrollView.contentOffset.y > 64) {
        if (self.pullDownAction) {
            self.pullDownAction(scrollView.contentOffset);
        }
    }
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PintersetHomeCell *cell =
    (PintersetHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:XH_CELL_IDENTIFIER forIndexPath:indexPath];
    [cell setupPintersetHomeCell];
    cell.indexPath = indexPath;
    cell.pinterest = self.items[indexPath.row];
    cell.descriptionLab.text = @"function:-[PintersetHomeViewController collectionView:layout:sizeForItemAtIndexPath:] line:137 content:-[PintersetHomeViewController ";
    cell.icon1Num.text = @"1";
    cell.icon2Num.text = @"2";
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    HeaderView *reusableView ;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        
        self.reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:kXHContainerViewIdentifier
                                                                 forIndexPath:indexPath];
            [self.reusableView setHeaderViewTable];
        
            self.reusableView.pinterest = _pinterest;
            return self.reusableView;
        }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    if (self.didSelectedSubItemAction) {
        self.didSelectedSubItemAction(collectionView,self.items[indexPath.row],indexPath);
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XHPinterest *currentPinterest = self.items[indexPath.row];
    CGFloat imageHeight = currentPinterest.image.size.height * KXHGridItemWidth / currentPinterest.image.size.width;
    imageHeight += 115 ;
    return CGSizeMake(KXHGridItemWidth, imageHeight);
}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    if(!decelerate){
//        
//        //这里写上停止时要执行的代码
//        DLog(@"scrollViewDidEndDragging");
//       
//        if(delegate &&
//           [delegate respondsToSelector:@selector(sethideNavAndTabbar:)]){
//            [delegate performSelector:@selector(sethideNavAndTabbar:) withObject:nil];
//        }
//    }
//    
//}


- (UIView *)snapShotForTransition {
    
    PintersetHomeCell *cell = (PintersetHomeCell*)[self.collectionView cellForItemAtIndexPath:self.indexPath];
    XHWaterfallContainerView *snapShotView = [[XHWaterfallContainerView alloc] initWithFrame:cell.waterfallContainerView.frame
                                                                                 cornerRadii:cell.waterfallContainerView.cornerRadii];
    snapShotView.displayPinterest = cell.waterfallContainerView.displayPinterest;
    return snapShotView;
}
@end
