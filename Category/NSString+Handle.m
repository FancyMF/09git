//
//  NSString+Handle.m

#import "NSString+Handle.h"
#import <CommonCrypto/CommonDigest.h>

//static NSString *const kNUMBERS = @"0123456789";
//static NSString *const kAlpha = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
//static NSString *const kSpecial_Character = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'";

@implementation NSString (Handle)

- (NSString *)SHA256
{
    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

#pragma mark - reverse
- (NSString*)reverseString{
    uint64_t  i = 0;
    uint64_t j = self.length - 1;
    unichar *characters = malloc(sizeof([self characterAtIndex:0]) * self.length);
    while (i < j) {
        characters[j] = [self characterAtIndex:i];
        characters[i] = [self characterAtIndex:j];
        i ++;
        j --;
    }
    if(i == j)
        characters[i] = [self characterAtIndex:i];
    return [NSString stringWithCharacters:characters length:self.length];
}

#pragma mark - Encoding / Decoding

- (NSString *)UTF8EncodingString{
    return [NSString encodingString:self withType:kCFStringEncodingUTF8];
}

+ (NSString *)encodingString:(NSString *)targetString withType:(CFStringEncoding)type{
    
    if (@available(iOS 9.0, *)) {
        return [targetString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*’();:@&=+$,/?%#[]"]];
    }else{
        CFStringRef cfString = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)targetString, NULL, (__bridge CFStringRef)@"!*’();:@&=+$,/?%#[]", type);
        NSString * encodingString = (__bridge NSString*)cfString;
        CFRelease(cfString);
        return encodingString;
    }
}

- (NSString *)UTF8DecodingString{
    if (@available(iOS 9.0, *)) {
        return self.stringByRemovingPercentEncoding;
    }else{
        return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

+ (NSString *)decodingString:(NSString*)targetString withType:(CFStringEncoding)type{
    return [targetString stringByReplacingPercentEscapesUsingEncoding:type];
}
#pragma mark - url
+ (NSString *)nullToEmpty:(NSString*)string{
    if (string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]]){
        return @"\"\"";
    }
    else
    {
        return [NSString stringWithFormat:@"\"%@\"",string];
    }
}
+ (NSString*)jsonStringFromArray:(NSArray*)array{
    NSMutableString* urlString = [@"" mutableCopy];
    if ([array isKindOfClass:[NSArray class]]) {
        for (NSObject* obj in array) {
            if ([obj isKindOfClass:[NSString class]]) {
                [urlString appendFormat:@"\"%@\",",obj];
            }else{
                [urlString appendFormat:@"%@,",[obj description]];
            }
        }
        
        if ([urlString hasSuffix:@","])
        {
            [urlString deleteCharactersInRange:NSMakeRange(urlString.length - 1, 1)];
        }
    }
    
    return [NSString stringWithFormat:@"[%@]",urlString];
}

+ (NSString*)jsonStringFromDictionary:(NSDictionary*)dic{
    NSMutableString* urlString = [@"" mutableCopy];
    if ([dic isKindOfClass:[NSDictionary class]]){
        for (NSString* key in dic.allKeys)
        {
            [urlString appendFormat:@"\"%@\":%@,",key,[dic[key] description]];
        }
        
        if ([urlString hasSuffix:@","])
        {
            [urlString deleteCharactersInRange:NSMakeRange(urlString.length - 1, 1)];
        }
    }
    
    return [NSString stringWithFormat:@"{%@}",urlString];
}
#pragma mark - timeInteval -> dateString

+ (NSString*)dateStringForTimeInterval:(NSTimeInterval)timeInterval{
    NSString* dateString = [self dateStringForTimeInterval:timeInterval format:@"MM月dd日 HH:mm"];
    return dateString;
}
+ (NSString*)dateStringForTimeInterval:(NSTimeInterval)timeInterval format:(NSString*)formatter{
    NSString* dateString = nil;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:formatter];
    dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

