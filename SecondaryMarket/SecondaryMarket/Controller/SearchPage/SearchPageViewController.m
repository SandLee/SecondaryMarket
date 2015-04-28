//
//  SearchPageViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "SearchPageViewController.h"
#import "MacroDefinition.h"
@interface SearchPageViewController ()<UISearchBarDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,retain) UISearchBar* searchBar;
@property (nonatomic,assign) BOOL keyboardIsVisible;
@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (IOS_VERSION>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    self.title = @"";
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    _searchBar.placeholder = @"Search";   //设置占位符
    _searchBar.delegate = self;   //设置控件代理
    [_searchBar setShowsCancelButton:YES animated:YES];
    self.navigationItem.titleView = _searchBar;
    
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.delegate = self;
    [self.tableview addGestureRecognizer:gestureRecognizer];
    
    self.RecentCategories = [[NSMutableArray alloc] init];
    self.AllCategories = [[NSMutableArray alloc] init];
    
    [self.AllCategories addObject:@"Everything"];
    [self.AllCategories addObject:@"Gifts"];
    [self.AllCategories addObject:@"Popular"];
    [self.AllCategories addObject:@"Videos"];
    [self.AllCategories addObject:@"Animals &Pets"];
    [self.AllCategories addObject:@"Architecture"];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
    _keyboardIsVisible = NO;
}
- (void)keyboardDidShow
{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    _keyboardIsVisible = NO;
}

- (BOOL)keyboardIsVisible
{
    return _keyboardIsVisible;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) hideKeyboard {
    [_searchBar resignFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.RecentCategories count] == 0) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0 &&[self.RecentCategories count ]!= 0) {
        return [self.RecentCategories count];
    }
    else
    {
        return [self.AllCategories count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellby"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellby"];
    }
    
    if (indexPath.section == 0&& [self.RecentCategories count] != 0) {
        cell.textLabel.text = [self.RecentCategories objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.AllCategories objectAtIndex:indexPath.row];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0&& [self.RecentCategories count ]!= 0) {
        return @"Recent Categories";
    }
    else
    {
        return @"All Categories";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 1)
    {
        [self.RecentCategories addObject:[self.AllCategories objectAtIndex:indexPath.row]];
        [self.tableview reloadData];
    }
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (!_keyboardIsVisible) {
        return NO;
    }
    return YES;
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
