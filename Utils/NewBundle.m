//
//  NewBundle.m
//  myFrame
//
//  Created by 侯佩岑 on 2018/4/27.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "NewBundle.h"
#import <objc/runtime.h>

static const char routeBundle=0;

@implementation NewBundle

-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName

{
    NSBundle* bundle = objc_getAssociatedObject(self, &routeBundle);
    //    NSLog(@"%@\n",objc_getAssociatedObject(self, &routeBundle));
    
    //绑定语言包加载路径
    
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
    
}

@end

@implementation NSBundle (Language)

+(void)setLanguage:(NSString*)language{
    
    NSArray *languagesArr = [NSLocale preferredLanguages];
    BOOL contan = NO;
    for (NSString * targetLanguage in languagesArr) {
        if ([targetLanguage hasPrefix:language]) {
            contan = YES;
        }
    }
//    if (contan) {
//        
//    }else{
//        language = @"zh-Hans";
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle],[NewBundle class]);
    });
    
    objc_setAssociatedObject([NSBundle mainBundle], &routeBundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
    
