//
//  BaseViewFactory.h
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/15.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIImage+Handle.h"

@interface BaseViewFactory : NSObject

#pragma mark- 上传图片通用用样式
+(UIView *)creatImageUpLoadViewWithTitle:(NSString *)title withPlaceImageName:(NSString *)imageName withToIndexRemineTextColor:(NSInteger)index isShowLine:(BOOL)show finish:(void(^)(UIImageView * imageView,UILabel * titleLabel,UIView * lineView))finishBlock;

#pragma mark- title
+(UIView *)creatHeadViewWithTitle:(NSString *)title withLine:(BOOL)lineShow withTextColor:(UIColor *)color;

#pragma mark- label

/// label + 右图标
+(UIView *)creatViewWithTitle:(NSString *)title withRightImageName:(NSString *)imageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView *leftImageView, UILabel *label, UILabel *subLabel, UIImageView *rightImageView, UIView *lineView))finishBlock;
/**
 * 创建做图标 + 标题 + 内容Label + 右图标
 * @param leftImageName  做图标名称
 * @param title  标题
 * @param width  标题 宽长设置
 * @param rightImageName  右图标名称
 * @param height  视图高度
 * @param isShowLine  是否显示底线
 * @param finishBlock finishBlock 可以将需要控件挂上引用
 * return 创建做图标 + 标题 + 内容Label + 右图标
 */
+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UILabel * subLabel, UIImageView * rightImageView, UIView * lineView))finishBlock;

///普通left-label-right.+space，spacetoOther为若有leftimage，距离最左为两个space之和
+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine spaceToEdge:(CGFloat)edge andspaceToOther:(CGFloat)other finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UILabel * subLabel, UIImageView * rightImageView, UIView * lineView))finishBlock;
//终极label filllabel为最右label
+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withFillLabel:(NSString *)filltitle withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine spaceToEdge:(CGFloat)edge andspaceToOther:(CGFloat)other finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UILabel * subLabel, UIImageView * rightImageView, UIView * lineView))finishBlock;
#pragma mark- textField
/**
 * 左标题宽度不可设置TextField,默认左label宽度>80
 */
+(UIView *)creatTextFieldViewWithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder height:(CGFloat)height withLineShow:(BOOL)lineShow finishBlock:(void (^)(UILabel * label,UITextField * textField))finishBlock;
/**
 * @method 创建标题 + textField
 * @param  title 标题
 * @param  width 标题 宽长设置
 * @param  placeHolder textField的PlaceHolder
 * @param  height 视图高度
 * @param  lineShow 是否显示底线
 * @param  finishBlock 可以将需要控件挂上引用
 * @return 左标题宽度可设置TextField
 */
+(UIView *)creatTextFieldViewWithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder height:(CGFloat)height withLineShow:(BOOL)lineShow finishBlock:(void (^)(UILabel * label,UITextField * textField))finishBlock;

/// 创建做图标 + 标题 + 内容textField + 右图标
+(UIView *)creatTextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock;
/**
 * @method 最新总创建textField
 * @param  title 标题
 * @param  width 标题 宽长设置
 * @param  placeHolder textField的PlaceHolder
 * @param  height 视图高度
 * @param  isShowLine 是否显示底线
 * @param  finishBlock 可以将需要控件挂上引用
 * @return 可设置TextField的alignment
 */
+(UIView *)creatTextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder TextFieldwithTextAlignment:(NSTextAlignment)alignment  withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock;
///左label ，textfield 加了spaceToEdge spaceToother
+(UIView *)TextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder TextFieldwithTextAlignment:(NSTextAlignment)alignment  withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine WithSpaceToEdge:(CGFloat)spacetoedge SpaceToOther:(CGFloat)spacetoother finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock;

#pragma mark- button
/**
 创建按钮,不附加底部视图,frame:CGRectMake(0, 0, 230, 44)
 @param  title 标题
 @param  color 按钮背景图片颜色,默认app主题色 kColorTheme()
 @param  radius 按钮背景图片圆角
 @return 按钮
 */
+(UIButton *)creatButtonWithTitle:(NSString *)title withBackColor:(UIColor *)color withRadius:(CGFloat)radius;
/**
 * 创建按钮,附加底部视图,frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)
 * @param  title 标题
 * @param  color 按钮背景图片颜色,默认app主题色 kColorTheme()
 * @param  radius 按钮背景图片圆角
 * @param  finishBlock 将需要的控件挂起来
 * @return 按钮 + 背景
 */
+(UIView *)creatButtonViewWithTitle:(NSString *)title withBackColor:(UIColor *)color withRadius:(CGFloat)radius finishBlock:(void (^)(UIButton * button))finishBlock;
//创建只含image的按钮
+(UIButton *)creatDefaultButtonWithImage:(NSString*)imagename WithTarget:(id)target WithSEL:(SEL)selector;

#pragma mark- init
/// 初始化底部分割线
+(UIView *)creatLineViewWith:(CGFloat)height withColor:(UIColor *)color;
/// 初始化Label
+(UILabel *)creatDefaultLabelWithTitle:(NSString *)title;
/// 初始化TextField
+(UITextField *)creatDefaultTextFieldWithTitle:(NSString *)title WithPlaceHolder:(NSString *)placeHolder;
/// 初始化Button,和点击方法
+(UIButton *)creatDefaultButtonWithTitle:(NSString *)title WithTarget:(id)target WithSEL:(SEL)selector;
/// 初始化ImageView
+(UIImageView *)creatDefaultImageViewWithImageName:(NSString *)imageName;

#pragma mark-
/**
 添加便利约束,targetView视图添加在relationView下,左起点和宽度与relationView相等
 * @param  targetView 添加约束的视图
 * @param  relationView 相关约束视图
 * @param  height 自定义约束高度
 */
+(void)addMas_targetView:(UIView *)targetView relationVIew:(UIView *)relationView withHeight:(CGFloat)height;
/// 添加便利约束,targetView视图添加在relationView下,左起点和宽度与relationView相等,添加偏移量
+(void)addMas_targetView:(UIView *)targetView relationVIew:(UIView *)relationView withOffset:(CGFloat)offset withHeight:(CGFloat)height;
/// 添加便利约束,targetView视图添加在relationView下,top可设置,左起点和宽度与relationView相等,添加偏移量
+(void)addMas_targetView:(UIView *)targetView relationVIew:(UIView *)relationView withTop:(CGFloat)top withHeight:(CGFloat)height;

/// 添加点击手势
+(void)addTapGestureView:(UIView *)addGestureView WithTagert:(id)target withSEL:(SEL)selector;
//虚线
+(UIView *)addImaginaryLineWithFrame:(CGRect)frame lineColor:(UIColor *)color lineHeight:(float)height lineDashWidth:(NSNumber *)width lineDashSpace:(NSNumber *)space;

@end
