//
//  Utils.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/6/28.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)resolveDict:(NSDictionary *)dict{
    
    // 拼接属性字符串代码
    NSMutableString *strM = [NSMutableString string];
    
    // 1.遍历字典，把字典中的所有key取出来，生成对应的属性代码
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 类型经常变，抽出来
        NSString *type = @"NSString";
        
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"int";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }
        
        // 属性字符串
        NSString *str;
        if ([type containsString:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ * %@;",type,key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }
        
        // 每生成属性字符串，就自动换行。
        [strM appendFormat:@"\n%@\n",str];
        
    }];
    
    // 把拼接好的字符串打印出来，就好了。
    NSLog(@"%@",strM);
    
}


@end
