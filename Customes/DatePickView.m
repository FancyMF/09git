//
//  DatePickView.m
//

#import "DatePickView.h"
#import "BaseMaskWindow.h"
#import "Masonry.h"

#define kLabelFontSize15 [UIFont systemFontOfSize:15]
#define kLabelFontSize16 [UIFont systemFontOfSize:16]
#define kColorClearColor [UIColor clearColor]
#define kColorBlueColor [UIColor blueColor]
#define kColorWhiteColor [UIColor whiteColor]
#define kColorBABABA [UIColor whiteColor]
#define WS(abc) abc

@interface DatePickView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong)BaseMaskWindow *m_window;

@property(nonatomic,strong)UIView *contentView;

@property (nonatomic, strong) UIButton *cancleBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (strong, nonatomic) UIPickerView *pickerView; // 选择器
@property (strong, nonatomic) UIView *toolView; // 工具条
@property (strong, nonatomic) UILabel *titleLbl; // 标题

@property (strong, nonatomic) NSMutableArray *dataArray; // 数据源
@property (copy, nonatomic) NSString *selectStr; // 选中的时间


@property (strong, nonatomic) NSMutableArray *yearArr; // 年数组
@property (strong, nonatomic) NSMutableArray *monthArr; // 月数组
@property (strong, nonatomic) NSMutableArray *dayArr; // 日数组
@property (strong, nonatomic) NSMutableArray *hourArr; // 时数组
//@property (strong, nonatomic) NSMutableArray *minuteArr; // 分数组
@property (strong, nonatomic) NSArray *timeArr; // 当前时间数组

@property (copy, nonatomic) NSString *year; // 选中年
@property (copy, nonatomic) NSString *month; //选中月
@property (copy, nonatomic) NSString *day; //选中日
@property (copy, nonatomic) NSString *hour; //选中时
//@property (copy, nonatomic) NSString *minute; //选中分

@property (assign, nonatomic) ModelDate model;

@end

@implementation DatePickView

#pragma mark - init
/// 初始化
- (instancetype)initWithModelDate:(ModelDate)ModelDate
{
    self = [super init];
    if (self) {
        self.model = ModelDate;
        
        self.m_window = [BaseMaskWindow shareMaskWindow];
        self.frame = self.m_window.bounds;
        
        self.dataArray = [NSMutableArray array];
        [self.dataArray addObject:self.yearArr];
        [self.dataArray addObject:self.monthArr];
        [self.dataArray addObject:self.dayArr];
        if (ModelDate == DatePickerModeDateAndTime) {
            [self.dataArray addObject:self.hourArr];
            //        [self.dataArray addObject:self.minuteArr];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLbl.text = title;
}

- (void)show {
    self.year = self.timeArr[0];
    self.month = [NSString stringWithFormat:@"%ld月", [self.timeArr[1] integerValue]];
    self.day = [NSString stringWithFormat:@"%ld日", [self.timeArr[2] integerValue]];
    
    
    
    [self.pickerView selectRow:[self.yearArr indexOfObject:self.year] inComponent:0 animated:YES];
    /// 重新格式化转一下，是因为如果是09月/日/时，数据源是9月/日/时,就会出现崩溃
    [self.pickerView selectRow:[self.monthArr indexOfObject:self.month] inComponent:1 animated:YES];
    [self.pickerView selectRow:[self.dayArr indexOfObject:self.day] inComponent:2 animated:YES];
    if (self.model == DatePickerModeDateAndTime){
        self.hour = [NSString stringWithFormat:@"%ld時", [self.timeArr[3] integerValue]];
        //    self.minute = self.minuteArr[self.minuteArr.count / 2];
        [self.pickerView selectRow:[self.hourArr indexOfObject:self.hour] inComponent:3 animated:YES];
        //    [self.pickerView selectRow:self.minuteArr.count / 2 inComponent:4 animated:YES];
    }
    
    
    /// 刷新日
    [self refreshDay];
    
    [self showPickView];
}

-(void)showPickView
{
    [_m_window show];
    [_m_window addSubview:self];
    
    [self addSubview:self.contentView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-self.contentView.frame.size.height, CGRectGetWidth([UIScreen mainScreen].bounds) , self.contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)close
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) , self.contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_m_window dismiss];
        
    }];
}

