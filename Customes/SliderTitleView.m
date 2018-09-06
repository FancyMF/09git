//
//  ESSliderTitleView.m
//  一个滑动标题栏
//
//  Created by chenpeihang on 16/12/16.
//  Copyright © 2016年 广东亿迅科技有限公司. All rights reserved.
//

#import "SliderTitleView.h"
#import "UIImage+Handle.h"

#define ButtonTag 1000

#define unselectTitleColor self.unselectColor?self.unselectColor:[UIColor grayColor]
#define selectTitleColor self.selectColor?self.selectColor:[UIColor orangeColor]

#define unselectDefaultImage self.unselectImage?self.unselectImage:nil
#define selectDefaultImage self.selectIamge?self.selectIamge:nil

static NSString const * TitleKey = @"title";

@interface SliderTitleView ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) BOOL isSlider;

@property (nonatomic, strong) UIScrollView * backScrollView;
@property (nonatomic, strong) UIView * rootView;

@property (nonatomic, strong) UIButton * currentButton;
@property (nonatomic, strong) NSMutableArray * buttonArray;

@property (nonatomic, strong) UIImageView * bottomImageView;


@end

@implementation SliderTitleView

// bounds 发生变化时调用
-(void)layoutSubviews{
    
    
//#define unselectDefaultImage self.unselectImage?self.unselectImage:[UIImage createImageWithColor:[UIColor colorWithWhite:0.9 alpha:0.6] frame:CGRectMake(0, 0, 10, 10)]
//#define selectDefaultImage self.selectIamge?self.selectIamge:[UIImage createImageWithColor:[UIColor colorWithWhite:0.9 alpha:1] frame:CGRectMake(0, 0, 10, 10)]
    
}

-(UIView *)setViewWithTitleArray:(NSArray *)array{
    
    if (array.count<=0||array==nil||[array isKindOfClass:[NSNull class]]) {
        return self;
    }
    self.dataArray = array;
    
    [self setIsNeedScrollView];
    
    [self creatButtonArray:array];
    return self;
}

-(void)setIsNeedScrollView{
    // 按钮的宽度
    _eachWidth = _eachWidth?_eachWidth:self.width/self.dataArray.count;
    if (_eachWidth <= 30) {
        _eachWidth = 30;
    }
    
    // 设置 self.backScrollView 是否可滑动
    if (self.eachWidth*self.dataArray.count+self.space*(self.dataArray.count-1)>self.width) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.backScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            self.backScrollView.backgroundColor = [UIColor clearColor];
            self.backScrollView.showsVerticalScrollIndicator = NO;
            self.backScrollView.showsHorizontalScrollIndicator = NO;
            self.backScrollView.scrollEnabled = NO;
            [self addSubview:self.backScrollView];
            self.rootView = self.backScrollView;
        });
        self.backScrollView.scrollEnabled = YES;
        self.backScrollView.contentSize = CGSizeMake(self.eachWidth*self.dataArray.count+self.space*(self.dataArray.count-1), 0);
    }else{
        self.rootView = self;
        self.backScrollView.scrollEnabled = NO;
        self.backScrollView.contentSize = CGSizeMake(0, 0);
    }
    
    if (_roundBG) {
        self.rootView.layer.cornerRadius = CGRectGetHeight(self.rootView.frame)/2;
        self.rootView.layer.masksToBounds = YES;
    }else{
        self.rootView.layer.cornerRadius = 0;
        self.rootView.layer.masksToBounds = NO;
    }
    
    self.rootView.backgroundColor = _colorBG?_colorBG:[UIColor clearColor];
}



