//
//  BaseView.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/16.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)resetUI{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)dealloc{
    NSLog(@"%@释放了",[self class]);
}

@end
