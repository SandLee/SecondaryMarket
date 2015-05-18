//
//  XHPinterestPopTransition.m
//  PinterestExample
//
//  Created by dw_iOS on 14-8-14.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "XHPinterestPopTransition.h"

@implementation XHPinterestPopTransition

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController <XHTransitionProtocol> *fromViewController = (UIViewController <XHTransitionProtocol> * )([transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]);
    
    UIViewController <XHTransitionProtocol> *toViewController = (UIViewController <XHTransitionProtocol> * )([transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]);
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = toViewController.view;
    DLog(@"toView.frame = %@",NSStringFromCGRect(toView.frame));
    [containerView addSubview:toView];
    toView.hidden = YES;
    
    DLog(@"UICollectionView *waterFallView");
    UICollectionView *waterFallView = [toViewController transitionCollectionView];
    DLog(@"UICollectionView *pageView");
    UICollectionView *pageView = [fromViewController transitionCollectionView];
    
    
    DLog(@"number = %d",[waterFallView numberOfItemsInSection:0]);
//    for (int i = 0 ; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
    
    [waterFallView layoutIfNeeded];
//    DLog(@"key = %@ self.contentOffset.x = %f self.frame.size.width = %f",[fromViewController GetCollectionKey],pageView.contentOffset.x,pageView.frame.size.width);
    NSString* pageViewkey = [fromViewController GetCollectionKey];
    NSIndexPath *indexPath = [waterFallView currentIndexPath:pageViewkey];
    
    for (int i = 0 ; i < [waterFallView numberOfItemsInSection:0]; i ++) {
        UICollectionViewCell *cell =[waterFallView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        DLog(@"cell_%d = %@",i,cell);
    }
    DLog(@"animateTransition indexPath row= %ld",(long)indexPath.row);
//    DLog(@"cell = %@",[waterFallView cellForItemAtIndexPath:indexPath]);
//    indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    UIView <XHTansitionWaterfallGridViewProtocol> *gridView = (UIView <XHTansitionWaterfallGridViewProtocol> *)([waterFallView cellForItemAtIndexPath:indexPath]);
    
    
    [waterFallView performBatchUpdates:^{
        
    } completion:NULL];
    
    
    CGPoint leftUpperPoint = [gridView convertPoint:CGPointZero toView:nil];
    
    UIView *snapShot = [gridView snapShotForTransition];
//    DLog(@"snapShop frame = %@",NSStringFromCGRect(snapShot.frame));
    CGFloat animationScale = [self animationScale];
    
//    DLog(@"animationScale = %f",animationScale);
    snapShot.transform = CGAffineTransformMakeScale(animationScale, animationScale);
    
    CGFloat pullOffsetY = [(UIViewController <XHHorizontalPageViewControllerProtocol> *)fromViewController pageViewCellScrollViewContentOffset].y;
    
    CGFloat offsetY = fromViewController.navigationController.navigationBarHidden ? 0.0 : 64;
    
    [snapShot setOrigin:CGPointMake(kXHLargeGridItemPadding, -pullOffsetY+offsetY + kXHLargeGridItemPadding)];
    
    [containerView addSubview:snapShot];
    
//    CGFloat width = toView.frame.size.width;
//    CGFloat height = toView.frame.size.height;
    
//    DLog(@"width = %f height = %f",width,height);
    toView.hidden = NO;
    
    toView.alpha = 0.0;
    toView.transform = snapShot.transform;
//    DLog(@"transform a = %f b = %f c = %f d = %f tx = %f ty = %f",snapShot.transform.a,snapShot.transform.b,snapShot.transform.c,snapShot.transform.d,snapShot.transform.tx,snapShot.transform.ty);
    toView.frame = CGRectMake(-(leftUpperPoint.x * animationScale), -((leftUpperPoint.y-offsetY) * animationScale + pullOffsetY+offsetY),
                              toView.frame.size.width, toView.frame.size.height);
    
    DLog(@"toView.frame = %@",NSStringFromCGRect(waterFallView.frame));
    
    UIView *whiteViewContainer = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    whiteViewContainer.backgroundColor = [UIColor whiteColor];
    
    [containerView addSubview:whiteViewContainer];
    [containerView insertSubview:whiteViewContainer belowSubview:toView];
    
    [UIView animateWithDuration:[self animationDuration] animations:^{
        snapShot.transform = CGAffineTransformIdentity;
        [snapShot setOrigin:leftUpperPoint];
        
        toView.transform = CGAffineTransformIdentity;
        [toView setOrigin:CGPointZero];
        toView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [snapShot removeFromSuperview];
            [whiteViewContainer removeFromSuperview];
            [transitionContext completeTransition:!self.canceled];
        }
        
    }];
}

@end
