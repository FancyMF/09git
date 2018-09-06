//
//  BaseTabBarVCtler.m
//
//  Created by chenpeihang on 2018/2/11.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseTabBarVCtler.h"

@interface BaseTabBarVCtler ()

@end

@implementation BaseTabBarVCtler


-(void)viewDidLoad{
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = kColorTheme();
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- 橫豎屏設置
- (BOOL)shouldAutorotate{
    return NO;
} //NS_AVAILABLE_IOS(6_0);当前viewcontroller是否支持转屏

- (NSUInteger)supportedInterfaceOrientation{
    return UIInterfaceOrientationPortrait;
} //当前viewcontroller支持哪些转屏方向

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
} //当前viewcontroller默认的屏幕方向


@end
