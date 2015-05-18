//
//  ToMyHeaderView.h
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/16.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToMyHeaderView : UICollectionReusableView

@property(nonatomic,strong)IBOutlet UIImageView* Headportrait;
@property(nonatomic,strong)IBOutlet UILabel* nameLabel;


-(IBAction)login:(id)sender;

-(IBAction)skipToBuy:(id)sender;

-(IBAction)skipToSale:(id)sender;

-(IBAction)skipToFav:(id)sender;
@end
