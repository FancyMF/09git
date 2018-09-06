//
//  BaseViewController.h
//  
//
//  Created by chenpeihang on 2018/2/11.
//  Copyright © 2018年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "BaseViewFactory.h"
#import "BaseScrollView.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) BaseScrollView * mainScrollView;
@property (nonatomic, strong) UITableView * mainTableView;

-(void)resetUI;

-(void)setLeftBarButtonItemWithTitle:(NSString *)title withSEL:(SEL)selector;
-(void)setLeftBarButtonItemWithImageName:(NSString *)imageName withSEL:(SEL)selector;
-(void)setLeftBarButtonItemWithImageName:(NSString *)imageName WithTitle:(NSString *)title withSEL:(SEL)selector;

-(void)setRightBarButtonItemWithTitle:(NSString *)title withSEL:(SEL)selector;
-(void)setRightBarButtonItemWithImageName:(NSString *)imageName withSEL:(SEL)selector;
-(void)setRightBarButtonItemWithTitle:(NSString *)title Color:(UIColor *)Color withSEL:(SEL)selector;

-(void)returnClick:(id)sender;

@end
