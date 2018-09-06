//
//  LoginGlobal.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/15.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "LoginGlobal.h"

static NSString * const kloginKey = @"kloginKey";
static NSString * const kloginUserInfo = @"kloginUserInfo";
static NSString * const kloginUserPhone = @"kloginUserPhone";
static NSString * const kregisterID = @"kregisterID";
static NSString * const kresetPWID = @"kresetPWID";

static NSString * const kpassword = @"kpassword";
static NSString * const ktype = @"ktype";
@implementation UserModel

-(void)setHeadImg:(NSString *)headImg{
    _headImg = headImg?:@"";
    [[NSUserDefaults standardUserDefaults] setObject:[self mj_keyValues].copy?:@
     {} forKey:kloginUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

@implementation LoginGlobal

static LoginGlobal * _loginGlobal = nil;
+(LoginGlobal *)share{
    if (_loginGlobal == nil) {
        _loginGlobal = [[self alloc] init];
        
        _loginGlobal.userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:kloginUserPhone]?:@"";
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:kloginUserInfo]?:@{};
        _loginGlobal.userInfo = [UserModel mj_objectWithKeyValues:dic];
        _loginGlobal.isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:kloginKey] boolValue]?:NO;
        NSLog(@"islogin---%@,",_loginGlobal.userPhone);
//        _loginGlobal.password=[[NSUserDefaults standardUserDefaults]objectForKey:kpassword]?:@"";
//#pragma mark 如果有密码，登陆流程
//        if (_loginGlobal.password&&_loginGlobal.password.length>0) {
//            //denlu
//            NSDictionary * parama = @{
//                                      @"mobile":_loginGlobal.userPhone?:@"",
//                                      @"password":_loginGlobal.password?:@"",
//                                      @"smsCode":@"",
//                                      };
//            [XinMiNetworkTool POSTUrl:kLogin parameters:parama success:^(NSDictionary *respondDic, id respondObject) {
//
//                [ToastTool showSuccessWithStatus:@"登陆成功"];
//
//                [LoginGlobal share].isLogin=YES;
//
//            } failure:^(NSString *errorMessage, NSInteger code, NSError *error) {
//                [ToastTool showErrorWithStatus:errorMessage];
//            }];
//        }
//        _loginGlobal.type=[[NSUserDefaults standardUserDefaults]integerForKey:ktype]?:ApplyStageTypeUnlogin;

        
//#warning islogin为NO
////        if(_loginGlobal.type==ApplyStageTypeUnlogin )_loginGlobal.isLogin=0;
//        if (_loginGlobal.isLogin==1) {
//
//            _loginGlobal.type=ApplyStageTypeUnauthorize;
//
//        }
    }
    return _loginGlobal;
}


-(void)clearLoginMes{
    _loginGlobal.userPhone = @"";
    _loginGlobal.userInfo = nil;
    
}

