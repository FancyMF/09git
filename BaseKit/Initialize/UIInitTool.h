//
//  UIInitTool.h
//  UI控件初始化工具

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "NSString+Handle.h"

/// 屏幕类型
typedef CGFloat UIScreenType;
static UIScreenType UIScreenTypeIPhone5 = 320.0f;  // 4s、5、5c、5s、SE
static UIScreenType UIScreenTypeIPhone6 = 375.0f;  // 6、6s、7、7s
static UIScreenType UIScreenTypeIPhone6P = 414.0f; // 6P、7P

@interface UIInitTool : NSObject

#pragma mark - Uninversal Const
/// 每行的高度
CGFloat kRowHeight(void);
/// view 与 view 之间的间距
CGFloat kButtonDefaultHeight(void);
CGFloat kButtonWithBGViewDefaultHeight(void);
CGFloat kLineDefaultHeight(void);
CGFloat kSpaceToTop(void);
CGFloat kSpaceBetween(void);
CGFloat kSpaceToLeft(void);

#pragma mark - UIScreen

/// 屏幕常规宽度
CGFloat kNormalScreenWidth(void);

/// 屏幕常规高度
CGFloat kNormalScreenHeight(void);

/// 是否是横屏模式
bool isLandscape(void);

/// 屏幕宽度
CGFloat kScreenWidth(void);

/// 屏幕总高度
CGFloat kAllHeight(void);

/// 屏幕高度 -（状态栏和导航栏）
CGFloat kScreenHeight(void);

CGFloat kSafeAreaBottomHeight(void);

CGFloat kStatusBarHeight(void);

/// 屏幕与指定屏幕的比例
CGFloat kScreenScale(UIScreenType screenType);

#pragma mark - UIColor

/**
 带透明度的颜色
 @param ace_r 红色值 0~255
 @param ace_g 绿色值 0~255
 @param ace_b 蓝色值 0~255
 @param ace_alpha 透明度 0~1
 */
UIColor* kColor(int ace_r ,int ace_g ,int ace_b ,float ace_alpha);

/**
 16进制颜色
 @param rgbValue 16进制的颜色值
 */
UIColor* kColorValue(int rgbValue);

/**
 16进制颜色带透明度
 @param rgbValue 16进制的颜色值
 @param alphaValue 透明度 0~1
 */
UIColor* kColorValueAlpha(int rgbValue,float alphaValue);

UIColor* kSystemColorWhite(void);
UIColor* kColorWhite(void);
UIColor* kSystemColorBlue(void);

UIColor* kColorBackground(void);  //默认背景色
UIColor* kColorTheme(void);  //主题色
UIColor* kColorUnable(void); //按钮不能点击颜色
UIColor* kColorLine(void);  //线条颜色
UIColor* kColorBorder(void);  // 边框颜色
UIColor* kColorError(void);  //错误色

UIColor* kColorTextTheme(void);  //主题字体颜色
UIColor* kColorTextDefault(void);  //默认字体颜色
UIColor* kColorTextLightGray(void);  //浅色字体颜色
UIColor* kColorTextLight(void);  //自己浅色




//UIColor* kHllColorError(void);
//UIColor* kHllColorOrangeDark(void);
//UIColor* kHllColorOrangeShallow(void);
//UIColor* kHllColorGreen(void);
//UIColor* kHllColorBackground(void);
//UIColor* kHllColorBlackDark(void);
//UIColor* kHllColorBlackMiddle(void);
//UIColor* kHllColorBlackShallow(void);
//UIColor* kHllColorSepatator(void);
//UIColor* kHllColorBorder(void);
//UIColor* kHllColorMask(void);
//UIColor* kHllColorTranslucence(void);

#pragma mark - UIFont

/**
 默认字体
 @param size 尺寸
 */
UIFont* kFontSize(float size);

/**
 默认粗体
 @param size 尺寸
 */
UIFont* kFontBodySize(float size);

// 系统默认字体
UIFont* kFontSysterm20(void);
UIFont* kFontSysterm16(void);
UIFont* kFontSysterm14(void);
UIFont* kFontSysterm12(void);

