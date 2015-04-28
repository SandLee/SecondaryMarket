//
//  ToMyHeaderCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ToMyHeaderCell.h"
#import "ToMyViewController.h"
#import "LoginViewController.h"
@implementation ToMyHeaderCell

- (void)awakeFromNib {
    // Initialization code
    
    self.FigureIcon.layer.masksToBounds =YES;
    self.FigureIcon.layer.cornerRadius =30;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)login:(id)sender
{
    DLog(@"登陆");
    LoginViewController* LoginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.ToMyview presentViewController:LoginView animated:YES completion:^{
        
    }];
}
@end
