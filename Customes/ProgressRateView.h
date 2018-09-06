//
//  ProgressRateView.h
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/18.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseView.h"

@interface ProgressRateView : BaseView

/// 选中的index
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray <NSString *> *items;// 标题

-(void)resetUI;


/// 用于设置默认数组
+(NSArray <NSString *> *)defaultArray;

/// 用于设置默认数组2
+(NSArray <NSString *> *)defaultArray2;

+(NSArray <NSString *> *)defaultArray3;

@end