/**
 根据名称和尺寸返回字体
 @param name 字体名
 @param size 尺寸
 */
UIFont* kFontWithNameAndSize(NSString* name, float size);
/// 幼体16
UIFont* kFontLight16(void);
/// 幼体14
UIFont* kFontLight14(void);
/// 幼体12
UIFont* kFontLight12(void);
/// 超幼体12
UIFont* kFontThin12(void);

#pragma mark - UIView
UIImage * kImageName(NSString * imageName);
NSURL * kURL(NSString * urlString);

#pragma mark - UIView

+ (UIView*)viewWithFrame:(CGRect)frame andBackgroundColor:(UIColor*)backgroundColor toSuperV:(UIView*)superV;

+ (UILabel*)labelWithFrame:(CGRect)frame text:(NSString*)text textAlignMent:(NSTextAlignment)textAlignMent font:(UIFont*)font textColor:(UIColor*)textColor fitSize:(BOOL)fit toSuperV:(UIView*)superV;

/// 导航栏右侧默认格式按钮 - 标题
+ (UIButton *)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(int)tag;

/// 导航栏右侧默认格式按钮 - 图片
+ (UIButton *)rightItemWithImage:(NSString *)imageName target:(id)target action:(SEL)action tag:(int)tag;

+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title font:(UIFont*)font textColor:(UIColor*)textColor tag:(NSInteger)tag target:(id)target action:(SEL)action superView:(UIView*)superV;

/**
 *  初始化带标题的UISegmentedControl
 *
 *  @param superV        父视图
 *  @param target        代理
 *  @param action        点击事件
 *  @param frame         frame
 *  @param titles        标题数组
 *  @param tintColor     主色调
 *  @param normalColor   正常状态文字颜色
 *  @param selectedColor 选中状态文字颜色
 *  @param font          字体
 *
 *  @return UISegmentedControl
 */
+ (UISegmentedControl*)segmentedControlWithSuperView:(UIView*)superV target:(NSObject*)target action:(SEL)action frame:(CGRect)frame titles:(NSArray*)titles tintColor:(UIColor*)tintColor normalTextColor:(UIColor*)normalColor selectedTextColor:(UIColor*)selectedColor font:(UIFont*)font;

+ (UITableView *)tableViewWithFrame:(CGRect)frame backgroundColor:(UIColor*)backColor style:(UITableViewStyle)style speratorStyle:(UITableViewCellSeparatorStyle)spetatorStyle dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate superView:(UIView *)superV;

+ (UITextField*)textFieldWithFrame:(CGRect)frame delegate:(id)delegate font:(UIFont*)font textAlignMent:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor returnType:(UIReturnKeyType)returnKeyType clearMode:(UITextFieldViewMode)clearBtnMode placeHolder:(NSString*)placeHolder superView:(UIView*)superV;


+ (UITextView*)textViewWithFrame:(CGRect)frame delegate:(id)delegate borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)radius font:(UIFont*)font textAlignMent:(NSTextAlignment)textAlignment borderColor:(UIColor *)borderColor  textColor:(UIColor *)textColor;

+ (UIProgressView*)ProgressViewWithFrame:(CGRect)frame style:(UIProgressViewStyle)style backColor:(UIColor*)backColor progressColor:(UIColor*)progressColor value:(CGFloat)value;

+ (UIActivityIndicatorView*)activityIndicatorViewWithFrame:(CGRect)frame backColor:(UIColor*)backColor styleColor:(UIColor*)styleColor style:(UIActivityIndicatorViewStyle)style;

+ (UISearchBar*)searchBarWithStyle:(UISearchBarStyle)style frame:(CGRect)frame delegate:(id)delegate placeholder:(NSString*)placeholder tintColor:(UIColor*)tintColor barTintColor:(UIColor*)barTintColor backImage:(UIImage*)backImage;

+ (UISegmentedControl*)segmentedControlWithTintColor:(UIColor*)tintColor titles:(NSArray<NSString*> *)titles frame:(CGRect)frame target:(id)target action:(SEL)action selectedIndex:(NSInteger)selectedIndex;

@end