#pragma mark - 点击方法
/// 保存按钮点击方法
- (void)saveBtnClick {
    NSLog(@"点击了保存");
    
    NSString *month = self.month.length == 3 ? [NSString stringWithFormat:@"%ld", self.month.integerValue] : [NSString stringWithFormat:@"0%ld", self.month.integerValue];
    NSString *day = self.day.length == 3 ? [NSString stringWithFormat:@"%ld", self.day.integerValue] : [NSString stringWithFormat:@"0%ld", self.day.integerValue];
    if (self.model == DatePickerModeDateAndTime){
        NSString *hour = self.hour.length == 3 ? [NSString stringWithFormat:@"%ld", self.hour.integerValue] : [NSString stringWithFormat:@"0%ld", self.hour.integerValue];
        //    NSString *minute = self.minute.length == 3 ? [NSString stringWithFormat:@"%ld", self.minute.integerValue] : [NSString stringWithFormat:@"0%ld", self.minute.integerValue];
        
        //    self.selectStr = [NSString stringWithFormat:@"%ld-%@-%@  %@:%@", [self.year integerValue], month, day, hour, minute];
        self.selectStr = [NSString stringWithFormat:@"%ld-%@-%@-%@", [self.year integerValue], month, day, hour];
    }else{
        self.selectStr = [NSString stringWithFormat:@"%ld-%@-%@", [self.year integerValue], month, day];
    }
   
    
    if (self.selectedBlock) {
        self.selectedBlock(self.selectStr);
    }
    [self close];
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource
/// UIPickerView返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

/// UIPickerView返回每组多少条数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [self.dataArray[component] count] * 1;
}