-(void)creatButtonArray:(NSArray *)array{
    
    if (!array || array.count <= 0) {
        return;
    }
    [self.buttonArray removeAllObjects];
    [self.rootView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat orignalX = 0;
    orignalX = self.eachWidth * array.count + self.space*(self.dataArray.count-1) <= self.width ? (self.width - self.eachWidth * array.count - self.space*(self.dataArray.count-1)) / 2:0;
    
    for (int i = 0; i < array.count; i++) {
        
        UIButton * button = [[UIButton alloc] init];
        button.frame = CGRectMake(orignalX+_space*i, 0, self.eachWidth, self.height);
        button.layer.cornerRadius = self.roundBG?self.height/2:0;
        button.layer.masksToBounds = YES;
        button.tag = ButtonTag + i;
        [self setButtonTitleWithArrayOfIndex:array[i] withButton:button];
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = self.titleFont?self.titleFont:[UIFont systemFontOfSize:15];
        
        [button setTitleColor:unselectTitleColor forState:UIControlStateNormal];
        [button setTitleColor:selectTitleColor forState:UIControlStateSelected];
        
        [button setBackgroundImage:unselectDefaultImage forState:UIControlStateNormal];
        [button setBackgroundImage:selectDefaultImage forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
        
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!self.DefaultSlectIndex) {
            self.DefaultSlectIndex = 0;
        }
        if (self.DefaultSlectIndex >=array.count || self.DefaultSlectIndex < 0 ) {
            self.DefaultSlectIndex = 0;
        }
        if (self.DefaultSlectIndex == i) {
            [button setTitleColor:selectTitleColor forState:UIControlStateNormal];
            [button setBackgroundImage:selectDefaultImage forState:UIControlStateNormal];
        }
        [self.buttonArray addObject:button];
        [self.rootView addSubview:button];
        
        orignalX += self.eachWidth;
    }
    
//    if (!self.selectIamge || [selectDefaultImage isKindOfClass:[NSNull class]]) {
    if (self.isBottomImage) {
        UIButton * button = [self.rootView viewWithTag:self.DefaultSlectIndex + ButtonTag];
        [button.titleLabel sizeToFit];
        CGFloat lineWidth = button.titleLabel.frame.size.width;
        self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, 2.5)];
        self.bottomImageView.backgroundColor = selectTitleColor;
        
        self.bottomImageView.center = CGPointMake(button.frame.origin.x + self.eachWidth / 2, self.height - 2.5 / 2);
        [self.rootView addSubview:self.bottomImageView];
    }
}

-(void)setButtonTitleWithArrayOfIndex:(id)object withButton:(UIButton *)render{
    if ([object isKindOfClass:[NSString class]]) {
        [render setTitle:object forState:UIControlStateNormal];
    }else if ([object isKindOfClass:[NSDictionary class]]){
        [render setTitle:object[TitleKey]?object[TitleKey]:[NSString stringWithFormat:@"%ld",(render.tag - ButtonTag)] forState:UIControlStateNormal];
    }else{
        return;
    }
}


#pragma mark- action
-(void)selectButtonOfIndex:(NSInteger)index{
    if (index>self.rootView.subviews.count) {
        index=self.rootView.subviews.count-1;
    }else if (index<0){
        index = 0;
    }
    UIButton * render = [self.rootView viewWithTag:(ButtonTag + index)];
    [self selectedButton:render];
    
}

-(void)selectedButton:(UIButton *)render{
    
    if (self.buttonArray.count <= 0) {
        return;
    }
    
//    if ([self.currentButton isEqual:render]) {
//        return;
//    }
    self.currentButton = render;
    
    // 更换图片
    for (int i = 0; i < self.self.buttonArray.count; i++) {
        UIButton * button = self.buttonArray[i];
        if ([self.buttonArray[i] isEqual:render]) {
            [button setTitleColor:selectTitleColor forState:UIControlStateNormal];
            [button setBackgroundImage:selectDefaultImage forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                CGFloat lineWidth = button.titleLabel.frame.size.width;
                self.bottomImageView.frame =CGRectMake(0, 0, lineWidth, 2.5);
                self.bottomImageView.center = CGPointMake(render.frame.origin.x + 0.5 * self.eachWidth, self.height - 2.5 / 2);
                
            } completion:^(BOOL finished) {
                
            }];
        }else{
            [button setTitleColor:unselectTitleColor forState:UIControlStateNormal];
            [button setBackgroundImage:unselectDefaultImage forState:UIControlStateNormal];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SliderTitleViewSelectButtonIndex:withDataArray:)]) {
        [self.delegate SliderTitleViewSelectButtonIndex:(render.tag - ButtonTag) withDataArray:self.dataArray];
    }
    
    // 编写点击移动scrollView
    if ([self.rootView isEqual:self.backScrollView] && self.backScrollView .scrollEnabled == YES) {
        // 判断 scrollView 的偏移量与点击按钮的关系
        NSLog(@"%f",self.width);
        NSLog(@"render.frame:%@", NSStringFromCGRect(render.frame));
        NSLog(@"self.backScrollView.contentOffset.x:%f",self.backScrollView.contentOffset.x);
        if (self.backScrollView.contentOffset.x + self.width < CGRectGetMaxX(render.frame)){
            if (render.tag - ButtonTag == self.dataArray.count - 1) {
                [self.backScrollView setContentOffset:CGPointMake(CGRectGetMaxX(render.frame) - self.width, 0) animated:YES];
            }else{
                [self.backScrollView setContentOffset:CGPointMake(CGRectGetMaxX(render.frame) - self.width + render.frame.size.width / 2, 0) animated:YES];
            }
            
        }else if (self.backScrollView.contentOffset.x > render.frame.origin.x){
            if (render.tag - ButtonTag == 0) {
                [self.backScrollView setContentOffset:CGPointMake(render.frame.origin.x, 0) animated:YES];
            }else{
                [self.backScrollView setContentOffset:CGPointMake(render.frame.origin.x - render.frame.size.width / 2, 0) animated:YES];
            }
            
        }
    }
    
}

