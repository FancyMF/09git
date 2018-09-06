//
//  UIButton+DelayClick.h
//  Huolala
//
//  Created by ace.peng on 2017/3/16.
//  Copyright © 2017年 huolala. All rights reserved.
//  设置按钮的点击响应时间间隔

#import <UIKit/UIKit.h>

@interface UIButton (DelayClick)

@property (nonatomic, assign) NSTimeInterval ace_delayInterval; // 重复点击的间隔
@property (nonatomic, assign) NSTimeInterval ace_acceptEventTime; // 上次响应点击的时候

@end
