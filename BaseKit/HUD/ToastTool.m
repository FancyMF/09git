//
//  ToastTool.m
//  myFrame
//
//  Created by 侯佩岑 on 2018/4/25.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "ToastTool.h"

NSString * const kFailResponeWord= @"亲，网络不好，请稍后再试";
NSString * const kEmptyResponseWord = @"服务器返回的数据为空";
NSString * const kPassWordErrorTip  = @"密码必须为数字与字母组合且长度至少为8位";

@implementation ToastTool

+(void)initConfigration{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
}

+(void)dismiss{
    [SVProgressHUD dismiss];
}

+(void)showWithStatus:(NSString *)status{
    if (!status || status.length<=0) {
        return;
    }
    [SVProgressHUD showWithStatus:status];
}

+(void)showSuccessWithStatus:(NSString *)toast{
    if (!toast || toast.length<=0) {
        return;
    }
    [SVProgressHUD showSuccessWithStatus:toast];
}

+(void)showInfoWithStatus:(NSString *)toast{
    if (!toast || toast.length<=0) {
        return;
    }
    [SVProgressHUD showInfoWithStatus:toast];
}

+(void)showErrorWithStatus:(NSString *)toast{
    if (![toast isKindOfClass:[NSString class]]) {
        NSLog(@"error input class");
        return;
    }
    if (!toast || toast.length<=0) {
        return;
    }
    [SVProgressHUD showErrorWithStatus:toast];
}

+(void)showErrorWithError:(NSError *)error{
    NSString * toast = kFailResponeWord;
    NSString * errorString = error.userInfo[@"MSG"];
    if (error && errorString && errorString.length >0) {
        toast = errorString;
    }else{
    }
    [SVProgressHUD showErrorWithStatus:toast];
}

+(void)showErrorWithEmptyResponse{
    [SVProgressHUD showErrorWithStatus:kEmptyResponseWord];
}

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message subTitles:(NSArray <NSString *> *)subTitles selectFinish:(void(^)(NSInteger index,NSString * stbTitle))selectBlock completion:(void (^)(void))completion{
    [[self class] showTipVCWithTitle:title message:message subTitles:subTitles preferredStyle:UIAlertControllerStyleAlert showVC:[UIApplication sharedApplication].keyWindow.rootViewController selectFinish:selectBlock completion:completion];
    
}

+(void)showSheettWithTitle:(NSString *)title message:(NSString *)message subTitles:(NSArray <NSString *> *)subTitles selectFinish:(void(^)(NSInteger index,NSString * stbTitle))selectBlock completion:(void (^)(void))completion{
    [[self class] showTipVCWithTitle:title message:message subTitles:subTitles preferredStyle:UIAlertControllerStyleActionSheet showVC:[UIApplication sharedApplication].keyWindow.rootViewController selectFinish:selectBlock completion:completion];
    
}

+(void)showTipVCWithTitle:(NSString *)title message:(NSString *)message subTitles:(NSArray <NSString *> *)subTitles preferredStyle:(UIAlertControllerStyle)preferredStyle showVC:(UIViewController *)showVC selectFinish:(void(^)(NSInteger index,NSString * stbTitle))selectBlock completion:(void (^)(void))completion{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    NSInteger index = 0;
    for (NSString * subTitle in subTitles) {
        if (subTitle.length>0) {
            UIAlertAction * action = [UIAlertAction actionWithTitle:subTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                selectBlock(index,subTitle);
            }];
            [alertVC addAction:action];
        }
        index++;
    }
    
    if (showVC) {
        [showVC presentViewController:alertVC animated:YES completion:^{
            completion();
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:^{
            completion();
        }];
    }
}

@end
