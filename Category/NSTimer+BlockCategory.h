//
//  NSTimer+BlockCategory.h
//  避免保留环行引用

#import <Foundation/Foundation.h>

@interface NSTimer (BlockCategory)


/**
 带执行block的定时器

 @param interval  时间间隔
 @param taskBlock 执行block
 @param repeats   是否重复

 @return 定时器实例
 */
+ (NSTimer*)timerWithTimeInterval:(NSTimeInterval)interval
                        taskBlock:(void(^)(void))taskBlock
                          repeats:(BOOL)repeats;

/**
 带执行block的延时定时器
 
 @param interval  时间间隔
 @param taskBlock 执行block
 @param repeats   是否重复
 
 @return 定时器实例
 */
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                 taskBlock:(void(^)(void))taskBlock
                                   repeats:(BOOL)repeats;

@end
