//
//  BaseNavigationVCtler.m
//
//  Created by chenpeihang on 2018/2/11.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseNavigationVCtler.h"
#import "UIImage+Handle.h"


@interface BaseNavigationVCtler ()

@end

@implementation BaseNavigationVCtler

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName:kFontBodySize(19),
                                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                                 }];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorTheme() cornerRadius:0] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setShadowImage:[UIImage new]];//分割线
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count < 1) {
        
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