//
//#pragma mark- init
////-(void)setType:(ApplyStageType)type{
////    _type=type;
////
////    [XinMiNetworkTool GETUrl:kBorrowQuota parameters:nil success:^(NSDictionary *respondDic, id respondObject) {
////        //最高审核状 0 通过 1 审核中 ,
////        NSString * examie =  [respondDic objectForKey:@"examine"];
////        if ([examie isEqualToString:@"0"]) {
////            _type=ApplyStageTypeUnauthorize;
////        }
////        else if([examie isEqualToString:@"1"]  ){
////            _type=ApplyStageTypeAuthorizeSuccess;
////
////        }
////    } failure:^(NSString *errorMessage, NSInteger code, NSError *error) {
////        _type=ApplyStageTypeUnauthorize;
////    }];
////
////    if(_type>=ApplyStageTypeUnauthorize) {
////        _isLogin=YES;
////    }
////}
//-(void)getNewType{
//    if(_isLogin==NO){
//
//        _type=ApplyStageTypeUnlogin;
//
//        ApplyStageType type = ApplyStageTypeUnlogin;
//        [self delegateMakerWith:type withMOdel:nil];
//
//        return;
//    }
//#pragma mark
//
//
//#pragma mark
//    [XinMiNetworkTool GETUrl:kBorrowQuota parameters:nil success:^(NSDictionary *respondDic, id respondObject) {
//
//        borrowQuota * model =[borrowQuota mj_objectWithKeyValues:respondDic];
//
//        if (model) {
//            self.model=model;
//        }
//        //        //最高审核状 0 审核中 1 审核通过 2 审核未通过 3 审核失败 4 未提交申请中 ,
//        NSNumber * examie =  [respondDic objectForKey:@"examine"];
//        ApplyStageType type = ApplyStageTypeUnlogin;
//        if ([examie integerValue]==0) {
//            type=ApplyStageTypeAuthorizing;
//
//        }
//        else  if([examie integerValue]==1  ){
//            type=ApplyStageTypeAuthorizeSuccess;
//            //如果剩余额度更最高额度不同，则是有借钱了。
//            if (![model.surplus isEqualToString:model.highestBorrow]) {
//                type=ApplyStageTypeHasApplyStage;
//            }
//
//        }
//        else  if([examie integerValue]==2  ){
//            type=ApplyStageTypeAuthorizeFalied;
//
//        }
//        else  if([examie integerValue]==3  ){
//            type=ApplyStageTypeStopApplyStage;
//        }
//        else  if([examie integerValue]==4  ){
//            type=ApplyStageTypeUnauthorize;
//
//        }
//
//
//        //未提交申请就去授信流程
//
//        [self delegateMakerWith:type withMOdel:model];
//
//
//    } failure:^(NSString *errorMessage, NSInteger code, NSError *error) {
//        ApplyStageType type = ApplyStageTypeUnlogin;
//        if (_isLogin==YES) {
//            type=ApplyStageTypeUnauthorize;
//        }else{
//            type =ApplyStageTypeUnlogin;
//        }
//
//         [self delegateMakerWith:type withMOdel:nil];
//
//    }];
//
//    NSLog(@"type = %lu",(unsigned long)_type);
//}
//
//-(void)delegateMakerWith:(ApplyStageType)type withMOdel:(borrowQuota*)model{
//    self.type = type;
//    [[NSUserDefaults standardUserDefaults]setInteger:self.type forKey:ktype];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    if (self.delegate && [self.delegate respondsToSelector:@selector(TypeChangeDelegateChange)]) {
//        [self.delegate TypeChangeDelegateChange];
//    }
//    if (self.homeDelegate && [self.homeDelegate respondsToSelector:@selector(TypeChangeDelegateChangeWithModel:)]) {
//        [self.homeDelegate TypeChangeDelegateChangeWithModel:model];
//    }
//
//}


-(void)loginSuccess{
    
    [[NSUserDefaults standardUserDefaults] setObject:_loginGlobal.userPhone?:@"" forKey:kloginUserPhone];
    [[NSUserDefaults standardUserDefaults] setObject:[_loginGlobal.userInfo mj_keyValues].copy?:@
     {} forKey:kloginUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)setIsLogin:(BOOL)isLogin{
    

    _isLogin = isLogin;
    NSLog(@"LoginGLobalSetislogin:%d",_isLogin);
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kloginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStateChange object:[NSNumber numberWithBool:_isLogin]];
    if (isLogin == NO) {
        [self clearLoginMes];
    }
    if (isLogin == YES) {
        NSLog(@"%@,%@",_userInfo.token,_userInfo.memberId);
    }
    [self getNewType];
   
}

-(void)setUserPhone:(NSString *)userPhone{
    _userPhone = userPhone;
    [[NSUserDefaults standardUserDefaults] setObject:userPhone?:@"" forKey:kloginUserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setUserInfo:(UserModel *)userInfo{
    _userInfo = userInfo;
    [[NSUserDefaults standardUserDefaults] setObject:[userInfo mj_keyValues].copy?:@
     {} forKey:kloginUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
