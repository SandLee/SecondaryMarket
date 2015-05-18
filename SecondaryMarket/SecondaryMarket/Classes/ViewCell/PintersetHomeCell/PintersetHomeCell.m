//
//  PintersetHomeCell.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-14.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "PintersetHomeCell.h"

#import "imagetextView.h"
@interface PintersetHomeCell ()



//收藏图标
@property (nonatomic,strong) UIView* Colicon;

@property (nonatomic, strong)imagetextView* bottomBtn;


@end
@implementation PintersetHomeCell

- (void)awakeFromNib {
    // Initialization code
}
#pragma mark - Propertys

- (void)setPinterest:(XHPinterest *)pinterest {
    
    
    self.bottomBtn.displayPinterest = pinterest;
    _pinterest = pinterest;

    self.waterfallContainerView.displayPinterest = pinterest;
}
-(imagetextView*)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[imagetextView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-40, CGRectGetWidth(self.bounds), 40)];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handeTap:)];
        [_bottomBtn addGestureRecognizer:tapGes];
    }
    return _bottomBtn;
}

- (XHWaterfallContainerView *)waterfallContainerView {

    if (!_waterfallContainerView) {
        _waterfallContainerView = [[XHWaterfallContainerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 115) cornerRadii:6];
    }
    
    return _waterfallContainerView;
}
-(UILabel*)descriptionLab
{
    if (!_descriptionLab) {
        _descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(self.bounds)-115, CGRectGetWidth(self.bounds)-20, 45)];
//        _descriptionLab.backgroundColor = [UIColor whiteColor];
        _descriptionLab.textAlignment = NSTextAlignmentLeft;
        _descriptionLab.font = [UIFont systemFontOfSize:12];
        _descriptionLab.textColor = [UIColor blackColor];
        _descriptionLab.lineBreakMode = NSLineBreakByTruncatingTail;
        //设置自动行数与字符换行
        [_descriptionLab setNumberOfLines:0];
        _descriptionLab.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _descriptionLab;
}

-(UIView*)Colicon
{
    if (!_Colicon) {
        _Colicon = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-70, CGRectGetWidth(self.bounds), 30)];
        [_Colicon setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
        icon1.image = [UIImage imageNamed:@"1.jpeg"];
        [_Colicon addSubview:icon1];
        
        self.icon1Num = [[UILabel alloc] initWithFrame:CGRectMake(22, 10, 15, 10)];
        self.icon1Num.textColor = [UIColor grayColor];
        self.icon1Num.font = [UIFont boldSystemFontOfSize:10];
//        icon1Num.text = @"5";
        [_Colicon addSubview:self.icon1Num];
        
        UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(47, 10, 10, 10)];
        icon2.image = [UIImage imageNamed:@"1.jpeg"];
        [_Colicon addSubview:icon2];
        
        self.icon2Num = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 15, 10)];
        self.icon2Num.textColor = [UIColor grayColor];
        self.icon2Num.font = [UIFont boldSystemFontOfSize:10];
        [_Colicon addSubview:self.icon2Num];

    }
    return _Colicon;
}
#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
        //设置layer
        
//        DLog(@"initWithFrame = %@",NSStringFromCGRect(frameRect));
        
    }
    return self;
}
-(void)setupPintersetHomeCell
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 20;
    [self removePinterestCell];
    [self addSubview:self.waterfallContainerView];
    
    [self addSubview:self.bottomBtn];
    
    [self addSubview:self.descriptionLab];
    
    [self addSubview:self.Colicon];
}
#pragma mark - XHTansitionWaterfallGridViewProtocol
-(void)removePinterestCell
{
    [self.waterfallContainerView removeFromSuperview];
    self.waterfallContainerView = nil;
    
    [self.bottomBtn removeFromSuperview];
    self.bottomBtn = nil;
    
    [self.descriptionLab removeFromSuperview];
    self.descriptionLab = nil;
    
    [self.Colicon removeFromSuperview];
    self.Colicon = nil;

}
- (UIView *)snapShotForTransition {
//    DLog(@"waterfallContainerView.frame = %@",NSStringFromCGRect(self.waterfallContainerView.frame));
    XHWaterfallContainerView *snapShotView = [[XHWaterfallContainerView alloc] initWithFrame:self.waterfallContainerView.frame
                                                                                 cornerRadii:self.waterfallContainerView.cornerRadii];
    snapShotView.displayPinterest = self.waterfallContainerView.displayPinterest;
    return snapShotView;
}
#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    NSLog(@"handeTap");
    if (tap.state == UIGestureRecognizerStateEnded) {
        
        [self HttpAddCollect];
        
    }
    
}
-(void)HttpAddCollect
{
    NSString *url = [NSString stringWithFormat:@"%@?collectId=test&collectorId=test&foreignId=tests1&collectType=test&collectState=test",[APIAddress ApiAddCollect]];
    
    [HttpClient asynchronousRequestWithProgress:url parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        DLog(@"data = %@ msg = %@",data,msg);
    } failureBlock:^(NSString *description) {
        DLog(@"description = %@",description);
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
    }];
}
@end
