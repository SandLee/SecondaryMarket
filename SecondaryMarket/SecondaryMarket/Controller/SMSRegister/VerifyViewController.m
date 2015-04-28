//
//  VerifyViewController.m
//  SMS_SDKDemo
//
//  Created by admin on 14-6-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "VerifyViewController.h"


@interface VerifyViewController ()<MBProgressHUDDelegate>
{
    NSString* _phone;
    NSString* _areaCode;
    int _state;
    NSMutableData* _data;
    NSString* _localVerifyCode;
    
    NSString* _appKey;
    NSString* _appSecret;
    NSString* _duid;
    NSString* _token;
    NSString* _localPhoneNumber;
    
    NSString* _localZoneNumber;
    NSMutableArray* _addressBookTemp;
    NSString* _contactkey;
//    SMS_UserInfo* _localUser;
    
    NSTimer* _timer1;
    NSTimer* _timer2;
    NSTimer* _timer3;
    
    UIAlertView* _alert1;
    UIAlertView* _alert2;
    UIAlertView* _alert3;
    

}

@end

static int count = 0;

//最近新好友信息
static NSMutableArray* _userData2;

@implementation VerifyViewController

-(void)clickLeftButton
{

    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"验证码短信可能略有延迟,确定返回并重新开始"
                                                 delegate:self
                                        cancelButtonTitle:@"返回"
                                        otherButtonTitles:@"等待", nil];
    _alert2=alert;
    [alert show];    
}

-(void)setPhone:(NSString*)phone AndAreaCode:(NSString*)areaCode
{
    _phone=phone;
    _areaCode=areaCode;
}

-(void)submit
{
    //验证号码
    //验证成功后 获取通讯录 上传通讯录
    [self.view endEditing:YES];
    
    if(self.verifyCodeField.text.length!=6)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"请确认你的国家或地区并输入手机号"
                                                      message:@"验证码格式错误,请重新填写"
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@?mobile=%@&captcha=%@",[APIAddress ApiCheckCaptcha],_phone,self.verifyCodeField.text];
        DLog(@"url = %@",url);
        [HttpClient asynchronousCommonJsonRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
            if ([[data objectForKey:@"result"] intValue] == 1)
            {
                NSLog(@"验证成功");
                NSString* str=[NSString stringWithFormat:@"验证码正确"];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"验证成功"
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
                [alert show];
                
                
                _alert3=alert;

            }
            else
            {
                NSLog(@"验证失败");
                NSString* str=[NSString stringWithFormat:@"验证码无效 请重新获取验证码"];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"验证失败"
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
                [alert show];

            }
        } failureBlock:^(NSString *description) {
            NSLog(@"验证失败");
            NSString* str=[NSString stringWithFormat:@"验证码无效 请重新获取验证码"];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"验证失败"
                                                          message:str
                                                         delegate:self
                                                cancelButtonTitle:@"好"
                                                otherButtonTitles:nil, nil];
            [alert show];

        } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
        }];

    }
}


-(void)CannotGetSMS
{
    NSString* str=[NSString stringWithFormat:@"%@:%@",@"我们将重新发送验证码短信到这个号码" ,_phone];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"确认手机号码" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    _alert1=alert;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==_alert1)
    {
        if (1==buttonIndex)
        {
            NSLog(@"重发验证码");
            NSString* url = [NSString stringWithFormat:@"%@?mobile=%@",[APIAddress ApiSendSMSCaptcha],_phone];
            DLog(@"url = %@",url);
            [HttpClient asynchronousCommonJsonRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
                if ([[data objectForKey:@"result"] intValue] == 1) {
                    
                }
                else
                {
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"发送失败"
                                                                  message:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"好"
                                                        otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                
            } failureBlock:^(NSString *description) {
                
            } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                
            }];

        }
        
    }
    
    if (alertView==_alert2) {
        if (0==buttonIndex)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [_timer2 invalidate];
                [_timer1 invalidate];
            }];
        }
    }
    
    if (alertView==_alert3)
    {
//        YJViewController* yj=[[YJViewController alloc] init];
//        [self presentViewController:yj animated:YES completion:^{
//            //解决等待时间乱跳的问题
//            [_timer2 invalidate];
//            [_timer1 invalidate];
//        }];
    }
