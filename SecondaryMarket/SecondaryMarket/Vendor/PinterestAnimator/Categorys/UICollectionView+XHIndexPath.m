//
//  UICollectionView+XHIndexPath.m
//  PinterestExample
//
//  Created by dw_iOS on 14-7-21.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UICollectionView+XHIndexPath.h"
#import <objc/runtime.h>
//static NSString * k=nil;
static NSString * kXHIndexPathKey = nil;

@implementation UICollectionView (XHIndexPath)


- (void)setCurrentIndexPath:(UICollectionView*)collection indexPath: (NSIndexPath *)indexPath {
    kXHIndexPathKey = [NSString stringWithFormat:@"%p",collection];
    objc_setAssociatedObject(self, &kXHIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)currentIndexPath:(UICollectionView*)collection {
    kXHIndexPathKey = [NSString stringWithFormat:@"%p",collection];
    NSInteger index = self.contentOffset.x / self.frame.size.width;
    
    NSIndexPath *indexPath = objc_getAssociatedObject(self, &kXHIndexPathKey);
    if (index > 0) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    } else if (indexPath) {
        return indexPath;
    } else {
        return [NSIndexPath indexPathForRow:0 inSection:0];
    }
}

@end
