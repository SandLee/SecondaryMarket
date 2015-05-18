//
//  LoginViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-20.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCell.h"
#import "UnderLineLabel.h"
#import "RegViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat statusBarHeight=0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
//        statusBarHeight=20;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0+statusBarHeight, self.view.frame.size.width, 64)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(clickLeftButton)];
    [navigationItem setTitle:@"登陆"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    
    [navigationItem setLeftBarButtonItem:leftButton];
    [self.view addSubview:navigationBar];
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.scrollEnabled = NO;
    
    UIView* v_header = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 200)];
    //    v_header.backgroundColor = [UIColor lightGrayColor];
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(v_header.bounds)-2*20, CGRectGetHeight(v_header.bounds)-2*20)];
    imageview.image = [UIImage imageNamed:@"1.jpeg"];
    [v_header addSubview:imageview];
    self.tableview.tableHeaderView=v_header;
    [self.tableview reloadData];
    
}
-(void)clickLeftButton
{
    
    LoginCell  *cell= (LoginCell*)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [cell.UserNameField resignFirstResponder];
    [cell.PasWordField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
//        _window.hidden=YES;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCell *cell =(LoginCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = (LoginCell *)[[NSBundle mainBundle] loadNibNamed:@"LoginCell" owner:self options:nil][0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.tableview.tableHeaderView.bounds) - CGRectGetHeight(self.tableview.tableFooterView.bounds);
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 180;
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* v_header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
////    v_header.backgroundColor = [UIColor lightGrayColor];
//    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(v_header.bounds)-2*20, CGRectGetHeight(v_header.bounds)-2*20)];
//    imageview.image = [UIImage imageNamed:@"1.jpeg"];
//    [v_header addSubview:imageview];
//    return v_header;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* v_footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
//    v_footer.backgroundColor = [UIColor greenColor];
    
    
    UnderLineLabel *label = [[UnderLineLabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(v_footer.bounds)/2-2*20, CGRectGetHeight(v_footer.bounds))];
    label.font = [UIFont boldSystemFontOfSize:12];
    [label setBackgroundColor:[UIColor clearColor]];
    // [label setBackgroundColor:[UIColor yellowColor]];
    [label setTextColor:[UIColor blueColor]];
    [label setBackgroundColor:[UIColor whiteColor]];
    label.highlightedColor = [UIColor redColor];
    label.shouldUnderline = YES;
    
    
    [label setText:@"新用户注册" andCenter:CGPointMake(80, 22)];
    [label addTarget:self action:@selector(labelRegistered)];
    [v_footer addSubview:label];
    
    UnderLineLabel *label1 = [[UnderLineLabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(v_footer.bounds)/2+20, 0, CGRectGetWidth(v_footer.bounds)/2-2*20, CGRectGetHeight(v_footer.bounds))];
    label1.font = [UIFont boldSystemFontOfSize:12];
    [label1 setBackgroundColor:[UIColor clearColor]];
    // [label setBackgroundColor:[UIColor yellowColor]];
    [label1 setTextColor:[UIColor blueColor]];
    [label1 setBackgroundColor:[UIColor whiteColor]];
    label1.highlightedColor = [UIColor redColor];
    label1.shouldUnderline = YES;
    
    
    [label1 setText:@"忘记密码" andCenter:CGPointMake(240, 22)];
    [label1 addTarget:self action:@selector(labelForgotPassword)];
    [v_footer addSubview:label1];
    
    
    return v_footer;
}

- (void)labelRegistered
{
   
    NSLog(@"新用户注册");
    RegViewController* SMSRegister = [[RegViewController alloc] init];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"UserRegistration" forKey:@"RegisterAndChange"];
    [self presentViewController:SMSRegister animated:YES completion:^{
        
    }];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"新用户注册" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alertView show];
}
-(void)labelForgotPassword
{
    NSLog(@"忘记密码");
    
    RegViewController* SMSRegister = [[RegViewController alloc] init];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"ForgotPassword" forKey:@"RegisterAndChange"];
    [self presentViewController:SMSRegister animated:YES completion:^{
        
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
