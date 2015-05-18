//
//  LoginCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-20.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "LoginCell.h"

@implementation LoginCell

- (void)awakeFromNib {
    // Initialization code
    self.UserNameField.placeholder = @"账号";
    [self.UserNameField setBorderStyle:UITextBorderStyleRoundedRect];
    self.UserNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    UIImageView* imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_head.png"]];
    self.UserNameField.leftView=imgV;//设置输入框内左边的图标
    self.UserNameField.leftViewMode = UITextFieldViewModeAlways;
    self.UserNameField.placeholder = @"请输入手机号或邮箱";
    self.UserNameField.delegate = self;
    
    
    [self.PasWordField setBorderStyle:UITextBorderStyleRoundedRect];
    UIImageView* imgpasswd=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_lock.png"]];
    self.PasWordField.leftView=imgpasswd;//设置输入框内左边的图标
    self.PasWordField.leftViewMode = UITextFieldViewModeAlways;
    self.PasWordField.placeholder = @"请输入密码";
    
    self.PasWordField.secureTextEntry = YES;
    self.PasWordField.delegate = self;
    
    self.RemembBox = [[QCheckBox alloc] initWithDelegate:self];
    self.RemembBox.frame = CGRectMake(40, 160, 120, 30);
    [self.RemembBox setTitle:@"记住我" forState:UIControlStateNormal];
    [self.RemembBox setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.RemembBox.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.RemembBox setImage:[UIImage imageNamed:@"checkbox1_unchecked.png"] forState:UIControlStateNormal];
    [self.RemembBox setImage:[UIImage imageNamed:@"checkbox1_checked.png"] forState:UIControlStateSelected];
    [self.RemembBox setChecked:NO];
    [self addSubview:self.RemembBox];
    self.AutoLogin = [[QCheckBox alloc] initWithDelegate:self];
    self.AutoLogin.frame = CGRectMake(160, 160, 120, 30);
    [self.AutoLogin setTitle:@"自动登陆" forState:UIControlStateNormal];
    [self.AutoLogin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.AutoLogin.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.AutoLogin setImage:[UIImage imageNamed:@"checkbox1_unchecked.png"] forState:UIControlStateNormal];
    [self.AutoLogin setImage:[UIImage imageNamed:@"checkbox1_checked.png"] forState:UIControlStateSelected];
    [self.AutoLogin setChecked:NO];
    [self addSubview:self.AutoLogin];
    [self.LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.LoginBtn setTintColor:[UIColor whiteColor]];
    [self.LoginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
    [self.LoginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateHighlighted];
    [self.LoginBtn addTarget:self action:@selector(buttonLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isRemember"] == YES) {
        self.RemembBox.selected = YES;
        self.UserNameField.text = [defaults objectForKey:@"username"];
        NSError *error;
        NSString* password = [SFHFKeychainUtils getPasswordForUsername:self.UserNameField.text andServiceName:[ConfigManager sharedInstance].PubServer_URL error:&error];
        
        
        if(error || !password){
            NSLog(@"❌从Keychain里获取密码出错：%@", error);
        }
        else{
            self.PasWordField.text = password;
            NSLog(@"✅从Keychain里获取密码成功！密码为%@",self.PasWordField.text);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
}
-(void)buttonLogin:(UIButton*)sender
{
    
    
    NSLog(@"登陆");
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    
    NSString *info = @"";
    if ([self.UserNameField.text length] == 0) {
        info = @"请输入账号";
    }
    else if ([self.PasWordField.text length] == 0) {
        info = @"请输入密码";
    }
    if (info.length != 0) {
        [self.viewShaker shakeWithDuration:0.6 completion:^{
                    [[[UIAlertView alloc] initWithTitle:@"登陆"
                                                message:info
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil] show];
        }];
        return;
    }

    NSString* url = [NSString stringWithFormat:@"%@?loginName=%@&loginPwd=%@",[APIAddress ApiCheckLogin],self.UserNameField.text,self.PasWordField.text];
    
    DLog(@"url = %@",url);
    
    [HttpClient asynchronousCommonJsonRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        
//        DLog(@"data = %@,msg = %@",data,[data objectForKey:@"msg"]);
        if([data objectForKey:@"code"] &&[[[data objectForKey:@"code"] substringFromIndex:2] intValue]==1){
            DLog(@"成功");
            if (self.RemembBox.selected) {
                [defaults setBool:YES forKey:@"isRemember"];
                [defaults setObject:self.UserNameField.text forKey:@"username"];
            }
            else
            {
                [defaults setBool:NO forKey:@"isRemember"];
                [defaults setObject:@"" forKey:@"username"];
            }
            [self saveUsenameAndPasswad:self.RemembBox.selected];
            
            AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            [delegate setupLeveyTabBarController];
            
        }
        else
        {
            DLog(@"msg = %@",[data objectForKey:@"msg"]);
            [self.viewShaker shakeWithDuration:0.6 completion:^{
                        [[[UIAlertView alloc] initWithTitle:@"登陆"
                                                    message:[data objectForKey:@"msg"]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil] show];
            }];
        }
        
    } failureBlock:^(NSString *description) {
        DLog(@"failureBlock");
        [self.viewShaker shakeWithDuration:0.6 completion:^{
                    [[[UIAlertView alloc] initWithTitle:@"登陆"
                                                message:description
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil] show];
        }];
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        DLog(@"progressBlock");
    }];
    
    
    
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [self.UserNameField resignFirstResponder];
    [self.PasWordField resignFirstResponder];
    
}

-(void)saveUsenameAndPasswad:(BOOL)isSave
{
    NSError *error;
    NSString* username;
    NSString* password;
    NSString* serviecname;
    if (isSave) {
        username = self.UserNameField.text;
        password = self.PasWordField.text;
        serviecname = [ConfigManager sharedInstance].PubServer_URL;
    }
    else
    {
        username = @"";
        password = @"";
        serviecname = @"";
    }
    BOOL saved = [SFHFKeychainUtils storeUsername:username andPassword:password forServiceName:serviecname updateExisting:YES error:&error];
    
    if (!saved) {
        NSLog(@"❌Keychain保存密码时出错：%@", error);
    }else{
        NSLog(@"✅Keychain保存密码成功！");
    }
}
@end
