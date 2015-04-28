//
//  PinteretDetailsViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "PinteretDetailsViewController.h"
#import "UICollectionView+XHIndexPath.h"
#import "MacroDefinition.h"
#import "YIFullScreenScroll.h"
#import "PintersetDetailsCell.h"

#import "XHPinterest.h"

#define kXHHorizontalPageViewCellIdentify @"XHHorizontalPageViewCellIdentify"
@interface PinteretDetailsViewController ()
{
    YIFullScreenScroll* _fullScreenDelegate;
}
@property (nonatomic, assign) CGPoint pullOffset;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@end

@implementation PinteretDetailsViewController
#pragma mark - Propertys

- (UICollectionView *)collectionView {
    if (!_collectionView){
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.frame = CGRectMake(0, -64, 320, 568+64);
        [_collectionView setScrollsToTop:NO];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[PintersetDetailsCell class] forCellWithReuseIdentifier:kXHHorizontalPageViewCellIdentify];
        [_collectionView setCurrentIndexPath:self.indexPath];
        
        [_collectionView performBatchUpdates:^{
            [_collectionView reloadData];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            }
        }];
    }
    
    return _collectionView;
}

#pragma mark - Life Cycle

- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)collectionViewFlowLayout currentIndexPath:(NSIndexPath *)indexPath {
    self = [super init];
    if (self) {
        self.pullOffset = CGPointZero;
        self.collectionViewFlowLayout = collectionViewFlowLayout;
        self.indexPath = indexPath;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor redColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(navPlusBtnPressed:) ];
//    
//    
    if (IOS_VERSION>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 7, 40, 30)];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回"  forState:UIControlStateNormal];
    [leftButton setTitle:@"返回"  forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(navPlusBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton] ;
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationController.navigationBar.ba ;
    self.title = @"商品详情";
    [self.view addSubview:self.collectionView];
    
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, 320, 24)];
    imageview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageview];
//    [(UIScrollView*)self.collectionView setContentInset:<#(UIEdgeInsets)#>]
}
/**
 * 将UIColor变换为UIImage
 *
 **/
- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _collectionView.frame = CGRectMake(0, -64, 320, 568+64);
    
    self.navigationController.navigationBarHidden = NO;
//    _collectionView.frame = CGRectMake(0, -78, 320, 568+64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)navPlusBtnPressed
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - XHTransitionProtocol

- (CGPoint)pageViewCellScrollViewContentOffset {
    return self.pullOffset;
}

- (UICollectionView *)transitionCollectionView {
    return self.collectionView;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"frame = %@",NSStringFromCGRect(scrollView.frame));
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (index == 0) {
        self.indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView setCurrentIndexPath:self.indexPath];
        
    }
}
//-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    DLog(@"scrollViewDidEndDragging");
//    if (!decelerate){
//        
//        DLog(@"scrollViewDidEndDragging");
//        //这里写上停止时要执行的代码
//        
//    }
//    
//}
#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"count = %d",self.items.count);
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PintersetDetailsCell *collectionCell = (PintersetDetailsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kXHHorizontalPageViewCellIdentify forIndexPath:indexPath];
    [collectionCell setDetailsCell];
    /**
     隐藏tabbar 和navbar
     
     :returns: <#return value description#>
     */
    
    DLog(@"row = %d",indexPath.row);
    
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self scrollView:collectionCell.collectionView style:YIFullScreenScrollStyleFacebook];
    self.fullScreenScroll.shouldShowUIBarsOnScrollUp = YES;
    self.fullScreenScroll.DonotshowtopNavNavigationBar = YES;
    [self.fullScreenScroll viewWillAppear:YES];
//    DLog(@"top = %f",self.navigationController.navigationBar.top);
    
//    collectionCell.delegate = self;
    
    collectionCell.pinterest = self.items[indexPath.row];
    collectionCell.didSelectedSubItemAction = ^(UICollectionView *collectionView,XHPinterest *currentPinterest,NSIndexPath* indexPath) {
        
        /**
         *  用于切换视图
         */
        self.navigationController.navigationBarHidden = NO;
        PinteretDetailsViewController *PinteretDetailsView = [[PinteretDetailsViewController alloc] initWithCollectionViewFlowLayout:[self pageViewControllerLayout] currentIndexPath:indexPath];
        
        PinteretDetailsView.items = self.items;
        
        [collectionView setCurrentIndexPath:indexPath];
        
        [self.navigationController pushViewController:PinteretDetailsView animated:YES];
        
        
    };
//    self.fullScreenScroll = nil;
    __weak typeof(self) weakSelf = self;
    collectionCell.pullDownAction = ^(CGPoint offset) {
        weakSelf.pullOffset = offset;
        weakSelf.navigationController.navigationBarHidden = YES;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [collectionCell setNeedsDisplay];
    
    
    return collectionCell;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        DLog(@"self.tabBar.frame =%@  self.navigationBar.frame = %@",NSStringFromCGRect(self.tabBarController.tabBar.frame),NSStringFromCGRect(self.navigationController.navigationBar.frame));
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) sethideNavAndTabbar:(BOOL)isHide
{
    
    if (self.navigationController.navigationBar.frame.origin.y < 0) {
        [self.fullScreenScroll hideUIBarsAnimated:YES];
    }
    else
    {
        [self.fullScreenScroll showUIBarsAnimated:YES];
    }
}



/**
 *  add by wxy 用于切换视图
 */
- (UICollectionViewFlowLayout *)pageViewControllerLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGSize itemSize = self.navigationController.navigationBarHidden ? (CGSizeMake(kXHScreenWidth, CGRectGetHeight(kXHScreen) + 20)) : (CGSizeMake(kXHScreenWidth, CGRectGetHeight(kXHScreen) - 64));
    DLog(@"itemsize = %@",NSStringFromCGSize(itemSize));
    flowLayout.itemSize = itemSize;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    DLog(@"flowLayout.itemSize = %@",NSStringFromCGSize(flowLayout.itemSize));
    return flowLayout;
}
#pragma mark - XHTransitionProtocol

- (void)viewWillAppearWithPageIndex:(NSInteger)pageIndex {
    UICollectionViewScrollPosition position = UICollectionViewScrollPositionCenteredVertically & UICollectionViewScrollPositionCenteredHorizontally;
    XHPinterest *pinterest = self.items[pageIndex];
    
    CGFloat imageHeight = pinterest.image.size.height * KXHGridItemWidth / pinterest.image.size.width;
    if (imageHeight > 400) {
        position = UICollectionViewScrollPositionTop;
    }
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
    [self.collectionView setCurrentIndexPath:currentIndexPath];
    if (pageIndex < 2) {
        [self.collectionView setContentOffset:CGPointZero animated:NO];
    } else {
        [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:position animated:NO];
    }
}
@end
