//
//  ClassifyCell.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/12.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ClassifyCell.h"
@interface ClassifyCell ()
@end

@implementation ClassifyCell
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
    
    
//    self.dropDownView.mSuperView = self;
    
}
-(void)setUpClassify
{
    self.ClassifyType.placeholder = @"请选择";
    self.ClassifyType.keyboardType = UIKeyboardTypeDefault;
    self.ClassifyType.delegate = self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self cancelLocatePicker];
    if (self.ClassifyType == textField) {
        if(delegate &&
           [delegate respondsToSelector:@selector(GotoTSLocate:)]){
            [delegate performSelector:@selector(GotoTSLocate:) withObject:nil];
        }
        return NO;
    }
    
    return YES;
}
-(void)cancelLocatePicker
{
    if(delegate &&
       [delegate respondsToSelector:@selector(cancelLocatePicker:)]){
        [delegate performSelector:@selector(cancelLocatePicker:) withObject:nil];
    }
}
@end
