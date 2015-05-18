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
#import "AppDelegate.h"
#import "XHPinterest.h"



//测试
#import "PintersetHomeCell.h"

#define kXHHorizontalPageViewCellIdentify @"XHHorizontalPageViewCellIdentify"
@interface PinteretDetailsViewController ()
{
    YIFullScreenScroll* _fullScreenDelegate;
}
@property (nonatomic, assign) CGPoint pullOffset;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSIndexPath *skipIndexPath;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;


@end

@implementation PinteretDetailsViewController
#pragma mark - Propertys

- (UICollectionView *)collectionView {
    if (!_collectionView){
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewFlowLayout];
//        _collectionView.frame = CGRectMake(0, -64, 320, 568+64);
        DLog(@"self.bound = %@",NSStringFromCGRect(self.view.bounds));
        [_collectionView setScrollsToTop:NO];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[PintersetDetailsCell class] forCellWithReuseIdentifier:kXHHorizontalPageViewCellIdentify];
//        [_collectionView setCurrentIndexPath:self.indexPath];
//        self.DetailsKey = [NSString stringWithFormat:@"%@%ld",@"PinteretDetails",(long)self.indexPath.row];
        [_collectionView setCurrentIndexPath:self.DetailsKey indexPath:self.indexPath];
        DLog(@"row = %ld",(long)self.indexPath.row);
        [_collectionView performBatchUpdates:^{
//            [self loadData];
            [_collectionView reloadData];
//            [_collectionView reloadSections:[NSIndexSetindexSetWithIndex:0]];
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
        DLog(@"row = %ld",(long)self.indexPath.row);
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
    self.navigationController.navigationBarHidden = NO;
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
    
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, CGRectGetWidth(self.view.bounds), 24)];
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
    
//    self.navigationController.navigationBarHidden = NO;
//    _collectionView.frame = CGRectMake(0, -78, 320, 568+64);
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    _collectionView.frame = CGRectMake(0, 20, 320, 588);
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
    
//    return self.collectionView;
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (delegate.bHomePageSkipDetails) {
        return self.collectionView;
    }
    else
    {
        PintersetDetailsCell *collectionCell = (PintersetDetailsCell *)[self.collectionView cellForItemAtIndexPath:self.skipIndexPath];
        
//        PintersetHomeCell *cell = (PintersetHomeCell*)[self.collectionCell.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        DLog(@"cell = %@ row = %ld",[collectionCell.collectionView cellForItemAtIndexPath:self.indexPath],(long)self.indexPath.row);
        for (int i = 0 ; i < [self.collectionView numberOfItemsInSection:0]; i ++) {
            PintersetHomeCell *cell =
            (PintersetHomeCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            DLog(@"row = %ld cell_%d = %@",(long)self.skipIndexPath.row,i,cell);
        }
//        return self.collectionCell.collectionView;
        return collectionCell.collectionView;
    }
}
-(NSString*) GetCollectionKey
{
    return self.DetailsKey;
}
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"frame = %@",NSStringFromCGRect(scrollView.frame));
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (index == 0) {
        self.indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView setCurrentIndexPath:self.DetailsKey indexPath:self.indexPath];
        
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
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.collectionCell = (PintersetDetailsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kXHHorizontalPageViewCellIdentify forIndexPath:indexPath];
    
//    _collectionView.frame = CGRectMake(0, -44, 320, 588);
    
    [self.collectionCell setDetailsCell];
//    self.collectionCell.collectionView.frame = self.view.bounds;
    self.DetailsKey = [NSString stringWithFormat:@"%@+%ld",@"PinteretDetails",(long)indexPath.row];
//    self.indexPath = indexPath;
    self.skipIndexPath = indexPath;
    /**
     隐藏tabbar 和navbar
     
     :returns: <#return value description#>
     */
    
    DLog(@"row = %ld",(long)indexPath.row);
    
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self scrollView:self.collectionCell.collectionView style:YIFullScreenScrollStyleFacebook];
    self.fullScreenScroll.shouldShowUIBarsOnScrollUp = YES;
    self.fullScreenScroll.DonotshowtopNavNavigationBar = YES;
    [self.fullScreenScroll viewWillAppear:YES];
//    DLog(@"top = %f",self.navigationController.navigationBar.top);
    
//    collectionCell.delegate = self;
    
    self.collectionCell.pinterest = self.items[indexPath.row];
    __weak typeof(self) weakSelf = self;
    self.collectionCell.didSelectedSubItemAction = ^(UICollectionView* collection,XHPinterest *currentPinterest,NSIndexPath* indexPath) {
        
//        //new
//        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//        delegate.bHomePageSkipDetails = NO;
//        PinteretDetailsViewController *PinteretDetails = [[PinteretDetailsViewController alloc] initWithCollectionViewFlowLayout:[weakSelf pageViewControllerLayout] currentIndexPath:indexPath];
//        PinteretDetails.DetailsKey = [NSString stringWithFormat:@"%@+%ld",@"PinteretDetails",(long)indexPath.row];
//        PinteretDetails.items = weakSelf.items;
//        
//        //    [collectionView setCurrentIndexPath:indexPath];
//        [collection setCurrentIndexPath:PinteretDetails.DetailsKey indexPath:indexPath];
//        [weakSelf.navigationController pushViewController:PinteretDetails animated:YES];
        
    };
//    self.fullScreenScroll = nil;
    
    self.collectionCell.pullDownAction = ^(CGPoint offset) {
        weakSelf.pullOffset = offset;
        weakSelf.navigationController.navigationBarHidden = YES;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.collectionCell setNeedsDisplay];
    
    
    return self.collectionCell;
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
    CGSize itemSize = CGSizeMake(kXHScreenWidth, CGRectGetHeight(kXHScreen) + 20);//self.navigationController.navigationBarHidden ? (CGSizeMake(kXHScreenWidth, CGRectGetHeight(kXHScreen) + 20)) : (CGSizeMake(kXHScreenWidth, CGRectGetHeight(kXHScreen) - 64));
    DLog(@"wxyitemsize = %@",NSStringFromCGSize(itemSize));
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
    
    CGFloat imageHeight = [[pinterest.imageSize  objectForKey:@"height"] floatValue] * KXHGridItemWidth/[[pinterest.imageSize  objectForKey:@"width"] floatValue];//pinterest.image.size.height * KXHGridItemWidth / pinterest.image.size.width;
    if (imageHeight > 400) {
        position = UICollectionViewScrollPositionTop;
    }
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
    DLog(@"row = %ld",(long)currentIndexPath.row);
//    PintersetDetailsCell *collectionCell = (PintersetDetailsCell *)[self.collectionView cellForItemAtIndexPath:currentIndexPath];
    self.DetailsKey = [NSString stringWithFormat:@"%@+%ld",@"PinteretDetails",(long)currentIndexPath.row];
    [self.collectionCell.collectionView setCurrentIndexPath:self.DetailsKey indexPath:currentIndexPath];
    if (pageIndex < 2) {
        [self.collectionCell.collectionView setContentOffset:CGPointZero animated:NO];
    } else {
        
        
        [self.collectionCell.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:position animated:NO];
    }
}

-(void)loadData
{
    NSString* url = [NSString stringWithFormat:@"%@?productId=%@",[APIAddress ApiSearchProductInfoById],/*self.productId*/@"05a89cb4678e40958e2a"];
    DLog(@"url = %@",url);
    [HttpClient asynchronousRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        DLog(@"data = %@",data);
    } failureBlock:^(NSString *description) {
        DLog(@"失败");
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
    }];
}




@end
