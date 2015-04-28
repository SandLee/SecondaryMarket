//
//  PersonMsgCell.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-22.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReplyPageDelegate <NSObject>

-(void)skipReplyPage:(NSIndexPath*)indexPath;
@end

@interface PersonMsgCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel* DateLabel;
@property(nonatomic,strong)IBOutlet UIImageView* imgview;
@property(nonatomic,strong)IBOutlet UILabel* msgLabel;
@property(nonatomic,strong)IBOutlet UIButton* ReplyBtn;
@property(nonatomic,strong)id<ReplyPageDelegate>delegate;
-(IBAction)PersonReply:(id)sender;
@end
