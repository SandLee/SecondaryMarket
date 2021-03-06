//
//  XHWaterfallContainerView.h
//  PinterestExample
//
//  Created by dw_iOS on 14-7-24.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@class XHPinterest;

@interface XHWaterfallContainerView : UIView

/**
 *  圆角半径
 */
@property (nonatomic, assign) CGFloat cornerRadii;

/**
 *  需要展示和绑定的数据Model
 */
@property (nonatomic, strong) XHPinterest *displayPinterest;


@property (nonatomic, strong) UIImageView *backgroundImageView;
- (instancetype)initWithFrame:(CGRect)frame
                  cornerRadii:(CGFloat)cornerRadii;


@end
