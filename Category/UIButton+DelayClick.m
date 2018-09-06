//
//  UIButton+DelayClick.m
//  Huolala
//
//  Created by ace.peng on 2017/3/16.
//  Copyright © 2017年 huolala. All rights reserved.
//

#import "UIButton+DelayClick.h"
#import <objc/runtime.h>

@implementation UIButton (DelayClick)

static const char *ace_delayIntervalKey = "ace_delayIntervalKey";

- (NSTimeInterval)ace_delayInterval {
    return  [objc_getAssociatedObject(self, ace_delayIntervalKey) doubleValue];
}

- (void)setAce_delayInterval:(NSTimeInterval)ace_delayInterval {
    objc_setAssociatedObject(self, ace_delayIntervalKey, @(ace_delayInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *ace_acceptEventTimeKey = "ace_acceptEventTimeKey";

- (NSTimeInterval)ace_acceptEventTime {
    return  [objc_getAssociatedObject(self, ace_acceptEventTimeKey) doubleValue];
}

- (void)setAce_acceptEventTime:(NSTimeInterval)ace_acceptEventTime {
    objc_setAssociatedObject(self, ace_acceptEventTimeKey, @(ace_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL selBefore = @selector(sendAction:to:forEvent:);
        SEL selAfter = @selector(ace_sendAction:to:forEvent:);
        
        Method methedBefore   = class_getInstanceMethod(self, selBefore);
        Method methedAfter    = class_getInstanceMethod(self, selAfter);
        BOOL isAdd =class_addMethod(self, selBefore,method_getImplementation(methedAfter),method_getTypeEncoding(methedAfter));
        
        if(isAdd) {
            class_replaceMethod(self, selAfter,method_getImplementation(methedBefore),method_getTypeEncoding(methedBefore));
        }else{
            method_exchangeImplementations(methedBefore, methedAfter);
        }
    });
}

- (void)ace_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if ([self class] == [UIButton class]) {
        if ([NSDate date].timeIntervalSince1970 - self.ace_acceptEventTime < self.ace_delayInterval) {
            return;
        }
        
        if (self.ace_delayInterval > 0) {
            self.ace_acceptEventTime = [NSDate date].timeIntervalSince1970;
        }
    }
    
    [self ace_sendAction:action to:target forEvent:event];
}

@end
