//
//  DataPickerView.h
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/25.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMaskWindow.h"

@interface DataPickerView : UIView

@property (copy, nonatomic) NSString *title;
@property (nonatomic, strong) UIButton *cancleBtn;// 取消按钮
@property (nonatomic, strong) UIButton *confirmBtn; // 确认按钮

@property (strong, nonatomic) NSArray <NSArray <NSString *> *> *dataArray; // 数据源
@property (nonatomic, strong) NSArray <NSString *> * units;

@property (nonatomic, copy) void (^selectedBlock)(NSArray * selectors);
/// 显示
- (void)show;

@end