#pragma mark - Quary
- (BOOL)containString:(NSString *)subString{
    BOOL contain = YES;
    
    NSString* parentCopyString = [self copy];
    for (int i = 0; i < subString.length; i++){
        NSString* subOfSubString = [subString substringWithRange:NSMakeRange(i, 1)];
        
        NSRange range = [parentCopyString rangeOfString:subOfSubString];
        if (range.location == NSNotFound){
            contain = NO;
        }else
        {
            parentCopyString = [parentCopyString stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    return contain;
}
+ (BOOL)isNull:(NSString *)string{
    if (string == nil || string == NULL ||
        [string isKindOfClass:[NSNull class]]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)isEmpty:(NSString *)string{
    if ([NSString isNull:string]){
        return YES;
    }
    else if ([[string stringBySpaceTrim] length] == 0){
        return YES;
    }
    
    return NO;
}

#pragma mark - Replace

// 去空格
- (NSString *)stringBySpaceTrim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)replacingAtWithOctothorpe{
    return [self stringByReplacingOccurrencesOfString:@"@" withString:@"#"];
}

- (NSString *)replacingOctothorpeWithAt{
    return [self stringByReplacingOccurrencesOfString:@"#" withString:@"@"];
}

// 将回车转成空格
- (NSString *)replacingEnterWithNull{
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

// 手机号添加空格
- (NSString *)phoneNumberAddBlank{
    // 去掉-
    NSString* phone = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSMutableString *string = [NSMutableString string];
    for (int i = 0;i< self.length; i++){
        if (i == 2 ||i == 6)
        {
            [string appendString:[NSString stringWithFormat:@"%@ ",[phone substringWithRange:NSMakeRange(i, 1)]]];
        }
        else
        {
            [string appendString:[phone substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return string;
}
#pragma mark - Size


- (CGFloat)heightWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont*)font{
    return [self sizeWithMaxSize:CGSizeMake(maxWidth, MAXFLOAT) andFont:font].height;
}

-(CGFloat)widthWithFont:(UIFont *)font{
    return [self sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:font].width;
}

- (CGSize)sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font{
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : font}
                              context:nil].size;
}

#pragma mark - string -> float

// 浮点型数据不四舍五入
- (NSString *)notRoundingAfterPoint:(NSInteger)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    NSDecimalNumber* ouncesDecimal = [[NSDecimalNumber alloc] initWithString:self];
    NSDecimalNumber* roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:[NSString formatStringWithPiontNum:position],[roundedOunces doubleValue]];
}

///浮点型:保留几位小数 格式字符串
+ (NSString *)formatStringWithPiontNum:(NSInteger)pointNum{
    NSString *format;
    switch (pointNum) {
        case 0:
            format = @"%f";
            break;
        default:
            format = [NSString stringWithFormat: @"%@%lu%@",@"%.",(unsigned long)pointNum,@"f"];
            break;
    }
    return format;
}

///  转化成标准数字形式 3位一个","
+(NSString *)convertToDecimalStyle:(NSString *)aString{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *myString = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:[aString doubleValue]]];
    return myString;
}

///数字整数部分加逗号与保留小数点
+(NSString *)convertToDecimalStyle:(NSString *)aString afterPiont:(NSInteger )pointNum{
    //截取两位小数
    aString = [aString notRoundingAfterPoint:pointNum];
    float f = [aString floatValue];
    if (f >0){
        //加逗号
        NSString *tempString = [NSString convertToDecimalStyle:aString];
        
        //拼0
        tempString = [NSString appendZero:tempString afterPoint:pointNum];
        
        return tempString;
    }
    else
    {
        return aString;
    }
    
}

///小数点后0不足，拼足0
+ (NSString *)appendZero:(NSString *)tempString afterPoint:(NSInteger)pointNum{
    //如果是整数且小数部分为0，则补足0
    NSRange range = [tempString rangeOfString:@"."];
    if (range.location == NSNotFound){//整数
        tempString = [tempString stringByAppendingString:@"."];
        for (int i=0; i<pointNum; i++)
        {
            tempString = [tempString stringByAppendingString:@"0"];
        }
    }
    else
    {//小数
        NSRange range = [tempString rangeOfString:@"."];
        NSString *floatPartString = [tempString substringFromIndex:range.location+1];
        if (floatPartString.length < pointNum)
        {
            for (int i=0; i<(pointNum - floatPartString.length); i++)
            {
                tempString = [tempString stringByAppendingString:@"0"];
            }
        }
    }
    return tempString;
}
///数字整数部分三位加一个逗号，与保留小数点 且解决浮点数据小数部分异常问题：列如，5.6887 8 变为 5.6887 79.
+ (NSString *)convertToDecimalStyleWithDouble:(double)d afterPiont:(NSInteger )pointNum{
    NSString *string = [NSString stringWithFormat:@"%.6lf",d];
    return [NSString convertToDecimalStyle:string afterPiont:pointNum];
}
// 当前字符串转float + 另一个字符串转float，结果按约定保留小数点位数
- (CGFloat)plusByString:(NSString*)string afterPoint:(int)point withRoundingMode:(NSRoundingMode)mode{
    NSDecimalNumberHandler* roundingHandler = [NSDecimalNumberHandler
                                               
                                               decimalNumberHandlerWithRoundingMode:mode
                                               
                                               scale:point
                                               
                                               raiseOnExactness:NO
                                               
                                               raiseOnOverflow:NO
                                               
                                               raiseOnUnderflow:NO
                                               
                                               raiseOnDivideByZero:YES];
    
    NSDecimalNumber* decimalOfSelf = [NSDecimalNumber decimalNumberWithString:self];
    
    NSDecimalNumber* decimalOfMultiply = [NSDecimalNumber decimalNumberWithString:string];
    
    NSDecimalNumber* result = [decimalOfSelf decimalNumberByAdding:decimalOfMultiply
                               
                                                      withBehavior:roundingHandler];
    return [result floatValue];
}

// 当前字符串转float * 另一个字符串转float，结果按约定保留小数点位数
- (CGFloat)multiplyingByString:(NSString*)string afterPoint:(int)point withRoundingMode:(NSRoundingMode)mode{
    NSDecimalNumberHandler* roundingHandler = [NSDecimalNumberHandler
                                               
                                               decimalNumberHandlerWithRoundingMode:mode
                                               
                                               scale:point
                                               
                                               raiseOnExactness:NO
                                               
                                               raiseOnOverflow:NO
                                               
                                               raiseOnUnderflow:NO
                                               
                                               raiseOnDivideByZero:YES];
    
    NSDecimalNumber* decimalOfSelf = [NSDecimalNumber decimalNumberWithString:self];
    
    NSDecimalNumber* decimalOfMultiply = [NSDecimalNumber decimalNumberWithString:string];
    
    NSDecimalNumber* result = [decimalOfSelf decimalNumberByMultiplyingBy:decimalOfMultiply
                               
                                                             withBehavior:roundingHandler];
    return [result floatValue];
}

// 字符串转换成float比较大小
- (NSComparisonResult)compareDecimalString:(NSString*)decimalSting{
    NSDecimalNumber* decimalOfSelf = [NSDecimalNumber decimalNumberWithString:self];
    
    NSDecimalNumber* decimalOfString = [NSDecimalNumber decimalNumberWithString:decimalSting];
    
    NSComparisonResult result = [decimalOfSelf compare:decimalOfString];
    
    return result;
}
#pragma mark - regax
///密码限制6位以上，必须数字字母
-(BOOL)isPWFormat{
    if (self.length < 6) {
        return NO;
    }
    NSString *postalRegex = @"^[A-Za-z0-9]+$";
    if ([self isValidateByRegex:postalRegex]) {
        return YES;
    }
    return NO;
}
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

///密码限制：字母、数字、特殊字母（除空格），两种以上类型组成
- (BOOL)checkPasswordLimit{
    NSString *stringResult1 = [NSString publicStringWithString1:self string2:kSpecial_Character];
    NSString *stringResult2 = [NSString publicStringWithString1:self string2:kNUMBERS];
    NSString *stringResult3 = [NSString publicStringWithString1:self string2:kAlpha];
    
    BOOL stringResultFlag1 = ![NSString isNull:stringResult1];
    BOOL stringResultFlag2 = ![NSString isNull:stringResult2];
    BOOL stringResultFlag3 = ![NSString isNull:stringResult3];
    
    if ((stringResultFlag1 && stringResultFlag2) || (stringResultFlag1 && stringResultFlag3) || (stringResultFlag3 && stringResultFlag2)){
        NSRange _range = [self rangeOfString:@" "];
        if (_range.location != NSNotFound) {

            return NO;
        }else {

            return YES;
        }
    }
    else
    {
        return NO;
    }
    
}

-(BOOL)checkPhoneNumInput{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|70|77)//d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d)//d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])//d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)//d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|//d{3})//d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (NSString *)publicStringWithString1:(NSString *)string1 string2:(NSString *)string2 {
    NSString *publicString = @"";
    for (NSInteger i = 0; i < string1.length ; i++) {
        unichar char1 = [string1 characterAtIndex:i];
        for (NSInteger j = 0; j < string2.length; j++) {
            unichar char2 = [string2 characterAtIndex:j];
            if (char1 == char2) {
                publicString = [NSString stringWithFormat:@"%@%c",publicString,char1];
                break;
            }
        }
    }
    return publicString;
}


