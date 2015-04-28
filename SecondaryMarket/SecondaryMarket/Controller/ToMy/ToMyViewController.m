//
//  ToMyViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ToMyViewController.h"
#import "ToMyHeaderCell.h"
#import "ToMyBodyCell.h"
@interface ToMyViewController ()
@property UINib* ToMyHeaderCellNib;
@property UINib* ToMyBodyCellNib;
@end

@implementation ToMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ToMyHeaderCellNib = [UINib nibWithNibName:@"ToMyHeaderCell" bundle:nil];
    self.ToMyBodyCellNib = [UINib nibWithNibName:@"ToMyBodyCell" bundle:nil];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    [self loadData];
}
-(void)loadData
{
    NSString* url = [NSString stringWithFormat:@"%@?loginName=%@",[APIAddress ApiGetUser],@"Admin"];
    
    DLog(@"url = %@",url);
    [HttpClient asynchronousCommonJsonRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        
        DLog(@"data = %@ msg = %@",data,msg);
    } failureBlock:^(NSString *description) {
        DLog(@"failureBlock");
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        DLog(@"progressBlock");
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
    if (indexPath.row == 0) {
        ToMyHeaderCell* cell = (ToMyHeaderCell *)[[self.ToMyHeaderCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        
        cell.FigureIcon.image = [UIImage imageNamed:@"1.jpeg"];
        cell.nicknamelab.text = @"Wuxinyi";
        cell.Emaillab.text = @"ly-080208@163.com";
        cell.ToMyview = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    ToMyBodyCell *cell =(ToMyBodyCell *)[[self.ToMyBodyCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.textLabel.text = @"12dfghjkl;";
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    return 30/2*145;
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
