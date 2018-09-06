//
//  BaseModel.m
//  myFrame
//
//  Created by 侯佩岑 on 2018/4/25.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"key:%@ / value:%@",key,value);
}

@end
