//  UIView frame相关分类

#import <UIKit/UIKit.h>
#import "UIInitTool.h"

@interface UIView (Layout)

/// 所在控制器
@property (nonatomic,weak,readonly) UIViewController* viewController;

/// 宽
@property (nonatomic,assign) CGFloat width;

/// 高
@property (nonatomic,assign) CGFloat height;

/// X坐标
@property (nonatomic,assign) CGFloat x;

/// Y坐标
@property (nonatomic,assign) CGFloat y;

/// 尺寸
@property (nonatomic,assign) CGSize size;

/// 坐标
@property (nonatomic,assign) CGPoint origin;

/// 在X轴的最大值
@property (assign,nonatomic,readonly) CGFloat maxX;

/// 在Y轴的最大值
@property (assign,nonatomic,readonly) CGFloat maxY;

/// 在X轴的中心值
@property (assign,nonatomic,readonly) CGFloat centerX;

/// 在Y轴的中心值
@property (assign,nonatomic,readonly) CGFloat centerY;

#pragma mark - layout

/**
 设置缩进
 */
- (void)setEdgeInsets:(UIEdgeInsets)edge;

/**
 设置x坐标
 */
- (void)setLeft:(CGFloat)left;

/**
 设置y坐标
 */
- (void)setTop:(CGFloat)top;

/**
 高度等于view的高度
 */
- (void)heightEqualToView:(UIView *)view;

/**
 宽度等于view的宽度
 */
- (void)widthEqualToView:(UIView *)view;

/**
 设置指定屏幕类型下的尺寸
 */
- (void)setSize:(CGSize)size screenType:(UIScreenType)screenType;


- (void)sizeEqualToView:(UIView *)view;

- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)centerXEqualToView:(UIView *)view;
- (void)centerYEqualToView:(UIView *)view;
- (void)centerEqualToView:(UIView *)view;

- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view;
- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view;
- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view;
- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view;

- (void)fromTheRelativeTop:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)fromTheRelativeBottom:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)fromTheRelativeLeft:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)fromTheRelativeRight:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;

- (void)relativeTopInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)relativeBottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)relativeLeftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)relativeRightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

- (void)top:(CGFloat)top FromView:(UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
- (void)left:(CGFloat)left FromView:(UIView *)view;
- (void)right:(CGFloat)right FromView:(UIView *)view;

- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType;

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

- (void)topEqualToView:(UIView *)view;
- (void)bottomEqualToView:(UIView *)view;
- (void)leftEqualToView:(UIView *)view;
- (void)rightEqualToView:(UIView *)view;

- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

@end
