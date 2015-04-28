//
//  XHPinterest.m
//  PinterestExample
//
//  Created by dw_iOS on 14-8-12.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "XHPinterest.h"

@implementation XHPinterest

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title {
    self = [super init];
    if (self) {
        if (imageName) {
            self.image = [UIImage imageNamed:imageName];
        }
        self.title = title;
    }
    return self;
}

@end
