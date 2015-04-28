//
//  RightViewController.m
//  ToyHouse
//
//  Created by wuxinyi on 14-12-24.
//  Copyright (c) 2014年 wuxinyi. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createrView];
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
-(void)createrView{
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, [UIScreen mainScreen].bounds.size.height)];
    [label setText:@"这是右视图"];
    [label setTextColor:[UIColor whiteColor]];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:100]];
    
    [self.view addSubview:label];
}

@end
