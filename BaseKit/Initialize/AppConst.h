//
//  AppConst.h
//  全局常量

#import "UIKit/UIKit.h"
#import "Foundation/Foundation.h"
#import "CoreGraphics/CoreGraphics.h"
#import "NSString+Handle.h"

extern int const kBaseTag;
extern int const kOnlineLimit;
extern NSString* const kAppStoreID;
extern NSString* const kServerTel;
extern NSString* const cityNoOpenTips;

#pragma mark - NSUserdefaults Key
extern NSString* const kLastVersionNumber;

#pragma mark - TimeInterval

extern int const kPageSize;
extern int const kToastInterval;
extern int const kTimeoutInterval;
extern CGFloat const kFPS;
extern CGFloat const kAnimateInterval;

#pragma mark -- Network HUD

extern NSString* const kNetworkLoading;
extern NSString* const kNetworkWithoutData;
extern NSString* const kNetworkWithoutInternet;

#pragma mark -- Alert

extern NSString* const kAlertGo;
extern NSString* const kAlertSure;
extern NSString* const kAlertCancel;
extern NSString* const kAlertTitleTips;

#pragma mark - Notification


#pragma mark - Normal control height

extern int const kTabbarHeight;
extern int const kSearchBarHeight;
extern int const kNavigationHeight;

extern CGFloat const kCornerInset;
extern CGFloat const kCornerRadius;

#pragma mark - Character

extern NSString *const kNUMBERS;
extern NSString *const k_xX;
extern NSString *const kAlphaNum;
extern NSString *const kAlpha;
extern NSString *const kSpecial_Character;
extern NSString *const kSpecialCharacterAndNumber;
extern NSString *const kAllCharacterAndNumber;

#pragma mark - weak/Strong

#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

@interface AppConst : NSObject

#pragma mark - App Info

+ (NSString*)displayName;

//+ (NSString*)UUIDString;

+ (NSString*)bundleIDString;

+ (NSString*)shortVersionString;

+ (NSString*)versionString;

+ (int)versionNumber;

#pragma mark - Device Info

+ (NSString*)advertisingID;

/**
 @return 设备名称 (例如:iPhone 7Plus)
 */
+ (NSString*)deviceName;

@end
