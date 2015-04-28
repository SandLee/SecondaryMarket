//
//  PersonMsgViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "PersonMsgViewController.h"
#import "PersonMsgCell.h"
#import "KGModal.h"

@interface PersonMsgViewController ()
@property UINib *PersonMsgCellNib;

@end

@implementation PersonMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    self.PersonMsgCellNib = [UINib nibWithNibName:@"PersonMsgCell" bundle:nil];
    
    
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
    PersonMsgCell *cell = (PersonMsgCell *)[[self.PersonMsgCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    cell.DateLabel.text = locationString;
    cell.delegate = self;
    cell.imageView.image = [UIImage imageNamed:@"1"];
    cell.msgLabel.text = @"我想买你的物品可以吗";
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(void)skipReplyPage:(NSIndexPath*)indexPath
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [contentView addGestureRecognizer:gestureRecognizer];
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame)-160)];
    title.text = @"回复";
    title.textColor = [UIColor grayColor];
    title.font = [UIFont boldSystemFontOfSize:16];
    title.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:title];
    
    self.textView = [[CBTextView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(title.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame)-80)];
    self.textView.placeHolder = @"请输入您要回复的内容";
    self.textView.placeHolderColor = [UIColor lightGrayColor];
    
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textView.textView.returnKeyType = UIReturnKeyDefault;
    [contentView addSubview:self.textView];
    
    UIButton* relpyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    relpyBtn.frame = CGRectMake((CGRectGetWidth(contentView.frame)-120)/2, CGRectGetHeight(contentView.frame) - 35, 120, 30);
    [relpyBtn setTitle:@"回复" forState:UIControlStateNormal];
    [relpyBtn setTintColor:[UIColor blackColor]];
    [relpyBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
    [relpyBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateHighlighted];
    [relpyBtn addTarget:self action:@selector(relpy:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:relpyBtn];
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}
-(void)relpy:(UIButton*)sender
{
    [self.textView resignFirstResponder];
    DLog(@"回复");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) hideKeyboard
{
    [self.textView resignFirstResponder];
}
@end
