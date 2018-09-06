//
//  SignNameView.h
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/18.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseView.h"

@interface SignNameView : BaseView

@property (copy, nonatomic) NSString *title;

@property (nonatomic, copy) void (^selectedBlock)(UIImage * image);

- (instancetype)init;
/// 显示
- (void)show;

@end