//- (BOOL)isPureInt{
//    NSScanner* scan = [NSScanner scannerWithString:self];
//    int val;
//    return [scan scanInt:&val] && [scan isAtEnd];
//}
//判断是否为浮点形：
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

///是否包含Emoji表情
- (BOOL)containsEmoji{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
// 匹配身份证号码
-(BOOL)isIdentityCard{
    // 判断位数
    if ([self length] != 15 && [self length] != 18){
        return NO;
    }
    
    NSString *carid = self;
    long lSumQT  =0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15){
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]){
        return NO;
    }
    // 判断年月日是否有效
    // 年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    // 月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    // 日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil){
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if( 18 != strlen(PaperId)) return -1;
    // 校验数字
    for (int i=0; i<18; i++){
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    // 验证最末的校验码
    for (int i=0; i<=16; i++){
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] ){
        return NO;
    }
    return YES;
}

-(BOOL)areaCode:(NSString *)code{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

- (stringType)stringType{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, self.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    if (tNumMatchCount == self.length) {
        //全部符合数字，表示沒有英文
        return stringTypeNumber;
    } else if (tLetterMatchCount == self.length) {
        //全部符合英文，表示沒有数字
        return stringTypeChar;
    } else if (tNumMatchCount + tLetterMatchCount == self.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return stringTypeNumberAndChar;
    } else {
        return stringTypeOther;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
}

- (BOOL)isPhoneNumber{
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|70|77)\\d{8}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//
//    BOOL res1 = [regextestmobile evaluateWithObject:self];
//    BOOL res2 = [regextestcm evaluateWithObject:self];
//    BOOL res3 = [regextestcu evaluateWithObject:self];
//    BOOL res4 = [regextestct evaluateWithObject:self];
//
//    if (res1 || res2 || res3 || res4 ){
//        return YES;
//    }
//
//    return NO;
    
    NSString *regexStr = @"^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) return NO;
    NSInteger count = [regular numberOfMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    if (count > 0) {
        return YES;
    } else {
        return NO;
    }
    

}
+ (BOOL)isHuolalaPhoneNumber:(NSString *)text{
    if ([NSString isEmpty:text]){
        return NO;
    }
    else
    {
        if (text.length != 11 || ![text hasPrefix:@"1"]) {
            return NO;
        }
    }
    return YES;
}
+ (NSString *)distanceForFloat:(CGFloat)distance{
    NSString* distanceString = @"";
    if (distance > 1000) {
        distanceString = [NSString stringWithFormat:@"%.0f公里",distance/1000.0];
    }
    else
    {
        distanceString = [NSString stringWithFormat:@"%.0f米",distance];
    }
    return distanceString;
}

+ (NSString *)distanceForInt:(int)distance{
    NSString* distanceString = @"";
    
    if (distance < 1000){
        distanceString = [NSString stringWithFormat:@"%d米",distance];
    }
    else
    {
        if (distance%1000 != 0)
        {
            distance = (distance/1000)*1000;
            distance += 1000;
        }
        distanceString = [NSString stringWithFormat:@"%d公里",distance/1000];
    }
    return distanceString;
}

@end
