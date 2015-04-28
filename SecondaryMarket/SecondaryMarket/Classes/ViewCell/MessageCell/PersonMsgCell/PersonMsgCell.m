//
//  PersonMsgCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "PersonMsgCell.h"

@implementation PersonMsgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)PersonReply:(id)sender
{
    DLog(@"回复");
    if(_delegate && [_delegate respondsToSelector:@selector(skipReplyPage:)]){
        [_delegate skipReplyPage:nil];

    }
}
@end
