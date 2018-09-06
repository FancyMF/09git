//
//  NSTimer+BlockCategory.m
//

#import "NSTimer+BlockCategory.h"

@implementation NSTimer (BlockCategory)

+ (NSTimer*)timerWithTimeInterval:(NSTimeInterval)interval taskBlock:(void(^)(void))taskBlock repeats:(BOOL)repeats{
    NSTimer* timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(timeAction:) userInfo:[taskBlock copy] repeats:repeats];
    return timer;
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval taskBlock:(void (^)(void))taskBlock repeats:(BOOL)repeats{
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(scheduledTimeAction:) userInfo:[taskBlock copy] repeats:repeats];
    return timer;
}

+ (void)timeAction:(NSTimer*)timer{
//    DLog(@"\n--TimerIsWorking--\n");
    void(^task)(void) = timer.userInfo;
    if (task){
        task();
    }
}

+ (void)scheduledTimeAction:(NSTimer*)timer{
//    DLog(@"\n--scheduledTimerIsWorking--\n");
    void(^task)(void) = timer.userInfo;
    if (task){
        task();
    }
}

@end
