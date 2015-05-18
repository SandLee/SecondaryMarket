//
//  ArticlesDescribeCell.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/12.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ArticlesDescribeCell.h"

@implementation ArticlesDescribeCell

- (void)awakeFromNib {
    // Initialization code
    self.textView.placeHolder = @"请输入您要回复的内容";
    self.textView.placeHolderColor = [UIColor lightGrayColor];
    self.textView.tag = 102;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textView.textView.returnKeyType = UIReturnKeyDefault;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
