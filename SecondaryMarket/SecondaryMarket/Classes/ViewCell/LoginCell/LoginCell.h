//
//  LoginCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-20.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
@interface LoginCell : UITableViewCell<UITextFieldDelegate,QCheckBoxDelegate>
@property(nonatomic,strong)IBOutlet UITextField* UserNameField;
@property(nonatomic,strong)IBOutlet UITextField* PasWordField;
@property(nonatomic,strong)IBOutlet UIButton* LoginBtn;
@property(nonatomic,strong) QCheckBox* RemembBox;
@property(nonatomic,strong) QCheckBox* AutoLogin;
@end
