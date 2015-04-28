//
//  SystemMsgViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "SystemMsgViewController.h"
#import "SystemMsgCell.h"
@interface SystemMsgViewController ()
@property UINib *SystemMsgCellNib;
@end

@implementation SystemMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"系统信息";
    self.SystemMsgCellNib = [UINib nibWithNibName:@"SystemMsgCell" bundle:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidCurrentView
{
    
    NSLog(@"加载为当前视图 = %@",self.title);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMsgCell *cell = (SystemMsgCell *)[[self.SystemMsgCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd hh24:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    cell.DateLabel.text = locationString;
    
//    cell.imageView.image = [UIImage imageNamed:@"1.jpeg"];
    cell.msgLabel.text = @"你的物口已成功出售";
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
