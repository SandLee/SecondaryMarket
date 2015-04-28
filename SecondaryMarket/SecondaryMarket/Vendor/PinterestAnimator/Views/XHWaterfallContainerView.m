//
//  XHWaterfallContainerView.m
//  PinterestExample
//
//  Created by dw_iOS on 14-7-24.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "XHWaterfallContainerView.h"
#import "XHUIKitMacro.h"

#import "XHPinterest.h"

#define kXHPhotoPadding 4

@interface XHWaterfallContainerView ()

@property (nonatomic, strong) UIImageView *imageView;



@end

@implementation XHWaterfallContainerView

#pragma mark - Propertys

- (void)setDisplayPinterest:(XHPinterest *)displayPinterest {
    _displayPinterest = displayPinterest;

    self.imageView.image = displayPinterest.image;
//    DLog(@"imageView.frame = %@",NSStringFromCGRect(self.imageView.frame));
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundImageView.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backgroundImageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.cornerRadii, self.cornerRadii)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _backgroundImageView.bounds;
        maskLayer.path = maskPath.CGPath;
        _backgroundImageView.layer.mask = maskLayer;
        
    }
    return _backgroundImageView;
}

- (UIImageView *)imageView {
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.backgroundImageView.bounds), CGRectGetHeight(self.backgroundImageView.bounds))];
//        _imageView.backgroundColor = [UIColor grayColor];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        

    }
    return _imageView;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
                  cornerRadii:(CGFloat)cornerRadii {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        DLog(@"XHWaterfal = %@",NSStringFromCGRect(frame));
        self.cornerRadii = cornerRadii;
        
        [self addSubview:self.backgroundImageView];
        
        [self.backgroundImageView addSubview:self.imageView];

    }
    return self;
}

@end
