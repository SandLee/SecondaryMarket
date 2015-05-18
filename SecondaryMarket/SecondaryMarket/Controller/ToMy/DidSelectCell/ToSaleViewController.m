//
//  ToSaleViewController.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/18.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ToSaleViewController.h"
#import "ArticlesPublishedViewController.h"
@interface ToSaleViewController ()

@end

@implementation ToSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我卖的";
    // Do any additional setup after loading the view from its nib.
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 7, 40, 30)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"发布"  forState:UIControlStateNormal];
    [rightButton setTitle:@"发布"  forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(clickrightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)clickrightButton
{
    ArticlesPublishedViewController* ArticlesPublished = [[ArticlesPublishedViewController alloc] initWithNibName:@"ArticlesPublishedViewController" bundle:nil];
    [self.navigationController pushViewController:ArticlesPublished animated:YES];
}
@end
