//
//  ClassifyCell.h
//  SecondaryMarket
//
//  Created by wuxinyi on 15/5/12.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <UIKit/UIKit.h>
//调用地区选择器
@protocol TSLocateDelegate <NSObject>
@optional
- (void)GotoTSLocate:(NSString*)stepper ;
- (void)cancelLocatePicker:(NSString*)stepper ;

@end
@interface ClassifyCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong)IBOutlet UITextField* ClassifyType;
@property(nonatomic,assign) id<TSLocateDelegate> delegate;
-(void)setUpClassify;
@end
