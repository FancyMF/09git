//
//  ScheduleView.h
//  myFrame
//
//  Created by 侯佩岑 on 2018/5/11.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleView : UIView

@property (nonatomic, strong) NSArray <NSString *> * titleArray;

@property (nonatomic, strong) NSArray <UIImage *> * selectImageArray;
@property (nonatomic, strong) NSArray <UIImage *> * unSelectImageArray;
@property (nonatomic, strong) NSArray <UIColor *> * colorArray;

@property (nonatomic, assign) CGFloat size; 

@property (nonatomic, assign) NSInteger index; //選擇index,從0開始計算.

-(void)reloadUI;

@end
