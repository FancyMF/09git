//
//  LoginGlobal.h
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/15.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic, strong) NSString * memberId;

@property (nonatomic, strong) NSString * uid;

@property (nonatomic, strong) NSString * headImg;

@property (nonatomic, strong) NSString * token;

@property (nonatomic, strong) NSNumber * hasGesturePwd;



@end
//
//@protocol LoginTypedelegate<NSObject>
//@optional
//-(void)TypeChangeDelegateChange;
//-(void)TypeChangeDelegateChangeWithModel:(borrowQuota*)model;
//@end

@interface LoginGlobal : NSObject

+(LoginGlobal *)share;

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) NSString * userPhone;

/// 白用设别反欺诈iOS 参数  ,每次打开App都获取,不需要存在UserDefault中;
@property (nonatomic, strong) NSString * gid;

@property (nonatomic, strong) UserModel * userInfo;

//@property (nonatomic,assign) ApplyStageType type;
//@property (nonatomic,strong) borrowQuota *model;
//@property(nonatomic,weak)id<LoginTypedelegate> delegate;
//@property(nonatomic,weak)id<LoginTypedelegate> homeDelegate;

-(void)getNewType;
-(void)clearLoginMes;
-(void)loginSuccess;
@end




