//
//  DescribeCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "DescribeCell.h"

@implementation DescribeCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titlelab];
        [self addSubview:self.view];
    }
    return self;
}
-(UILabel*)titlelab
{
    if (!_titlelab) {
        _titlelab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 , CGRectGetWidth(self.bounds)-20, 44)];
        _titlelab.font = [UIFont boldSystemFontOfSize:12];
        _titlelab.textColor = [UIColor blackColor];
        _titlelab.numberOfLines = 0;
        _titlelab.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _titlelab;
}
-(UIView *)view
{
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.titlelab.bounds) , CGRectGetWidth(self.bounds), 44)];
        
        [_view addSubview:self.icon];
        
    }
    return _view;
}
-(UIImageView*)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-40, 7, CGRectGetHeight(self.view.bounds)-2*7, CGRectGetHeight(self.view.bounds)-2*7)];
        
    }
    return _icon;
}
@end
