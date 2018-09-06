//
//  BaseTableViewCell.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/17.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+(CGFloat)getCellHeight{
    return 55;
}

+(instancetype)dequeueReusableCellWithtableView:(UITableView *)tableView{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
}

-(void)resetDataWith:(NSDictionary *)dict{
    
}

@end
