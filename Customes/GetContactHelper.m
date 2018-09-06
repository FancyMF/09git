//
//  GetContactHelper.m
//  PushiStage
//
//  Created by 侯佩岑 on 2018/6/27.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "GetContactHelper.h"

@interface GetContactHelper ()<CNContactPickerDelegate>

@end

@implementation GetContactHelper

-(instancetype)initWithTargetViewVC:(UIViewController *)vc{
    if (self = [self init]) {
        self.targetVC = vc;
    }
    return self;
}

-(void)requireContact{
    //让用户给权限,没有的话会被拒的各位
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error");
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self contactVCPush];
                    
                });
            }
        }];
    }else if (status == CNAuthorizationStatusAuthorized) {//有权限时
        [self contactVCPush];
    }else{
        [ToastTool showAlertWithTitle:@"您未开启通讯录权限" message:@"请在iPhone的「设置中心」中开启通讯录权限。" subTitles:@[@"取消",@"确定"] selectFinish:^(NSInteger index, NSString *stbTitle) {
            if (index == 1) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        } completion:^{
            
        }];
    }
    
}

-(void)contactVCPush{
    CNContactPickerViewController * picker = [CNContactPickerViewController new];
    picker.delegate = self;
    picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactMiddleNameKey,CNContactFamilyNameKey];//只显示手机号
    if (self.targetVC) {
        [self.targetVC presentViewController: picker  animated:YES completion:nil];
    }else{
        NSLog(@"have not set targetVC");
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    NSLog(@"%@",contact);
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName?:@"";
    NSString *firstname = contact.givenName?:@"";
    NSString *organizationName = contact.organizationName?:@"";
    NSString * name = [NSString stringWithFormat:@"%@%@",lastname,firstname];
    if (name.length <= 0 && organizationName.length > 0) {
        name = organizationName;
    }
    
    // 2.获取联系人的电话号码
    NSArray *phoneNums = contact.phoneNumbers;
    NSMutableArray *phones = [NSMutableArray arrayWithCapacity:5];
    for (CNLabeledValue *labeledValue in phoneNums) {
        // 2.2.获取电话号码
        CNPhoneNumber *phoneNumer = labeledValue.value;
        NSString *phoneValue = phoneNumer.stringValue;
        if (phoneValue && phoneValue.length > 0) {
            [phones addObject:phoneValue];
        }
    }
    if (phones.count>1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ToastTool showAlertWithTitle:@"请选择" message:@"手机号码" subTitles:phones selectFinish:^(NSInteger index, NSString *stbTitle) {
                NSString * phone = phones[index]?:@"";
                phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
                phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
                self.selectContact(name, phone, phones.copy);
            } completion:^{
                
            }];
        });
    }else{
        NSString * phone = [phones firstObject]?:@"";
        phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.selectContact(name, phone,@[]);
    }
    
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    
    NSLog(@"%@",contactProperty);
}

@end