//

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat statusBarHeight=0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight=20;
    }
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0+statusBarHeight, self.view.frame.size.width, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(clickLeftButton)];
    
    //设置导航栏内容
    [navigationItem setTitle:@"验证码正确"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationItem setLeftBarButtonItem:leftButton];
    [self.view addSubview:navigationBar];
    
    UILabel* label=[[UILabel alloc] init];
    label.frame=CGRectMake(15, 53+statusBarHeight, self.view.frame.size.width - 30, 21);
    label.text=[NSString stringWithFormat:@"我们已发送验证码到这个号码"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:label];
    
    _telLabel=[[UILabel alloc] init];
    _telLabel.frame=CGRectMake(15, 82+statusBarHeight, self.view.frame.size.width - 30, 21);
    _telLabel.textAlignment = NSTextAlignmentCenter;
    _telLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:_telLabel];
    self.telLabel.text= [NSString stringWithFormat:@"+%@ %@",_areaCode,_phone];
    
    _verifyCodeField=[[UITextField alloc] init];
    _verifyCodeField.frame=CGRectMake(15, 111+statusBarHeight, self.view.frame.size.width - 30, 46);
    _verifyCodeField.borderStyle=UITextBorderStyleBezel;
    _verifyCodeField.textAlignment=NSTextAlignmentCenter;
    _verifyCodeField.placeholder=@"验证码正确";
    _verifyCodeField.font=[UIFont fontWithName:@"Helvetica" size:18];
    _verifyCodeField.keyboardType=UIKeyboardTypePhonePad;
    _verifyCodeField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:_verifyCodeField];
    
    _timeLabel=[[UILabel alloc] init];
    _timeLabel.frame=CGRectMake(15, 169+statusBarHeight, self.view.frame.size.width - 30, 40);
    _timeLabel.numberOfLines = 0;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    _timeLabel.text=@"接受短信大约需要60秒";
    [self.view addSubview:_timeLabel];
    
    _repeatSMSBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _repeatSMSBtn.frame=CGRectMake(15, 169+statusBarHeight, self.view.frame.size.width - 30, 30);
    [_repeatSMSBtn setTitle:@"收不到短信验证码？" forState:UIControlStateNormal];
    [_repeatSMSBtn addTarget:self action:@selector(CannotGetSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_repeatSMSBtn];
    
    _submitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
//    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button4.png"];
//    [_submitBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[UIColor blueColor]];
    _submitBtn.frame=CGRectMake(15, 220+statusBarHeight, self.view.frame.size.width - 30, 42);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];

    self.repeatSMSBtn.hidden=YES;
    
    [_timer2 invalidate];
    [_timer1 invalidate];
    
    count = 0;
    
    NSTimer* timer=[NSTimer scheduledTimerWithTimeInterval:60
                                           target:self
                                         selector:@selector(showRepeatButton)
                                         userInfo:nil
                                          repeats:YES];
    
    NSTimer* timer2=[NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(updateTime)
                                                  userInfo:nil
                                                   repeats:YES];
    _timer1=timer;
    _timer2=timer2;
    
    [SMS_MBProgressHUD showMessag:NSLocalizedString(@"sendingin", nil) toView:self.view];
 
}



-(void)updateTime
{
    count++;
    if (count>=60)
    {
        [_timer2 invalidate];
        return;
    }
    //NSLog(@"更新时间");
    self.timeLabel.text=[NSString stringWithFormat:@"%@%i%@",@"接收验证码中...",60-count,@"秒"];
    
    if (count == 30)
    {
        if (_voiceCallMsgLabel.hidden)
        {
            _voiceCallMsgLabel.hidden = NO;
        }
        
        if (_voiceCallButton.hidden)
        {
            _voiceCallButton.hidden = NO;
        }
    }
}

-(void)showRepeatButton{
    self.timeLabel.hidden=YES;
    self.repeatSMSBtn.hidden=NO;
    
    [_timer1 invalidate];
    return;
}


@end
