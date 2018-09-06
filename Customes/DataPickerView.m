//
//  DataPickerView.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/25.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "DataPickerView.h"

NSString * const kNoneDataPick = @"无数据选择";

@interface DataPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)BaseMaskWindow *m_window;

@property(nonatomic,strong)UIView *contentView;

@property (strong, nonatomic) UIView *toolView; // 工具条
@property (strong, nonatomic) UILabel *titleLbl; // 标题
//@property (nonatomic, strong) UIButton *cancleBtn;// 取消按钮
//@property (nonatomic, strong) UIButton *confirmBtn; // 确认按钮

@property (strong, nonatomic) UIPickerView *pickerView; // 选择器

//@property (copy, nonatomic) NSString *selectStr; //当前选中的标题
@property (nonatomic, strong) NSMutableArray * selectArray;

@end

@implementation DataPickerView

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.m_window = [BaseMaskWindow shareMaskWindow];
        self.frame = self.m_window.bounds;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLbl.text = title;
}

- (void)show {
    if (self.dataArray.count<=0) {
        [ToastTool showInfoWithStatus:kNoneDataPick];
        return;
    }
    self.selectArray = [NSMutableArray arrayWithCapacity:5];
    for (NSArray * subArray in self.dataArray) {
        NSString * subString = [subArray firstObject];
        subString = subString?:@"";
        [self.selectArray addObject:subString];
    }
    
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
        [_m_window dismiss];
        [self removeFromSuperview];
    }];
}

#pragma mark - 点击方法
/// 保存按钮点击方法
- (void)saveBtnClick {
    NSLog(@"点击了保存");
    if (self.selectedBlock) {
        self.selectedBlock(self.selectArray.copy);
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
    /// component 列
    /// row 行
    NSArray * subArray = self.dataArray[component];
    NSString * selectString = subArray[row];
    [self.selectArray replaceObjectAtIndex:component withObject:selectString];

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
    titleLbl.font = [UIFont systemFontOfSize:15];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = [self.dataArray[component] objectAtIndex:row%[self.dataArray[component] count]];
    
    NSString * unit = @"";
    if (component < self.units.count) {
        unit = self.units[component]?:@"";
        titleLbl.text = [NSString stringWithFormat:@"%@%@",titleLbl.text,unit];
    }
    
    
    //  设置横线的颜色，实现显示或者隐藏
    ((UILabel *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    
    ((UILabel *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    
    return titleLbl;
}


- (void)pickerViewLoaded:(NSInteger)component row:(NSInteger)row{
    NSUInteger max = 16384;
    NSUInteger base10 = (max/2)-(max/2)%row;
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % row + base10 inComponent:component animated:NO];
}


#pragma mark --property---
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:self.toolView];
        [_contentView addSubview:self.pickerView];
        _contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) , CGRectGetMaxY(self.pickerView.frame));
    }
    return _contentView;
}

- (UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        _toolView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 50);
        
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
            make.left.mas_equalTo(_toolView).offset(15);
            make.centerY.mas_equalTo(_toolView);
            make.size.mas_equalTo(CGSizeMake(40, 30));
        }];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_toolView).offset(-15);
            make.centerY.mas_equalTo(_toolView);
            make.size.mas_equalTo(CGSizeMake(40, 30));
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
        _pickerView.frame = CGRectMake(0, self.toolView.frame.size.height, CGRectGetWidth([UIScreen mainScreen].bounds), 180);
        _pickerView.backgroundColor = [UIColor whiteColor];
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
        _titleLbl.font = [UIFont systemFontOfSize:16];
        //        _titleLbl.textColor = kColor2E332F;
    }
    return _titleLbl;
}


- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"取消"];
        NSRange allRange = {0,attribute.length};
        [attribute addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:16]} range:allRange];
        [_cancleBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _cancleBtn;
}


- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"确定"];
        NSRange allRange = {0,attribute.length};
        [attribute addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:16]} range:allRange];
        [_confirmBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _confirmBtn;
}


@end
