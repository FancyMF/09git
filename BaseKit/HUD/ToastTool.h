//
//  ToastTool.h
//  myFrame
//
//  Created by 侯佩岑 on 2018/4/25.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface ToastTool : NSObject

+(void)initConfigration;
/// 菊花消失
+(void)dismiss;
/// 菊花出现
+(void)showWithStatus:(NSString *)status;

+(void)showSuccessWithStatus:(NSString *)toast;

+(void)showInfoWithStatus:(NSString *)toast;

+(void)showErrorWithStatus:(NSString *)toast;

+(void)showErrorWithError:(NSError *)error;

+(void)showErrorWithEmptyResponse;

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message subTitles:(NSArray <NSString *> *)subTitles selectFinish:(void(^)(NSInteger index,NSString * stbTitle))selectBlock completion:(void (^)(void))completion;

+(void)showSheettWithTitle:(NSString *)title message:(NSString *)message subTitles:(NSArray <NSString *> *)subTitles selectFinish:(void(^)(NSInteger index,NSString * stbTitle))selectBlock completion:(void (^)(void))completion;

@end
