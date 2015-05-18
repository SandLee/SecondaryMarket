//
//  HeaderView.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "HeaderView.h"
#import "XHWaterfallContainerView.h"
#import "DescribeCell.h"
#import "GHContextMenuView.h"
#import "XHUIKitMacro.h"
@interface tableViewHeader : UIView<GHContextOverlayViewDataSource, GHContextOverlayViewDelegate>

@property (nonatomic, strong) XHWaterfallContainerView *waterfallContainerView;

@end

@implementation tableViewHeader

#pragma mark - Propertys

- (XHWaterfallContainerView *)waterfallContainerView {
    if (!_waterfallContainerView) {
        _waterfallContainerView = [[XHWaterfallContainerView alloc] initWithFrame:CGRectMake(kXHLargeGridItemPadding, kXHLargeGridItemPadding, CGRectGetWidth(self.bounds) - kXHLargeGridItemPadding * 2, CGRectGetHeight(self.bounds) - kXHLargeGridItemPadding * 2) cornerRadii:6 * ((CGRectGetWidth(kXHScreen) - kXHLargeGridItemPadding * 2) / KXHGridItemWidth)];
    }
    return _waterfallContainerView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
        overlay.dataSource = self;
        overlay.delegate = self;
        
        UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
        [self.waterfallContainerView.backgroundImageView setUserInteractionEnabled:YES];
        [self.waterfallContainerView.backgroundImageView addGestureRecognizer:_longPressRecognizer];
        
        [self addSubview:self.waterfallContainerView];
    }
    return self;
}
- (NSInteger) numberOfMenuItems
{
    return 3;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"facebook-white";
            break;
        case 1:
            imageName = @"twitter-white";
            break;
        case 2:
            imageName = @"google-plus-white";
            break;
        case 3:
            imageName = @"linkedin-white";
            break;
        case 4:
            imageName = @"pinterest-white";
            break;
            
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    NSString* msg = nil;
    switch (selectedIndex) {
        case 0:
            msg = @"Facebook Selected";
            break;
        case 1:
            msg = @"Twitter Selected";
            break;
        case 2:
            msg = @"Google Plus Selected";
            break;
        case 3:
            msg = @"Linkedin Selected";
            break;
        case 4:
            msg = @"Pinterest Selected";
            break;
            
        default:
            break;
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
}
@end


@interface HeaderView () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableview;
@end

@implementation HeaderView
- (void)setPinterest:(XHPinterest *)pinterest {
    _pinterest = pinterest;
    CGFloat imageHeight = [[pinterest.imageSize  objectForKey:@"height"] floatValue] * kXHScreenWidth/[[pinterest.imageSize  objectForKey:@"width"] floatValue];//pinterest.image.size.height * kXHScreenWidth / pinterest.image.size.width;

    self.tableview.tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), imageHeight);
        [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}
#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
-(void)setHeaderViewTable
{
    [self.tableview removeFromSuperview];
    self.tableview = nil;
    [self addSubview:self.tableview];
}
-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.bounds];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.scrollEnabled = NO;
    }
    return _tableview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        DescribeCell *cell =(DescribeCell*)[tableView dequeueReusableCellWithIdentifier:@"celldes"];
        if (!cell) {
            cell = [[DescribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celldes"];
        }
        cell.titlelab.text = self.pinterest.title;
        
        [cell.icon setImageWithURL:[NSURL URLWithString:self.pinterest.imageURL]];
//        cell.icon.image = self.pinterest.image;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.row == 1 )
    {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellby"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellby"];
        }
        
        UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [cell.contentView addSubview:icon];
        UILabel* icontitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 260, 30)];
        [cell.contentView addSubview:icontitle];
        
        
//        icon.image = self.pinterest.image;
        [icon setImageWithURL:[NSURL URLWithString:self.pinterest.imageURL]];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 15;
        icontitle.text = @"Add by Kelly Henshaw";
        
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, CGRectGetWidth(self.bounds), 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:line];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if(indexPath.row == 2)
    {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellto"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellto"];
        }
        
        UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [cell.contentView addSubview:icon];
        UILabel* icontitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 260, 30)];
        [cell.contentView addSubview:icontitle];
        
        [cell.contentView addSubview:icontitle];
        
