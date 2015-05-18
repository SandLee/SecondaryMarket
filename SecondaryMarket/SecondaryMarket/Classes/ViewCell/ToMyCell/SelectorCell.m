//
//  SelectorCell.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/13.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "SelectorCell.h"

@implementation SelectorCell

- (void)awakeFromNib {
    // Initialization code
    
    self.tobuybtn.tag = 100;
    [self.tobuybtn addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventTouchUpInside];
    self.tosalebtn.tag = 101;
    [self.tosalebtn addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventTouchUpInside];
    self.tofavbtn.tag = 102;
    [self.tofavbtn addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadData:(UIButton*)sender
{
    [self.delegate didSelecteItem:sender.tag];
}
@end