/// UIPickerView选择哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    NSInteger time_integerValue = [self.timeArr[component] integerValue];
    
    
    switch (component) {
        case 0: { // 年
            
            NSString *year_integerValue = self.yearArr[row%[self.dataArray[component] count]];
            
            //            if (year_integerValue.integerValue < time_integerValue) {
            //                [pickerView selectRow:[self.dataArray[component] indexOfObject:self.timeArr[component]] inComponent:component animated:YES];
            //            } else {
            self.year = year_integerValue;
            /// 刷新日
            [self refreshDay];
            /// 根据当前选择的年份和月份获取当月的天数
            NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            if (self.dayArr.count > [dayStr integerValue]) {
                if (self.day.integerValue > [dayStr integerValue]) {
                    [pickerView selectRow:[self.dataArray[2] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:2 animated:YES];
                    self.day = [dayStr stringByAppendingString:@"日"];
                }
            }
            //            }
        } break;
        case 1: { // 月
            
            NSString *month_value = self.monthArr[row%[self.dataArray[component] count]];
            
            self.month = month_value;
            /// 刷新日
            [self refreshDay];
            
            /// 根据当前选择的年份和月份获取当月的天数
            NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            if (self.dayArr.count > [dayStr integerValue]) {
                if (self.day.integerValue > [dayStr integerValue]) {
                    [pickerView selectRow:[self.dataArray[2] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:2 animated:YES];
                    self.day = [dayStr stringByAppendingString:@"日"];
                    
                }
            }
            // 如果选择年大于当前年 就直接赋值月
            //            if ([self.year integerValue] > [self.timeArr[0] integerValue]) {
            //
            //                self.month = month_value;
            //                /// 刷新日
            //                [self refreshDay];
            //
            //                /// 根据当前选择的年份和月份获取当月的天数
            //                NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            //                if (self.dayArr.count > [dayStr integerValue]) {
            //                    if (self.day.integerValue > [dayStr integerValue]) {
            //                        [pickerView selectRow:[self.dataArray[2] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:2 animated:YES];
            //                        self.day = [dayStr stringByAppendingString:@"日"];
            //
            //                    }
            //                }
            //                // 如果选择的年等于当前年，就判断月份
            //            } else if ([self.year integerValue] == [self.timeArr[0] integerValue]) {
            //                // 如果选择的月份小于当前月份 就刷新到当前月份
            //                if (month_value.integerValue < [self.timeArr[component] integerValue]) {
            //                    [pickerView selectRow:[self.dataArray[component] indexOfObject:[NSString stringWithFormat:@"%ld月", [self.timeArr[component] integerValue]]] inComponent:component animated:YES];
            //                    // 如果选择的月份大于当前月份，就直接赋值月份
            //                } else {
            //                    self.month = month_value;
            //                    /// 刷新日
            //                    [self refreshDay];
            //
            //                    /// 根据当前选择的年份和月份获取当月的天数
            //                    NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            //                    if (self.dayArr.count > dayStr.integerValue) {
            //                        if (self.day.integerValue > dayStr.integerValue) {
            //                            [pickerView selectRow:[self.dataArray[2] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:2 animated:YES];
            //                            self.day = [dayStr stringByAppendingString:@"日"];
            //                        }
            //                    }
            //                }
            //            }
        } break;
        case 2: { // 日
            /// 根据当前选择的年份和月份获取当月的天数
            NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            // 如果选择年大于当前年 就直接赋值日
            NSString *day_value = self.dayArr[row%[self.dataArray[component] count]];
            NSLog(@"%ld", self.dayArr.count);
            if (self.dayArr.count <= [dayStr integerValue]) {
                self.day = day_value;
            } else {
                if (day_value.integerValue <= [dayStr integerValue]) {
                    self.day = day_value;
                } else {
                    [pickerView selectRow:[self.dataArray[component] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:component animated:YES];
                }
            }
            //            if ([self.year integerValue] > [self.timeArr[0] integerValue]) {
            //                if (self.dayArr.count <= [dayStr integerValue]) {
            //                    self.day = day_value;
            //                } else {
            //                    if (day_value.integerValue <= [dayStr integerValue]) {
            //                        self.day = day_value;
            //                    } else {
            //                        [pickerView selectRow:[self.dataArray[component] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:component animated:YES];
            //                    }
            //                }
            //                // 如果选择的年等于当前年，就判断月份
            //            } else if ([self.year integerValue] == [self.timeArr[0] integerValue]) {
            //                // 如果选择的月份大于当前月份 就直接复制
            //                if ([self.month integerValue] > [self.timeArr[1] integerValue]) {
            //                    if (self.dayArr.count <= [dayStr integerValue]) {
            //                        self.day = day_value;
            //                    } else {
            //                        if (day_value.integerValue <= [dayStr integerValue]) {
            //                            self.day = day_value;
            //                        } else {
            //                            [pickerView selectRow:[self.dataArray[component] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:component animated:YES];
            //                        }
            //                    }
            //                    // 如果选择的月份等于当前月份，就判断日
            //                } else if ([self.month integerValue] == [self.timeArr[1] integerValue]) {
            //                    // 如果选择的日小于当前日，就刷新到当前日
            //                    if (day_value.integerValue < [self.timeArr[component] integerValue]) {
            //
            //                        [pickerView selectRow:[self.dataArray[component] indexOfObject:[NSString stringWithFormat:@"%ld日", time_integerValue]] inComponent:component animated:YES];
            //                        // 如果选择的日大于当前日，就复制日
            //                    } else {
            //                        if (self.dayArr.count <= [dayStr integerValue]) {
            //                            self.day = self.dayArr[row%[self.dataArray[component] count]];
            //                        } else {
            //                            if ([self.dayArr[row%[self.dataArray[component] count]] integerValue] <= [dayStr integerValue]) {
            //                                self.day = self.dayArr[row%[self.dataArray[component] count]];
            //                            } else {
            //                                [pickerView selectRow:[self.dataArray[component] indexOfObject:[dayStr stringByAppendingString:@"日"]] inComponent:component animated:YES];
            //                            }
            //                        }
            //                    }
            //                }
            //            }
        } break;
        case 3: { // 时
            self.hour = self.hourArr[row%[self.dataArray[component] count]];
            
            //            // 如果选择年大于当前年 就直接赋值时
            //            if ([self.year integerValue] > [self.timeArr[0] integerValue]) {
            //                self.hour = self.hourArr[row%[self.dataArray[component] count]];
            //                // 如果选择的年等于当前年，就判断月份
            //            } else if ([self.year integerValue] == [self.timeArr[0] integerValue]) {
            //                // 如果选择的月份大于当前月份 就直接复制时
            //                if ([self.month integerValue] > [self.timeArr[1] integerValue]) {
            //                    self.hour = self.hourArr[row%[self.dataArray[component] count]];
            //                    // 如果选择的月份等于当前月份，就判断日
            //                } else if ([self.month integerValue] == [self.timeArr[1] integerValue]) {
            //                    // 如果选择的日大于当前日，就直接复制时
            //                    if ([self.day integerValue] > [self.timeArr[2] integerValue]) {
            //                        self.hour = self.hourArr[row%[self.dataArray[component] count]];
            //                        // 如果选择的日等于当前日，就判断时
            //                    } else if ([self.day integerValue] == [self.timeArr[2] integerValue]) {
            //                        // 如果选择的时小于当前时，就刷新到当前时
            //                        if ([self.hourArr[row%[self.dataArray[component] count]] integerValue] < [self.timeArr[3] integerValue]) {
            //                            [pickerView selectRow:[self.dataArray[component] indexOfObject:self.timeArr[component]] inComponent:component animated:YES];
            //                            // 如果选择的时大于当前时，就直接赋值
            //                        } else {
            //                            self.hour = self.hourArr[row%[self.dataArray[component] count]];
            //                        }
            //                    }
            //                }
            //            }
        } break;
        case 4: { // 分
            // 如果选择年大于当前年 就直接赋值时
            //            if ([self.year integerValue] > [self.timeArr[0] integerValue]) {
//                        self.minute = self.minuteArr[row%[self.dataArray[component] count]];
            //                // 如果选择的年等于当前年，就判断月份
            //            } else if ([self.year integerValue] == [self.timeArr[0] integerValue]) {
            //                // 如果选择的月份大于当前月份 就直接复制时
            //                if ([self.month integerValue] > [self.timeArr[1] integerValue]) {
            //                    self.minute = self.minuteArr[row%[self.dataArray[component] count]];
            //                    // 如果选择的月份等于当前月份，就判断日
            //                } else if ([self.month integerValue] == [self.timeArr[1] integerValue]) {
            //                    // 如果选择的日大于当前日，就直接复制时
            //                    if ([self.day integerValue] > [self.timeArr[2] integerValue]) {
            //                        self.minute = self.minuteArr[row%[self.dataArray[component] count]];
            //                        // 如果选择的日等于当前日，就判断时
            //                    } else if ([self.day integerValue] == [self.timeArr[2] integerValue]) {
            //                        // 如果选择的时大于当前时，就直接赋值
            //                        if ([self.hour integerValue] > [self.timeArr[3] integerValue]) {
            //                            self.minute = self.minuteArr[row%[self.dataArray[component] count]];
            //                        // 如果选择的时等于当前时,就判断分
            //                        } else if ([self.hour integerValue] == [self.timeArr[3] integerValue]) {
            //                            // 如果选择的分小于当前分，就刷新分
            //                            if ([self.minuteArr[row%[self.dataArray[component] count]] integerValue] < [self.timeArr[4] integerValue]) {
            //                                [pickerView selectRow:[self.dataArray[component] indexOfObject:self.timeArr[component]] inComponent:component animated:YES];
            //                            // 如果选择分大于当前分，就直接赋值
            //                            } else {
            //                                self.minute = self.minuteArr[row%[self.dataArray[component] count]];
            //                            }
            //                        }
            //                    }
            //                }
            //            }
        } break;
        default: break;
    }
}

/// UIPickerView返回每一行数据
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [self.dataArray[component] objectAtIndex:row%[self.dataArray[component] count]];
}
/// UIPickerView返回每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
/// UIPickerView返回每一行的View
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    titleLbl.font = kLabelFontSize15;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = [self.dataArray[component] objectAtIndex:row%[self.dataArray[component] count]];
    
    //  设置横线的颜色，实现显示或者隐藏
    ((UILabel *)[pickerView.subviews objectAtIndex:1]).backgroundColor = kColorClearColor;
    
    ((UILabel *)[pickerView.subviews objectAtIndex:2]).backgroundColor = kColorClearColor;
    
    return titleLbl;
}


