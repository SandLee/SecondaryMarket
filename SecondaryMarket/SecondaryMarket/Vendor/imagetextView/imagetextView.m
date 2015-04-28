//
//  imagetextView.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "imagetextView.h"
#import "XHPinterest.h"
@implementation imagetextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        
        [self addSubview:self.image];
        
        UILabel* deslab = [[UILabel alloc] initWithFrame:CGRectMake(46, 7, 90, 13)];
        deslab.textColor = [UIColor grayColor];
        deslab.text = @"Found in";
        deslab.font = [UIFont boldSystemFontOfSize:11];
        [self addSubview:deslab];
       
        [self addSubview:self.titlelabel];
    }
    return self;

}
-(UIImageView*)image
{
    if (!_image) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 26, 26)];
    }
    return _image;
}
-(UILabel*)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(46, 20, 90, 13)];
        _titlelabel.textColor = [UIColor grayColor];

        _titlelabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _titlelabel;
}
- (void)setDisplayPinterest:(XHPinterest *)displayPinterest {
    _displayPinterest = displayPinterest;
    
    self.image.image = displayPinterest.image;
    self.titlelabel.text = displayPinterest.title;
//    self..text = displayPinterest.title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
