//
//  ProgressRateView.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/18.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "ProgressRateView.h"

static NSString* const kStepOneTitle = @"第一步";
static NSString* const kStepTwoTitle = @"第二步";
static NSString* const kStepThreeTitle = @"第三步";
static NSString* const kStepLastTitle = @"最后一步";

static NSString* const kStepOneTitle1 = @"1/4步";
static NSString* const kStepTwoTitle1 = @"2/4步";
static NSString* const kStepThreeTitle1 = @"3/4步";
static NSString* const kStepLastTitle1 = @"4/4步";

static NSString* const kStepOneTitle2 = @"1/2步";
static NSString* const kStepTwoTitle2 = @"2/2步";

@interface ProgressRateView ()

@property (nonatomic, strong) UIView * processView;
@property (nonatomic, strong) UIView * processIndexView;
@property (nonatomic, strong) UIButton * stepButton;

@end

@implementation ProgressRateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
        self.backgroundColor = [UIColor whiteColor];
        
        self.processView = [[UIView alloc] init];
        self.processView.backgroundColor = kColorValue(0xeeeeee);
        [self addSubview:self.processView];
        
        self.processIndexView = [[UIView alloc] init];
        self.processIndexView.backgroundColor = kColorValue(0x54aff1);
        [self addSubview:self.processIndexView];
        
        self.stepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.stepButton setBackgroundImage:[UIImage imageNamed:@"step_bg"] forState:UIControlStateNormal];
        self.stepButton.titleLabel.font = kFontSize(12);
        self.stepButton.titleEdgeInsets = UIEdgeInsetsMake(3.5, 0, 0, 0);
        self.stepButton.userInteractionEnabled = NO;
        [self addSubview:self.stepButton];
        
        [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(5);
        }];
        
        [self.processIndexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(5);
        }];
        
        [self.stepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.processView.mas_bottom).offset(1);
            make.left.mas_offset(-100);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(21);
        }];
        
    }
    return self;
}

-(void)resetUI{
    if (self.items.count<=0) {
        return;
    }
    self.index = MIN(self.items.count-1, self.index);
    self.index = MAX(0, self.index);
    [self.stepButton setTitle:self.items[self.index] forState:UIControlStateNormal];
    
    CGFloat width = kScreenWidth() / (self.items.count+1);
    width = width * (self.index + 1);
    
    [self.processIndexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.processView);
        make.left.equalTo(self.processView);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(5);
    }];
    
    [self.stepButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.processView.mas_bottom).offset(1);
        make.right.equalTo(self.processIndexView.mas_right).offset(12);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(21);
    }];
}

/// 用于设置默认数组1
+(NSArray <NSString *> *)defaultArray{
    return @[
             kStepOneTitle,
             kStepTwoTitle,
             kStepThreeTitle,
             kStepLastTitle,
             ];
}

/// 用于设置默认数组2
+(NSArray <NSString *> *)defaultArray2{
    return @[
             kStepOneTitle1,
             kStepTwoTitle1,
             kStepThreeTitle1,
             kStepLastTitle1,
             ];
}

/// 用于设置默认数组3
+(NSArray <NSString *> *)defaultArray3{
    return @[
             kStepOneTitle2,
             kStepTwoTitle2,
             ];
}

@end
