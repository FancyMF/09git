//
//  BaseMaskWindow.m
//  CKI
//
//  Created by izhongpei on 2017/11/23.
//  Copyright © 2017年  All rights reserved.
//

#import "BaseMaskWindow.h"

#define kMaskColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] //遮罩颜色，目前显示为透明

static BaseMaskWindow *m_window;

@interface BaseMaskWindow()

@property (nonatomic, assign, readwrite) NSInteger count;

@end

@implementation BaseMaskWindow

+ (instancetype)shareMaskWindow {
    if (!m_window) {
        m_window = [[BaseMaskWindow alloc] init];
        m_window.frame = [[UIScreen mainScreen] bounds];
        m_window.windowLevel = UIWindowLevelAlert - 0.1;
        m_window.rootViewController = [[UIViewController alloc] init];
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        if (keyWindow.windowLevel > m_window.windowLevel) {
            m_window.windowLevel = UIWindowLevelAlert + 100;
        }
        m_window.backgroundColor = kMaskColor;
        
        m_window.opaque = NO;
        
        m_window.count = 0;
        
        //隐藏掉最前方的view，使之后的view直接加入window时就能有响应
        m_window.rootViewController.view.hidden = YES;
        
//        添加点击事件
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//        [m_window addGestureRecognizer:tapGesture];
    }
    return m_window;
}

-(void)addGesture{
    //        添加点击事件
          UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
          [m_window addGestureRecognizer:tapGesture];
    
}

- (void)show {
    [self showImmediately];
}

- (void)showImmediately {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!m_window.count) {
        [m_window makeKeyAndVisible];
    }
    m_window.count++;
}

//暂不外放
/**
 *  延迟展现window
 *
 *  @param delay 延迟时间
 */
- (void)showAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(showImmediately) withObject:nil afterDelay:delay];
}

- (void)dismiss {
    [self performSelector:@selector(dismissImmediately) withObject:nil afterDelay:0.01f];
}

- (void)dismissImmediately {
    m_window.count--;
    if (!m_window.count) {
        m_window.hidden = YES;
        m_window = nil;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    }
}

- (void)dismissAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(dismissImmediately) withObject:nil afterDelay:delay];
}

@end
