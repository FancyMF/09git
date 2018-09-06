//
//  NSString+AceTool.h
//  NSString分类，添加一些字符串处理方法、正则匹配

#import <UIKit/UIKit.h>

@interface NSString (Handle)


/// SHA256加密
- (NSString *)SHA256;

#pragma mark - reverse

/**
 当前字符串的倒序字符串

 @return 倒序字符串
 */
- (NSString*)reverseString;

#pragma mark - Encoding / Decoding

/**
 *  对字符串进行UTF8编码（包括特殊字符和汉字）
 *
 *  @return UTF8编码后的字符串
 */
- (NSString *)UTF8EncodingString;

+ (NSString *)encodingString:(NSString*)targetString withType:(CFStringEncoding)type;

/**
 *  对字符串进行UTF8解码
 *
 *  @return UTF8解码后的字符串
 */
- (NSString *)UTF8DecodingString;

+ (NSString *)decodingString:(NSString*)targetString withType:(CFStringEncoding)type;

#pragma mark - json
/**
 *  把空串变成符合json规范的空串 nil/Null/@""  ->  @"\"\""
 *
 *  @return @"\"\""
 */
+ (NSString *)nullToEmpty:(NSString*)string;

+ (NSString*)jsonStringFromArray:(NSArray*)array;

+ (NSString*)jsonStringFromDictionary:(NSDictionary*)dic;

#pragma mark - timeInteval -> dateString

+ (NSString*)dateStringForTimeInterval:(NSTimeInterval)timeInterval;

+ (NSString*)dateStringForTimeInterval:(NSTimeInterval)timeInterval format:(NSString*)formatter;

#pragma mark - Quary

/**
 *  模糊匹配
 *
 *  @param subString 需要匹配的字符串
 *
 *  @return 是否匹配
 */
- (BOOL)containString:(NSString *)subString;

/// 是否Null
+ (BOOL)isNull:(NSString*)string;

/// 是否空串
+ (BOOL)isEmpty:(NSString*)string;

#pragma mark - Replace
/// 去掉空格
- (NSString *)stringBySpaceTrim;
/// 替换@为#
- (NSString *)replacingAtWithOctothorpe;
/// 替换#为@
- (NSString *)replacingOctothorpeWithAt;

/// 手机号添加空格
- (NSString *)phoneNumberAddBlank;

#pragma mark - Size

/**
 *  根据最大宽度返回string的高度
 *
 *  @param maxWidth 最大宽度
 *  @param font    字体
 *
 *  @return string的最小高度
 */
- (CGFloat)heightWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont*)font;

/**
 *  根据最大宽度返回string的宽度
 *
 *  @param font    字体
 *
 *  @return string的最小宽度
 */
- (CGFloat)widthWithFont:(UIFont*)font;

/**
 *  根据最大size返回string的size
 *
 *  @param maxSize 最大尺寸
 *  @param font    字体
 *
 *  @return string的最小宽度
 */
- (CGSize)sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont*)font;

#pragma mark - string -> float

/// 浮点型数据不四舍五入
- (NSString *)notRoundingAfterPoint:(NSInteger)position;

///  转化成标准数字形式 3位一个","
+(NSString *)convertToDecimalStyle:(NSString *)aString;

///数字整数部分三位加一个逗号，与保留小数点
+(NSString *)convertToDecimalStyle:(NSString *)aString afterPiont:(NSInteger )pointNum;

///数字整数部分三位加一个逗号，与保留小数点 且解决浮点数据小数部分异常问题：列如，5.6887 8 变为 5.6887 79.
+ (NSString *)convertToDecimalStyleWithDouble:(double)d afterPiont:(NSInteger )pointNum;

// 当前字符串转float + 另一个字符串转float，结果按约定保留小数点位数
- (CGFloat)plusByString:(NSString*)string afterPoint:(int)point withRoundingMode:(NSRoundingMode)mode;

// 当前字符串转float * 另一个字符串转float，结果按约定保留小数点位数
- (CGFloat)multiplyingByString:(NSString*)string afterPoint:(int)point withRoundingMode:(NSRoundingMode)mode;

// 字符串转换成float比较大小
- (NSComparisonResult)compareDecimalString:(NSString*)decimalSting;

#pragma mark - regax

typedef NS_ENUM(NSInteger,stringType){
    stringTypeNumber,
    stringTypeChar,
    stringTypeNumberAndChar,
    stringTypeHans,
    stringTypeOther
};
/// 字符串类型
- (stringType)stringType;
///密码限制6位以上，必须数字字母
-(BOOL)isPWFormat;
///密码限制：字母、数字、特殊字母（除空格），两种以上类型组成
- (BOOL)checkPasswordLimit;
///是否手机号
-(BOOL)checkPhoneNumInput;
///是否整形
//- (BOOL)isPureInt;
//判断是否为浮点形：
- (BOOL)isPureFloat;
// 匹配身份证号码
-(BOOL)isIdentityCard;
/// 检查是否输入表情
- (BOOL)containsEmoji;

- (BOOL)isPhoneNumber;

+ (BOOL)isHuolalaPhoneNumber:(NSString*)text;

#pragma mark - 距离（CGFloat） -> string
+ (NSString*)distanceForFloat:(CGFloat)distance;
+ (NSString*)distanceForInt:(int)distance;

@end