- (void)pickerViewLoaded:(NSInteger)component row:(NSInteger)row{
    NSUInteger max = 16384;
    NSUInteger base10 = (max/2)-(max/2)%row;
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % row + base10 inComponent:component animated:NO];
}


/// 获取年份
- (NSMutableArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
        for (int i = 1960; i < 2099; i ++) {
            [_yearArr addObject:[NSString stringWithFormat:@"%d年", i]];
        }
    }
    return _yearArr;
}

/// 获取月份
- (NSMutableArray *)monthArr {
    //    NSDate *today = [NSDate date];
    //    NSCalendar *c = [NSCalendar currentCalendar];
    //    NSRange days = [c rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:today];
    if (!_monthArr) {
        _monthArr = [NSMutableArray array];
        for (int i = 1; i <= 12; i ++) {
            [_monthArr addObject:[NSString stringWithFormat:@"%d月", i]];
        }
    }
    return _monthArr;
}

/// 获取当前月的天数
- (NSMutableArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSMutableArray array];
        for (int i = 1; i <= 31; i ++) {
            [_dayArr addObject:[NSString stringWithFormat:@"%d日", i]];
        }
    }
    return _dayArr;
}

/// 获取小时
- (NSMutableArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSMutableArray array];
        for (int i = 0; i < 24; i ++) {
            [_hourArr addObject:[NSString stringWithFormat:@"%d時", i]];
        }
    }
    return _hourArr;
}

