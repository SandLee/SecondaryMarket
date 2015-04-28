//
//  ArticlesPublishedViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-23.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ArticlesPublishedViewController.h"
#import "ArticlesPublishedCellCell.h"
@interface ArticlesPublishedViewController ()
@property UINib *PublishedNib;
@end

@implementation ArticlesPublishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.PublishedNib = [UINib nibWithNibName:@"ArticlesPublishedCellCell" bundle:nil];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ArticlesPublishedCellCell *cell = (ArticlesPublishedCellCell *)[[self.PublishedNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    return cell;
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
