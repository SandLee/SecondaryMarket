//
//  XHPinterest.h
//  PinterestExample
//
//  Created by dw_iOS on 14-8-12.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XHPinterest : NSObject

@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSDictionary* imageSize;



- (instancetype)initWithImageName:(NSString *)imageURL
                            title:(NSString *)title
                      imageSize:(NSDictionary*)imageSize;

@end
