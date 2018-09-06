//
//  UIImage+Handle.m
//  UIImage的处理分类

#import <UIKit/UIKit.h>

@interface UIImage (Handle)

/**
 *  返回一张纯色片可以圆角的图片
 *
 *  @param color            指定的颜色
 *  @param cornerRadius     指定的圆角数据
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 绘制纯色图片

 @param color 颜色
 @param size  尺寸

 @return 图片实例
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;


/**
 给图片加上一层纯色背景

 @param color 背景色

 @return 图片实例
 */
- (UIImage *)colorImageWithColor:(UIColor *)color;

/**
 图片剪圆角
 
 @param cornerRadius 修剪半径
 
 @return 图片实例
 */
- (UIImage *)circleImageWithCornerRadius:(CGFloat)cornerRadius;

/**
 给图片加上一层纯色背景

 @param name  图片名
 @param color 背景色

 @return 图片实例
 */
+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;

/// 修剪图片
- (UIImage *)cropImageInRect:(CGRect )rect;


/**
 等比例缩放图片

 @param width 缩放后的图片宽度

 @return 图片实例
 */
- (UIImage *)resizeImageToWidth:(float )width;


/**
 *  添加一个蒙板
 *
 *  @param maskColor 蒙板颜色
 *
 *  @return 添加蒙板后的图片
 */
- (UIImage *)maskImageWithColor:(UIColor*)maskColor;

/**
 *  添加一个蒙板
 *
 *  @param maskImage 蒙版
 *
 *  @return 添加蒙板后的图片
 */
- (UIImage *)maskImageWithMask:(UIImage *)maskImage;

/**
 *  返回旋转任意角度的图片
 *
 *  @param degree 期望旋转的角度，顺时针
 *
 *  @return 旋转后的图片
 */
- (UIImage*)rotateImageWithDegree:(CGFloat)degree;

/**
 *  返回旋转90度的倍数的图片
 *
 *  @param count 倍数
 *
 *  @return 旋转后的图片
 */
- (UIImage*)rotateImageWithRightAndle:(NSUInteger)count;

/**
 多张图片合成一张
 
 @param images 图片数组
 @param isHorizontal 是否是水平方向拼接
 @return 目标图片
 */
+ (UIImage*)imageForImages:(NSArray<UIImage*>*)images andHorizontal:(BOOL)isHorizontal;

@end
