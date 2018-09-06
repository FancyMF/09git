//
//  GetImageHepler.h
//  SSLiftSalesman
//
//  Created by 侯佩岑 on 2018/6/22.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseModel.h"

/// 设置属性以免 视图被释放
@interface GetImageHepler : BaseModel

-(instancetype)initWithTargetViewVC:(UIViewController *)vc;
@property (nonatomic, weak) UIViewController * targatViewVC;

-(void)requireImageWithTitle:(NSString *)title withSubTitle:(NSString *)subTitle;
@property (nonatomic, copy) void(^selectImageBlock)(UIImage * selectImage);

@end
