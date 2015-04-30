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
    
    UICollectionView *waterFallView = [toViewController transitionCollectionView];
    
    UICollectionView *pageView = [fromViewController transitionCollectionView];
    
    
    [waterFallView layoutIfNeeded];
    
    NSIndexPath *indexPath = [pageView currentIndexPath:pageView];
    
    UIView <XHTansitionWaterfallGridViewProtocol> *gridView = (UIView <XHTansitionWaterfallGridViewProtocol> *)([waterFallView cellForItemAtIndexPath:indexPath]);
    
    [waterFallView performBatchUpdates:^{
        
    } completion:NULL];
    
    
    CGPoint leftUpperPoint = [gridView convertPoint:CGPointZero toView:nil];
    
    UIView *snapShot = [gridView snapShotForTransition];
    
    CGFloat animationScale = [self animationScale];
    
    DLog(@"animationScale = %f",animationScale);
    snapShot.transform = CGAffineTransformMakeScale(animationScale, animationScale);
    
    CGFloat pullOffsetY = [(UIViewController <XHHorizontalPageViewControllerProtocol> *)fromViewController pageViewCellScrollViewContentOffset].y;
    
    CGFloat offsetY = fromViewController.navigationController.navigationBarHidden ? 0.0 : 64;
    [snapShot setOrigin:CGPointMake(kXHLargeGridItemPadding, -pullOffsetY+offsetY + kXHLargeGridItemPadding)];
    
    [containerView addSubview:snapShot];
    
    CGFloat width = toView.frame.size.width;
    CGFloat height = toView.frame.size.height;
    toView.hidden = NO;
    
    toView.alpha = 0.0;
    toView.transform = snapShot.transform;
    toView.frame = CGRectMake(-(leftUpperPoint.x * animationScale), -((leftUpperPoint.y-offsetY) * animationScale + pullOffsetY+offsetY),
                              width, height);
    
    DLog(@"toView.frame = %@",NSStringFromCGRect(toView.frame));
    
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