/// 获取分钟
//- (NSMutableArray *)minuteArr {
//    if (!_minuteArr) {
//        _minuteArr = [NSMutableArray array];
//        for (int i = 0; i <= 55; i ++) {
//            if (i % 5 == 0) {
//                [_minuteArr addObject:[NSString stringWithFormat:@"%d分", i]];
//                continue;
//            }
//        }
//    }
//    return _minuteArr;
//}

// 获取当前的年月日时
- (NSArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [NSArray array];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年,MM月,dd日,HH時,mm分"];
        NSDate *date = [NSDate date];
        NSString *time = [formatter stringFromDate:date];
        _timeArr = [time componentsSeparatedByString:@","];
    }
    return _timeArr;
}

// 比较选择的时间是否小于当前时间
- (int)compareDate:(NSString *)date01 withDate:(NSString *)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy年,MM月,dd日,HH時,mm分"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result) {
            //date02比date01大
        case NSOrderedAscending: ci=1;break;
            //date02比date01小
        case NSOrderedDescending: ci=-1;break;
            //date02=date01
        case NSOrderedSame: ci=0;break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);break;
    }
    return ci;
}


- (void)refreshDay {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < [self getDayNumber:self.year.integerValue month:self.month.integerValue].integerValue + 1; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d日", i]];
    }
    
    [self.dataArray replaceObjectAtIndex:2 withObject:arr];
    [self.pickerView reloadComponent:2];
}

- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        return @"29";
    }
    return days[month - 1];
}

#pragma mark --property---
#pragma mark --property---
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = kColorWhiteColor;
        [_contentView addSubview:self.toolView];
        [_contentView addSubview:self.pickerView];
//        _contentView.frame = CGRectMake(0, kScreenHeigth, kScreenWidth , CGRectGetMaxY(self.pickerView.frame)+SafeAreaBottomHeight);
        _contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) , CGRectGetMaxY(self.pickerView.frame));
    }
    return _contentView;
}

- (UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.backgroundColor = kColorBABABA;
        _toolView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), WS(50));
        
        [_toolView addSubview:self.cancleBtn];
        [_toolView addSubview:self.confirmBtn];
        [_toolView addSubview:self.titleLbl];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [_toolView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_toolView.mas_bottom);
            make.left.mas_equalTo(_toolView.mas_left);
            make.width.mas_equalTo(_toolView);
            make.height.mas_equalTo(0.7);
        }];

        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_toolView).offset(WS(15));
            make.centerY.mas_equalTo(_toolView);
            make.size.mas_equalTo(CGSizeMake(WS(40), WS(30)));
        }];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_toolView).offset(-WS(15));
            make.centerY.mas_equalTo(_toolView);
            make.size.mas_equalTo(CGSizeMake(WS(40), WS(30)));
        }];
        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cancleBtn.mas_right);
            make.right.mas_equalTo(self.confirmBtn.mas_left);
            make.top.bottom.mas_equalTo(_toolView);
        }];
    }
    return _toolView;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, self.toolView.frame.size.height, CGRectGetWidth([UIScreen mainScreen].bounds), WS(180));
        _pickerView.backgroundColor = kColorClearColor;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = kLabelFontSize16;
//        _titleLbl.textColor = kColor2E332F;
    }
    return _titleLbl;
}


- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"取消"];
        NSRange allRange = {0,attribute.length};
        [attribute addAttributes:@{NSForegroundColorAttributeName:kColorBlueColor,
                                   NSFontAttributeName:kLabelFontSize16} range:allRange];
        [_cancleBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _cancleBtn;
}


- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"確定"];
        NSRange allRange = {0,attribute.length};
        [attribute addAttributes:@{NSForegroundColorAttributeName:kColorBlueColor,
                                   NSFontAttributeName:kLabelFontSize16} range:allRange];
        [_confirmBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _confirmBtn;
}



@end
