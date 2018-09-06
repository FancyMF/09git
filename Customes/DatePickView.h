//
//  DatePickView.h
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DatePickerModeDate,
    DatePickerModeDateAndTime,
} ModelDate;

@interface DatePickView : UIView

@property (copy, nonatomic) NSString *title;

@property (nonatomic, copy) void (^selectedBlock)(NSString *timer);

- (instancetype)initWithModelDate:(ModelDate)ModelDate;
/// 显示
- (void)show;

@end
