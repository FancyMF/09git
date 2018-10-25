//
//  AppConst.m
//

#import "AppConst.h"
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>

#import <Foundation/Foundation.h>

int const kBaseTag = 10000;

NSString* const kAppStoreID = @"00000000000";     // APPStore ID
NSString* const kServerTel = @"4006667778";   // 客服电话";/// 城市未开通的提示

#pragma mark - NSUserdefaults Key
NSString* const kLastVersionNumber = @"kLastVersionNumber"; //上次版本号 -> int

#pragma mark - Network TimeInterval

int const kTimeoutInterval = 15;        // 网络请求超时时长
int const kToastInterval = 1;           // 网络提示语时长
CGFloat const kAnimateInterval = 0.3;   // 动画时长
int const kPageSize = 10;               // 每次请求多少条数据
CGFloat const kFPS = 30;                // 刷新频率

#pragma mark -- Network HUD 

NSString* const kNetworkWithoutInternet = @"网络异常，请检查网络设置";
NSString* const kNetworkWithoutData = @"暂无数据";
NSString* const kNetworkLoading = @"正在加载...";

#pragma mark -- Alert

NSString* const kAlertTitleTips = @"温馨提示";
NSString* const kAlertSure = @"我知道了";
NSString* const kAlertCancel = @"取消";
NSString* const kAlertGo = @"前往";

#pragma mark - Notification



#pragma mark - normal control height

int const kTabbarHeight = 49.0;
int const kSearchBarHeight = 45.0;
int const kNavigationHeight = 44.0;

CGFloat const kCornerInset = 8.0;
CGFloat const kCornerRadius = 2.0;

#pragma mark - Character and Number
NSString *const kNUMBERS = @"0123456789";
NSString *const k_xX     =     @"xX";
NSString *const kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
NSString *const kAlpha = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
NSString *const kSpecial_Character = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'";
NSString *const kSpecialCharacterAndNumber = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789";
NSString *const kAllCharacterAndNumber = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

#pragma mark - Regax

NSString *const kRegexExceptSpace = @"\\S";
NSString *const kRegexNumber = @"[0-9]";
NSString *const kRegexCharacter = @"[a-zA-Z]";
NSString *const kCharacterlower = @"[a-z]";
NSString *const kCharacteruper = @"[A-Z]";
NSString *const kNumberAndCharacter = @"[0-9a-zA-Z]";
NSString *const kNumberAndCharacterlower = @"[0-9a-z_.@]";


@implementation AppConst





+ (NSString *)displayName{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

/// 应用卸载重装会改变
//+ (NSString *)UUIDString{
//    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//}

+ (NSString *)bundleIDString{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)shortVersionString{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString*)versionString{
    CFStringRef cfKey = kCFBundleVersionKey;
    NSString* bundleVersionKey = (__bridge NSString*)cfKey;
    CFRelease(cfKey);
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:bundleVersionKey];
}

+ (int)versionNumber{
    return [[self versionString] intValue];
}

/*
●  当用户手动改变设置中的『限制广告追踪』和『原广告标示符』时,每次点击都会造成广告获取 IDFA 改变。
●  打开『限制广告追踪』后，
    iOS 10获取的都是 00000000-0000-0000-0000-000000000000 ，
●  不论用户在设置中是否开启『限制广告追踪』，用户重启设备都不会造成 IDFA 改变。
●  还原所有设置，不会改变当前 IDFA 的值。
●  抹掉所有内容和设置，会改变当前 IDFA 的值。
 */
+ (NSString*)advertisingID{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString*)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform , *deviceName = @"";
    platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform hasPrefix:@"iPad"]) {
        deviceName = @"iPad";
    }else if ([platform hasPrefix:@"iPod"]){
        deviceName = @"iPod";
    }else{
        deviceName = [self deviceNameDic][platform];
        if ([NSString isEmpty:deviceName]) {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}

+ (NSDictionary<NSString* , NSString*>*)deviceNameDic
{
    return @{@"iPhone1,1":@"iPhone 2G",
             @"iPhone1,2":@"iPhone 3G",
             @"iPhone2,1":@"iPhone 3GS",
             @"iPhone3,1":@"iPhone 4",
             @"iPhone3,2":@"iPhone 4",
             @"iPhone3,3":@"iPhone 4",
             @"iPhone3,3":@"iPhone 4",
             @"iPhone4,1":@"iPhone 4S",
             @"iPhone5,1":@"iPhone 5",
             @"iPhone5,2":@"iPhone 5",
             @"iPhone5,3":@"iPhone 5c",
             @"iPhone5,4":@"iPhone 5c",
             @"iPhone6,1":@"iPhone 5s",
             @"iPhone6,2":@"iPhone 5s",
             @"iPhone7,1":@"iPhone 6 Plus",
             @"iPhone7,2":@"iPhone 6",
             @"iPhone8,1":@"iPhone 6s",
             @"iPhone8,2":@"iPhone 6s Plus",
             @"iPhone8,4":@"iPhone SE",
             @"iPhone9,1":@"iPhone 7",
             @"iPhone9,3":@"iPhone 7",
             @"iPhone9,2":@"iPhone 7 Plus",
             @"iPhone9,4":@"iPhone 7 Plus",
             @"iPhone10,1":@"iPhone 8",
             @"iPhone10,4":@"iPhone 8",
             @"iPhone10,2":@"iPhone 8 Plus",
             @"iPhone10,5":@"iPhone 8 Plus",
             @"iPhone10,3":@"iPhone10,3",
             @"iPhone10,6":@"iPhone X",
             //             @"iPod1,1":@"iPod Touch 1G",
             //             @"iPod2,1":@"iPod Touch 2G",
             //             @"iPod3,1":@"iPod Touch 3G",
             //             @"iPod4,1":@"iPod Touch 4G",
             //             @"iPod5,1":@"iPod Touch 5G",
             
             //             @"iPad1,1":@"iPad 1G",
             //             @"iPad2,1":@"iPad 2",
             //             @"iPad2,2":@"iPad 2",
             //             @"iPad2,3":@"iPad 2",
             //             @"iPad2,4":@"iPad 2",
             //             @"iPad2,5":@"iPad Mini 1G",
             //             @"iPad2,6":@"iPad Mini 1G",
             //             @"iPad2,7":@"iPad Mini 1G",
             //             @"iPad3,1":@"iPad 3",
             //             @"iPad3,2":@"iPad 3",
             //             @"iPad3,3":@"iPad 3",
             //             @"iPad3,4":@"iPad 4",
             //             @"iPad3,5":@"iPad 4",
             //             @"iPad3,6":@"iPad 4",
             //             @"iPad4,1":@"iPad Air",
             //             @"iPad4,2":@"iPad Air",
             //             @"iPad4,3":@"iPad Air",
             //             @"iPad4,4":@"iPad Mini 2G",
             //             @"iPad4,5":@"iPad Mini 2G",
             //             @"iPad4,6":@"iPad Mini 2G",
             //             @"iPad5,3":@"iPad Air 2",
             @"i386":@"iPhone Simulator",
             @"x86_64":@"iPhone Simulator"};
}

@end
