//
//  MessageViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "MessageViewController.h"
#import "MacroDefinition.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (IOS_VERSION>7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.slideSwitchView = [[QCSlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height ) ];
    self.slideSwitchView.frame = self.view.bounds;
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"000000"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"ee85ec"];
//    self.slideSwitchView.shadowImage = [[NSObject createImageWithColor:[UIColor blueColor]]
//                                        stretchableImageWithLeftCapWidth:131.0f topCapHeight:0.0f];
    
    self.slideSwitchView.slideSwitchViewDelegate = self;
    
    self.PersonMsg = [[PersonMsgViewController alloc] init];
    
    self.SystemMsg = [[SystemMsgViewController alloc] init];

    [self.slideSwitchView buildUI];
    [self.view addSubview:self.slideSwitchView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//每个分区上的元素个数
- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return 2;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.SystemMsg;
    } else if (number == 1) {
        return self.PersonMsg;
    } else {
        return nil;
    }
}

//- (void)slideSwitchView:(QCSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
//{
//    QCViewController *drawerController = (QCViewController *)self.navigationController.mm_drawerController;
//    [drawerController panGestureCallback:panParam];
//}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    if (number == 0) {
        self.SelectView = self.SystemMsg;
        
    } else if (number == 1) {
        self.SelectView = self.PersonMsg;
        
    }
    
    [self.SelectView viewDidCurrentView];
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
