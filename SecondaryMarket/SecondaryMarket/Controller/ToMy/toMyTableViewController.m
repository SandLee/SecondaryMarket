//
//  toMyTableViewController.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/8.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "toMyTableViewController.h"
#import "XHPathCover.h"
#import "ToMyBodyCell.h"
#import "LoginViewController.h"



#import "SelectorCell.h"

#import "ToBuyViewController.h"
#import "ToSaleViewController.h"
#import "ToFavViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "ContactToMyViewController.h"
#import "ServiceTermsViewController.h"
#import "ShareApplicationViewController.h"
@interface toMyTableViewController ()<SelectorCellDelegate>
@property (nonatomic, strong) XHPathCover *pathCover;
@property UINib* ToMyBodyCellNib;
@property UINib* SelectorCellNib;
@end

@implementation toMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 7, 40, 30)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"设置"  forState:UIControlStateNormal];
    [rightButton setTitle:@"设置"  forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(clickrightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton] ;
    
    
    
//    self.ToMyBodyCellNib = [UINib nibWithNibName:@"ToMyBodyCell" bundle:nil];
    self.SelectorCellNib = [UINib nibWithNibName:@"SelectorCell" bundle:nil];
    
    self.item = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"我买的", nil],[NSArray arrayWithObjects:@"我买的",@"我卖的",@"我的收藏", nil],[NSArray arrayWithObjects:@"意见反馈",@"检查版本更新",@"分享本应用", nil],[NSArray arrayWithObjects:@"关于",@"联系我们",@"服务条款", nil],nil];
    self.itemImage = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Insurancecalculation_btn.png", nil],[NSArray arrayWithObjects:@"Insurancecalculation_btn.png",@"Thevehiclefiles_btn.png",@"Carcollection_btn.png", nil],[NSArray arrayWithObjects:@"Illegalprocessing_btn.png",@"Insurancecalculation_btn.png",@"Thevehiclefiles_btn.png", nil],[NSArray arrayWithObjects:@"Carcollection_btn.png",@"Insurancecalculation_btn.png",@"Thevehiclefiles_btn.png", nil],nil];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"MenuBackground"]];
    
    [_pathCover setAvatarImage:[UIImage imageNamed:@"1.jpeg"]];
    //        [_pathCover setAvatarUrlString:[self.userInfo objectForKey:@"headImgUrl"]];
    
    self.tableView.tableHeaderView = self.pathCover;
    
    __weak toMyTableViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)clickrightButton
{
//    ArticlesPublishedViewController* ArticlesPublished = [[ArticlesPublishedViewController alloc] initWithNibName:@"ArticlesPublishedViewController" bundle:nil];
//    [self.navigationController pushViewController:ArticlesPublished animated:YES];
}
-(void)loadData
{
    NSString* url = [NSString stringWithFormat:@"%@?loginName=%@",[APIAddress ApiGetUser],@"Admin"];
    
    DLog(@"url = %@",url);
    
    
    [HttpClient asynchronousRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        DLog(@"data = %@ userid = %@",data,[data objectForKey:@"userId"]);
        [self getMemberByUserId:[data objectForKey:@"userId"]];
        
    } failureBlock:^(NSString *description) {
        DLog(@"fail");
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_refreshing {
    // refresh your data sources
    
    __weak toMyTableViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

#pragma mark- scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.item count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.item objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
    if (indexPath.section == 0 &&indexPath.row == 0) {
        
        SelectorCell* cell = (SelectorCell*)[[self.SelectorCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        cell.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = [[self.item objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[[self.itemImage objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//    ToMyBodyCell *cell =(ToMyBodyCell *)[[self.ToMyBodyCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
//    cell.collectionView.frame = CGRectMake(0, 0, self.view.width, 10/2*145);
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 0.5;
    }
    return 44;
//    if (indexPath.row == 0) {
//        return 44;
//    }
//    return 10/2*145;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    DLog(@"我买的");
                    ToBuyViewController* ToBuyView = [[ToBuyViewController alloc] initWithNibName:@"ToBuyViewController" bundle:nil];
//                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ToBuyView animated:YES];
                    break;
                }
                case 1:
                {
                    DLog(@"我卖的");
                    ToSaleViewController* ToSaleView = [[ToSaleViewController alloc] initWithNibName:@"ToSaleViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ToSaleView animated:YES];

                    break;
                }
                case 2:
                {
                    DLog(@"我的收藏");
                    ToFavViewController* ToFavView = [[ToFavViewController alloc] initWithNibName:@"ToFavViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ToFavView animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    DLog(@"意见反馈");
                    FeedbackViewController* FeedbackView = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:FeedbackView animated:YES];
                    break;
                }
                case 1:
                    DLog(@"检查版本更新");
                    break;
                case 2:
                {
                    DLog(@"分享本应用");
                    ShareApplicationViewController* ShareApplicationView = [[ShareApplicationViewController alloc] initWithNibName:@"ShareApplicationViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ShareApplicationView animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                {
                    DLog(@"关于");
                    AboutViewController* AboutView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:AboutView animated:YES];
                    break;
                }
                case 1:
                {
                    DLog(@"联系我们");
                    ContactToMyViewController* ContactToMyView = [[ContactToMyViewController alloc] initWithNibName:@"ContactToMyViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ContactToMyView animated:YES];
                    break;
                }
                case 2:
                {
                    DLog(@"服务条款");
                    ServiceTermsViewController* ServiceTermsView = [[ServiceTermsViewController alloc] initWithNibName:@"ServiceTermsViewController" bundle:nil];
                    //                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ServiceTermsView animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        default:
            break;
    }
}
-(void)setupLoginViewController
{
    LoginViewController* loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:loginView animated:YES completion:^{
        
    }];
}
-(void)getMemberByUserId:(NSString*)UserId
{
    NSString* url = [NSString stringWithFormat:@"%@?userId=%@",[APIAddress ApiGetMemberByUserId],@"test01"];
    DLog(@"url = %@",url);
    [HttpClient asynchronousRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        self.userInfo = data;
        DLog(@"userInfo = %@",self.userInfo);
        [_pathCover setAvatarImage:[UIImage imageNamed:@"1.jpeg"]];
        [_pathCover setAvatarUrlString:@"http://tsed.doing360.com/sites/001/annex/074e6836-deeb-4462-8921-475af4e30707.jpg"];
        [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[self.userInfo objectForKey:@"nickname"], XHUserNameKey, [self.userInfo objectForKey:@"birthday"], XHBirthdayKey, nil]];
        
    } failureBlock:^(NSString *description) {
        DLog(@"失败");
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
    }];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
