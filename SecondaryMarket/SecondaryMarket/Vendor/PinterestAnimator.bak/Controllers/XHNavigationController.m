//
//  XHNavigationController.m
//  PinterestExample
//
//  Created by dw_iOS on 14-7-21.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "XHNavigationController.h"
#import "XHTransitionProtocol.h"
#import "UICollectionView+XHIndexPath.h"

@interface XHNavigationController ()

@end

@implementation XHNavigationController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pop Helper Method

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    NSInteger childrenCount = self.viewControllers.count;
    
    UIViewController <XHTransitionProtocol, XHWaterFallViewControllerProtocol> *toViewController = (UIViewController <XHTransitionProtocol, XHWaterFallViewControllerProtocol> *)self.viewControllers[childrenCount - 2];
    UICollectionView *toView = [toViewController transitionCollectionView];
    
    UIViewController <XHTransitionProtocol, XHWaterFallViewControllerProtocol> *popedViewController = (UIViewController <XHTransitionProtocol, XHWaterFallViewControllerProtocol> *)self.viewControllers[childrenCount - 1];
    
    UICollectionView *popView  = [popedViewController valueForKey:@"collectionView"];
    NSString* popViewkey = [popedViewController GetCollectionKey];
    NSIndexPath *indexPath = [popView currentIndexPath:popViewkey];
    
    DLog(@"row = %ld",(long)indexPath.row);
    [toViewController viewWillAppearWithPageIndex:indexPath.row];
    NSString* toViewKey = [toViewController GetCollectionKey];
    [toView setCurrentIndexPath:toViewKey indexPath:indexPath];
    
//    NSIndexPath *indexPath1 = [toView currentIndexPath:toViewKey];
//    DLog(@"row = %ld",(long)indexPath1.row);
    return [super popViewControllerAnimated:animated];
}

@end
