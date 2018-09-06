//
//  GetContactHelper.h
//  PushiStage
//
//  Created by 侯佩岑 on 2018/6/27.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface GetContactHelper : NSObject

-(instancetype)initWithTargetViewVC:(UIViewController *)vc;
@property (nonatomic, weak) UIViewController * targetVC;
-(void)requireContact;
@property (nonatomic, copy) void(^selectContact)(NSString * name,NSString * phone,NSArray * phones);


@end
