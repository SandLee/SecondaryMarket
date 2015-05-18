//
//  ArticlesPublishedViewController.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-23.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "ArticlesPublishedViewController.h"
#import "ArticlesPublishedCellCell.h"

#import "ArticlesDescribeCell.h"
#import "PictureCell.h"
#import "TitleCell.h"
@interface ArticlesPublishedViewController ()
@property UINib *PublishedNib;
@property UINib *ClassifyNib;
@property UINib *ArticlesDescribeNib;
@property UINib *PictureNib;
@property UINib *TitleNib;
@end

@implementation ArticlesPublishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"物品发布";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 7, 40, 30)];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回"  forState:UIControlStateNormal];
    [leftButton setTitle:@"返回"  forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton] ;
    
    self.PublishedNib = [UINib nibWithNibName:@"ArticlesPublishedCellCell" bundle:nil];
    self.ClassifyNib = [UINib nibWithNibName:@"ClassifyCell" bundle:nil];
    self.ArticlesDescribeNib = [UINib nibWithNibName:@"ArticlesDescribeCell" bundle:nil];
    self.PictureNib = [UINib nibWithNibName:@"PictureCell" bundle:nil];
    self.TitleNib = [UINib nibWithNibName:@"TitleCell" bundle:nil];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.scrollEnabled = NO;
    self.tableview.separatorStyle = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [self.tableview addGestureRecognizer:tap];
}
- (void)clickLeftButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) hideKeyboard
{
    
    TitleCell *titcell = (TitleCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [titcell.textField resignFirstResponder];
    
    ArticlesPublishedCellCell *Articles = (ArticlesPublishedCellCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [Articles.textField resignFirstResponder];
    
    ArticlesDescribeCell* cell = (ArticlesDescribeCell*)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [cell.textView resignFirstResponder];
    
    [self cancelLocatePicker:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        TitleCell *cell = (TitleCell *)[[self.TitleNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.row == 1 ) {
        ArticlesPublishedCellCell *cell = (ArticlesPublishedCellCell *)[[self.PublishedNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.row == 2)
    {
        ClassifyCell* cell = (ClassifyCell *)[[self.ClassifyNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        [cell setUpClassify];
        cell.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if(indexPath.row == 3)
    {
        ArticlesDescribeCell* cell = (ArticlesDescribeCell *)[[self.ArticlesDescribeNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else {
        PictureCell*
        cell = (PictureCell *)[[self.PictureNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        
        
        self.photoView = [[MessagePhotoView alloc]initWithFrame:CGRectMake(0.0f,0.0f,CGRectGetWidth(self.view.frame), 175)];
        [cell.contentView addSubview:self.photoView];
        self.photoView.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return 100;
    }
    else if(indexPath.row == 4)
    {
        return 176;
    }
    
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* v_footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    UIButton* ReleaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ReleaseBtn.frame = CGRectMake(10, 0, CGRectGetWidth(v_footView.frame)-20, CGRectGetHeight(v_footView.frame));
    [ReleaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    [ReleaseBtn setTintColor:[UIColor whiteColor]];
    [ReleaseBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
    [ReleaseBtn setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateHighlighted];
    [ReleaseBtn addTarget:self action:@selector(ArticlesPublished:) forControlEvents:UIControlEventTouchUpInside];
    
    [v_footView addSubview:ReleaseBtn];
    return v_footView;
}

//实现代理方法
-(void)addPicker:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)addUIImagePicker:(UIImagePickerController *)picker
{
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)ArticlesPublished:(UIButton*)sender
{
    
    DLog(@"%@",self.photoView.photoMenuItems);
//    DLog(@"发布");
//    [self addProductInfo];
    [self HandPhotoToLocal];
}


- (void)GotoTSLocate:(NSString*)stepper
{
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"物品类型" delegate:self];
    locateView.tag = 1010;
    [locateView showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    
    
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        NSIndexPath *index =  [NSIndexPath indexPathForRow:2 inSection:0];
        ClassifyCell *cell =  (ClassifyCell*)[self.tableview cellForRowAtIndexPath:index];
        if (location.district.length == 0) {
            cell.ClassifyType.text = [NSString stringWithFormat:@"%@ %@", location.state, location.city];
        }
        else
        {
            cell.ClassifyType.text = [NSString stringWithFormat:@"%@ %@ %@", location.state, location.city, location.district];
        }
    }
}
-(void)cancelLocatePicker:(NSString *)stepper
{
    TSLocateView *locateView = (TSLocateView*)[self.view viewWithTag:1010];
    [locateView removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addProductInfo
{
    UITextField* text = (UITextField*)[self.view viewWithTag:100];
    NSString* name = text.text;
//    text = (UITextField*)[self.view viewWithTag:101];
//    NSString* price = text.text;
//    
//    CBTextView* CBText = (CBTextView*)[self.view viewWithTag:102];
//    NSString* describe = CBText.textView.text;
//    
    NSString* url = [NSString stringWithFormat:@"%@?name=%@&keywords=%@&seq=1&productState=sj&userId=test01",[APIAddress ApiAddProduct],name,name];
    
    [HttpClient asynchronousRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        DLog(@"data %@ msg = %@",data,msg);
    } failureBlock:^(NSString *description) {
        DLog(@"msg = %@",description);
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
    }];
}

-(void)HttpUpdateImage:(NSArray*)photoArr
{
    DLog(@"photoArr = %@",photoArr);
    
//    UITextField* text = (UITextField*)[self.view viewWithTag:100];
//    NSString* name = text.text;
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [photoArr count]; i++) {
        MImageFile * file = [photoArr objectAtIndex:i];
        [arr addObject:file.filePath];
    }
    
    NSString* url = [NSString stringWithFormat:@"%@",[APIAddress ApiUploadAnnex]];
    
//    url = @"http://market.termire.com:8412/Market/uploadServletDemo";
    
    DLog(@"url = %@",url);
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init ];
    [dictionary setObject:@"11111" forKey:@"foreignId"];
    [dictionary setObject:@"2222" forKey:@"belongFiled"];
    [dictionary setObject:@"" forKey:@"annex"];
    [HttpClient asynchronousRequestUploadWithProgress:url parameters:nil files:photoArr successBlock:^(BOOL success, id data, NSString *msg) {
        DLog(@"data = %@ msg = %@",data,msg);
        
    } failureBlock:^(NSString *description) {
        DLog(@"description= %@",description);
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
    }];
}

-(void)HandPhotoToLocal
{
    NSString * tempDir = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * headDir = [tempDir stringByAppendingPathComponent:@"GoodsImage"];
    if(![fileManager fileExistsAtPath:headDir]){//如果不存在该目录 则创建
        NSError * error;
        [fileManager createDirectoryAtPath:headDir withIntermediateDirectories:YES
                                attributes:nil error:&error];
        if(error){
            //NSLog(error);
        } else {
            // NSLog(headDir);
            
        }
    }
    
    
    NSMutableArray * files = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.photoView.photoMenuItems count]; i ++) {
        ALAsset* ALurl = (ALAsset*)[self.photoView.photoMenuItems objectAtIndex:i];
        ALAssetRepresentation* representation = [ALurl defaultRepresentation];
        CGImageRef fullScreenImage = [representation  fullScreenImage];
        UIImage *image = [UIImage imageWithCGImage:fullScreenImage];
        image = [image resizedImageWithMaximumSize:CGSizeMake(1000.f, 1000.f)];
        
        NSString* filePath = [headDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[representation filename]]];   // 保存文件的名称
        
        DLog(@"filePath = %@",filePath);
        
        NSArray *tmp = [[NSFileManager defaultManager] directoryContentsAtPath:headDir];
        DLog(@"tmp = %@",tmp);
        
        BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath   atomically:YES]; // 保存成功会返回YES
        if(result){
            MImageFile * file = [[MImageFile alloc] init];
            file.filePath = filePath;
            file.formName = @"file";
            file.fileName = [NSString stringWithFormat:@"%@",[representation filename]];
            file.mimeType = @"image/jpeg";

            [files addObject:file];
        }
    }
    [self HttpUpdateImage:files];
}

@end
