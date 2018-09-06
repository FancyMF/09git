//
//  BaseTableViewCell.h
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/17.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewFactory.h"

@interface BaseTableViewCell : UITableViewCell

-(void)resetDataWith:(NSDictionary *)dict;

+(CGFloat)getCellHeight;

+(instancetype)dequeueReusableCellWithtableView:(UITableView *)tableView;

@end
