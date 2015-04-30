//
//  PintersetHomeViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "PintersetHomeViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "XHPinterest.h"
#import "XHNavigationControllerDelegate.h"
#import "PintersetHomeCell.h"
#import "UICollectionView+XHIndexPath.h"
#import "PinteretDetailsViewController.h"
#import "AAPullToRefresh.h"
#import "YIFullScreenScroll.h"
#import "GHContextMenuView.h"
@interface PintersetHomeViewController () <CHTCollectionViewDelegateWaterfallLayout, GHContextOverlayViewDataSource, GHContextOverlayViewDelegate>
{
    YIFullScreenScroll* _fullScreenDelegate;
}
@property (nonatomic, strong) XHNavigationControllerDelegate *navigationControllerDelegate;
@property (nonatomic,assign)int lastPosition;
@end

@implementation PintersetHomeViewController

#pragma mark - Propertys

- (XHNavigationControllerDelegate *)navigationControllerDelegate {
    return _navigationControllerDelegate;
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
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, 320, 568);
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        [_collectionView registerClass:[PintersetHomeCell class]
            forCellWithReuseIdentifier:@"CELL"];
        
        GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
        overlay.dataSource = self;
        overlay.delegate = self;
        
        // Do any additional setup after loading the view.
        //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
        [self.collectionView addGestureRecognizer:_longPressRecognizer];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
 
//    if (IOS_VERSION>=7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    if (!_navigationControllerDelegate) {
        _navigationControllerDelegate = [[XHNavigationControllerDelegate alloc] initWithNavigationController:self.navigationController panGestureRecognizerEnable:NO];
    }
    
    self.navigationController.navigationBarHidden = YES;
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self scrollView:self.collectionView style:YIFullScreenScrollStyleFacebook];
    self.fullScreenScroll.shouldShowUIBarsOnScrollUp = YES;
    self.fullScreenScroll.DonotshowtopNavNavigationBar = YES;
//    [self.fullScreenScroll viewWillAppear:YES];
    [self.view addSubview:self.collectionView];
    
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
    imageview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageview];
    // top
    AAPullToRefresh *tv = [self.collectionView addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh *v){
        NSLog(@"fire from top");
        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1.0f];
    }];
    //    tv.imageIcon = [UIImage imageNamed:@"launchpad"];
    //    tv.borderColor = [UIColor whiteColor];
    
//    // bottom
//    AAPullToRefresh *bv = [self.collectionView addPullToRefreshPosition:AAPullToRefreshPositionBottom actionHandler:^(AAPullToRefresh *v){
//        NSLog(@"fire from bottom");
//        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1.0f];
//    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    _collectionView.frame = CGRectMake(0, 0, 320, 568);
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    _collectionView.frame = CGRectMake(0, 0, 320, 568);
//    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _collectionView = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@" scrollViewDidScroll y = %f",scrollView.contentOffset.y);
//    int currentPostion = scrollView.contentOffset.y;
//    
//    if (currentPostion - _lastPosition > 20  && currentPostion > 0) {        //这个地方加上 currentPostion > 0 即可）
//        
//        _lastPosition = currentPostion;
////        [self.leveyTabBarController setTransitionViewHeight:24];
//        [self.leveyTabBarController hidesTabBar:YES animated:YES];
//    }
//    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) )
//    {
//         _lastPosition = currentPostion;
//        [self.leveyTabBarController hidesTabBar:NO animated:YES];
//    }
//    
//}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    PintersetHomeCell *cell = (PintersetHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL"  forIndexPath:indexPath];
    
    [cell setupPintersetHomeCell];
    cell.indexPath = indexPath;
    cell.pinterest = self.items[indexPath.row];
    cell.descriptionLab.text = @"function:-[PintersetHomeViewController collectionView:layout:sizeForItemAtIndexPath:] line:137 content:-[PintersetHomeViewController ";
    cell.icon1Num.text = @"1";
    cell.icon2Num.text = @"2";
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XHPinterest *currentPinterest = self.items[indexPath.row];
    CGFloat imageHeight = currentPinterest.image.size.height * KXHGridItemWidth / currentPinterest.image.size.width;
    
    DLog(@"currentPinterest.image.size = %@ imageHeight = %f",NSStringFromCGSize(currentPinterest.image.size),imageHeight);
    CGSize size = CGSizeMake(KXHGridItemWidth,2000);
    
    UIFont *font = [UIFont boldSystemFontOfSize:14];
//    CGSize labelsize = [currentPinterest.title sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    imageHeight += 115 ;
 
    DLog(@"imageHeight = %f",imageHeight);
    return CGSizeMake(KXHGridItemWidth, imageHeight);
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
//    [self.collectionView setCurrentIndexPath:currentIndexPath];
    [self.collectionView setCurrentIndexPath:self.collectionView indexPath:currentIndexPath];
    if (pageIndex < 2) {
        [self.collectionView setContentOffset:CGPointZero animated:NO];
    } else {
        [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:position animated:NO];
    }
}

- (UICollectionView *)transitionCollectionView {
    return self.collectionView;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.navigationController.navigationBarHidden = NO;
    
    PinteretDetailsViewController *PinteretDetailsView = [[PinteretDetailsViewController alloc] initWithCollectionViewFlowLayout:[self pageViewControllerLayout] currentIndexPath:indexPath];
    
    PinteretDetailsView.items = self.items;
    
//    [collectionView setCurrentIndexPath:indexPath];
    [collectionView setCurrentIndexPath:collectionView indexPath:indexPath];
    
    [self.navigationController pushViewController:PinteretDetailsView animated:YES];
}

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



#pragma mark - GHMenu methods

-(BOOL) shouldShowMenuAtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    return cell != nil;
}

- (NSInteger) numberOfMenuItems
{
    return 3;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"facebook-white";
            break;
        case 1:
            imageName = @"twitter-white";
            break;
        case 2:
            imageName = @"google-plus-white";
            break;
        case 3:
            imageName = @"linkedin-white";
            break;
        case 4:
            imageName = @"pinterest-white";
            break;
            
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    NSString* msg = nil;
    switch (selectedIndex) {
        case 0:
            msg = @"Facebook Selected";
            break;
        case 1:
            msg = @"Twitter Selected";
            break;
        case 2:
            msg = @"Google Plus Selected";
            break;
        case 3:
            msg = @"Linkedin Selected";
            break;
        case 4:
            msg = @"Pinterest Selected";
            break;
            
        default:
            break;
    }
    
    msg = [msg stringByAppendingFormat:@" for cell %ld", (long)indexPath.row +1];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(!decelerate){
        if (self.navigationController.navigationBar.frame.origin.y < 0) {
            [self.fullScreenScroll hideUIBarsAnimated:YES];
        }
        else
        {
            [self.fullScreenScroll showUIBarsAnimated:YES];
        }
    }
    
}
@end