#pragma mark- setter方法
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (frame.size.width == 0 && frame.size.height == 0) {
        return;
    }
    self.width = frame.size.width;
    self.height = frame.size.height;
    self.backgroundColor = [UIColor clearColor];
    
    self.buttonArray = [[NSMutableArray alloc] init];
    self.isBottomImage = YES;
    self.rootView = self;
}

// 设置 默认点击按钮
-(void)setDefaultSlectIndex:(NSInteger)DefaultSlectIndex{
    if (!DefaultSlectIndex) {
        return;
    }
    _DefaultSlectIndex = DefaultSlectIndex;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    if (DefaultSlectIndex < 0) {
        _DefaultSlectIndex = 0;
    }else if(DefaultSlectIndex >= self.dataArray.count) {
        _DefaultSlectIndex = self.dataArray.count - 1;
    }
    [self selectedButton:[self.rootView viewWithTag:self.DefaultSlectIndex + ButtonTag]];
    
}


-(void)setTitleFont:(UIFont *)titleFont{
    if (!titleFont) {
        return;
    }
    _titleFont = titleFont;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self creatButtonArray:self.dataArray];
}

-(void)setUnselectColor:(UIColor *)unselectColor{
    if (!unselectColor) {
        return;
    }
    _unselectColor = unselectColor;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self creatButtonArray:self.dataArray];
    
}

-(void)setSelectColor:(UIColor *)selectColor{
    if (!selectColor) {
        return;
    }
    _selectColor = selectColor;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self creatButtonArray:self.dataArray];
}

-(void)setSelectIamge:(UIImage *)selectIamge{
    if (!selectIamge) {
        return;
    }
    _selectIamge = selectIamge;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self creatButtonArray:self.dataArray];
}

-(void)setUnselectImage:(UIImage *)unselectImage{
    if (!unselectImage) {
        return;
    }
    _unselectImage = unselectImage;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self creatButtonArray:self.dataArray];
}

-(void)setIsBottomImage:(BOOL)isBottomImage{
    _isBottomImage = isBottomImage;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self creatButtonArray:self.dataArray];
}

-(void)setEachWidth:(CGFloat)eachWidth{
    _eachWidth = eachWidth;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self setIsNeedScrollView];
    [self creatButtonArray:self.dataArray];
}

-(void)setSpace:(CGFloat)space{
    _space = space;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self setIsNeedScrollView];
    [self creatButtonArray:self.dataArray];
    
}

//-(void)setBackgroundColor:(UIColor *)backgroundColor{
//    
//}

-(void)setRoundBG:(BOOL)roundBG{
    _roundBG = roundBG;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    [self setIsNeedScrollView];
    if (_roundBG) {
        self.rootView.layer.cornerRadius = CGRectGetHeight(self.rootView.frame)/2;
        self.rootView.layer.masksToBounds = YES;
    }else{
        self.rootView.layer.cornerRadius = 0;
        self.rootView.layer.masksToBounds = NO;
    }
    [self creatButtonArray:self.dataArray];
}

-(void)setColorBG:(UIColor *)colorBG{
    _colorBG = colorBG;
    if (!self.buttonArray || self.buttonArray.count <= 0) {
        return;
    }
    self.rootView.backgroundColor = _colorBG;
}



@end
