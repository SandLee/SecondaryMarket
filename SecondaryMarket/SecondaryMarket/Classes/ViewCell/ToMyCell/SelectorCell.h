//
//  SelectorCell.h
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/13.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectorCellDelegate <NSObject>


@optional
- (void)didSelecteItem:(NSInteger)index;

@end
@interface SelectorCell : UITableViewCell
@property (nonatomic,strong)IBOutlet UIButton* tobuybtn;
@property (nonatomic,strong)IBOutlet UIButton* tosalebtn;
@property (nonatomic,strong)IBOutlet UIButton* tofavbtn;
@property (nonatomic,strong)id<SelectorCellDelegate> delegate;

@end
