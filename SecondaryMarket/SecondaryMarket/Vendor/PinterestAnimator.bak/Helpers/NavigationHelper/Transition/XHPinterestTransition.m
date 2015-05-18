//
//  XHPinterestTransition.m
//  PinterestExample
//
//  Created by dw_iOS on 14-7-14.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "XHPinterestTransition.h"

@interface XHPinterestTransition ()


@end

@implementation XHPinterestTransition

- (id)init {
    self = [super init];
    if (self) {
        self.animationScale = ((CGRectGetWidth(kXHScreen) - kXHLargeGridItemPadding * 2) / KXHGridItemWidth);
        self.animationDuration = 0.25;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning Delegate

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuration;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // subClass
}

@end
