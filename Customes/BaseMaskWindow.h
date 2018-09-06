//
//  BaseMaskWindow.h
//  CKI
//
//  Created by izhongpei on 2017/11/23.
//  Copyright © 2017年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMaskWindow : UIWindow
/**  正在使用mask的累计值，每show一次+1，每dismiss一次-1，为0时即会回收，不为0时dismis也继续展现 */
@property (nonatomic, assign, readonly) NSInteger count;

+ (instancetype)shareMaskWindow;

/**
 *  展现maskWindow，立刻展现
 */
- (void)show;

/**
 *  回收maskWindow，立刻回收(实质延迟0.01秒，保证统一遮罩在连续展现时不消失）
 */
- (void)dismiss;

/**
 *  延迟回收window
 *
 *  @param delay 延迟时间
 */
- (void)dismissAfterDelay:(NSTimeInterval)delay;

/**
 *  点击消失手势
 */
-(void)addGesture;

@end