//        icon.image = self.pinterest.image;
        [icon setImageWithURL:[NSURL URLWithString:self.pinterest.imageURL]];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 6;
        icontitle.text = @"Add to diy crafts";
        
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, CGRectGetWidth(self.bounds), 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:line];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else
    {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellcomment"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcomment"];
        }
        cell.textLabel.text = @"Add comment";
        
        UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(235, 15, 15, 15)];
        icon1.image = [UIImage imageNamed:@"1.jpeg"];
        [cell.contentView addSubview:icon1];
        
        UILabel* icon1Num = [[UILabel alloc] initWithFrame:CGRectMake(255, 15, 15, 15)];
        icon1Num.textColor = [UIColor grayColor];
        icon1Num.font = [UIFont boldSystemFontOfSize:10];
        icon1Num.text = @"5";
        [cell.contentView addSubview:icon1Num];
        
        UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(275, 15, 15, 15)];
        icon2.image = [UIImage imageNamed:@"1.jpeg"];
        [cell.contentView addSubview:icon2];
        
        UILabel* icon2Num = [[UILabel alloc] initWithFrame:CGRectMake(295, 15, 15, 15)];
        icon2Num.textColor = [UIColor grayColor];
        icon2Num.font = [UIFont boldSystemFontOfSize:10];
        icon2Num.text = @"5";
        [cell.contentView addSubview:icon2Num];
        
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, CGRectGetWidth(self.bounds), 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:line];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        CGFloat imageHeight = _pinterest.image.size.height * kXHScreenWidth / _pinterest.image.size.width ;
//        
//        return imageHeight;
//        
//    }
    if (indexPath.row == 0)
    {
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        CGSize size = CGSizeMake(300,2000);
        CGSize labelsize = [self.pinterest.title sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        return labelsize.height + 44;
    }
    return 50;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat imageHeight = [[self.pinterest.imageSize  objectForKey:@"height"] floatValue] * kXHScreenWidth/[[self.pinterest.imageSize  objectForKey:@"width"] floatValue];//self.pinterest.image.size.height * kXHScreenWidth / self.pinterest.image.size.width;

    tableViewHeader* headerView = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), imageHeight)];

    headerView.waterfallContainerView.displayPinterest = self.pinterest;
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat imageHeight = [[self.pinterest.imageSize  objectForKey:@"height"] floatValue] * kXHScreenWidth/[[self.pinterest.imageSize  objectForKey:@"width"] floatValue];//self.pinterest.image.size.height * kXHScreenWidth / self.pinterest.image.size.width;
    return imageHeight;
}
//#pragma mark - GHMenu methods
//
//-(BOOL) shouldShowMenuAtPoint:(CGPoint)point
//{
//    NSIndexPath* indexPath = [self.tableview indexPathForRowAtPoint:point];
//    UITableViewCell* cell = [self.tableview cellForRowAtIndexPath:indexPath];
//    
//    return cell != nil;
//}
//
//- (NSInteger) numberOfMenuItems
//{
//    return 3;
//}
//
//-(UIImage*) imageForItemAtIndex:(NSInteger)index
//{
//    NSString* imageName = nil;
//    switch (index) {
//        case 0:
//            imageName = @"facebook-white";
//            break;
//        case 1:
//            imageName = @"twitter-white";
//            break;
//        case 2:
//            imageName = @"google-plus-white";
//            break;
//        case 3:
//            imageName = @"linkedin-white";
//            break;
//        case 4:
//            imageName = @"pinterest-white";
//            break;
//            
//        default:
//            break;
//    }
//    return [UIImage imageNamed:imageName];
//}
//
//- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
//{
//    NSIndexPath* indexPath = [self.tableview indexPathForRowAtPoint:point];
//    
//    NSString* msg = nil;
//    switch (selectedIndex) {
//        case 0:
//            msg = @"Facebook Selected";
//            break;
//        case 1:
//            msg = @"Twitter Selected";
//            break;
//        case 2:
//            msg = @"Google Plus Selected";
//            break;
//        case 3:
//            msg = @"Linkedin Selected";
//            break;
//        case 4:
//            msg = @"Pinterest Selected";
//            break;
//            
//        default:
//            break;
//    }
//    
//    msg = [msg stringByAppendingFormat:@" for cell %ld", (long)indexPath.row +1];
//    
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//    
//}
@end
