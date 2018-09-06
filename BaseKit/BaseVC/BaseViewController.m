//
//  BaseViewController.m
//
//  Created by chenpeihang on 2018/2/11.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark-
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorBackground();
    
    if (self.navigationController.viewControllers.count > 1) {
        [self setLeftBarButtonItemWithImageName:@"return_icon" withSEL:@selector(returnClick:)];
    }
}

-(void)resetUI{
    
}

-(void)returnClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark- selector
-(void)setLeftBarButtonItemWithTitle:(NSString *)title withSEL:(SEL)selector{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.text = title;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    if (selector) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
    }
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)setLeftBarButtonItemWithImageName:(NSString *)imageName withSEL:(SEL)selector{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.userInteractionEnabled = YES;
    imageView.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [bgView addSubview:imageView];
    if (selector) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:tap];
    }
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)setLeftBarButtonItemWithImageName:(NSString *)imageName WithTitle:(NSString *)title withSEL:(SEL)selector{
    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,70,50)];
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:title forState:UIControlStateNormal];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)setRightBarButtonItemWithTitle:(NSString *)title withSEL:(SEL)selector{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.text = title;
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    if (selector) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
    }
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.navigationItem.rightBarButtonItem = leftItem;
}
-(void)setRightBarButtonItemWithTitle:(NSString *)title Color:(UIColor *)Color withSEL:(SEL)selector{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.text = title;
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = Color;
    if (selector) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
    }
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.navigationItem.rightBarButtonItem = leftItem;
}

-(void)setRightBarButtonItemWithImageName:(NSString *)imageName withSEL:(SEL)selector{
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,25,50)];
    if (imageName && imageName.length > 0)  {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    else{
        [button setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateNormal];
    }
    if (selector) {
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}




#pragma mark-
-(void)setTitle:(NSString *)title{
    if (title && title.length > 0) {
        self.navigationItem.title = title;
    }
    [super setTitle:title];
}

-(BaseScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[BaseScrollView alloc] init];
        _mainScrollView.bounces = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_mainScrollView];
        [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.view);
        }];
    }
    return _mainScrollView;
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [UIInitTool tableViewWithFrame:CGRectZero backgroundColor:kColorBackground() style:UITableViewStylePlain speratorStyle:UITableViewCellSeparatorStyleNone dataSource:nil delegate:nil superView:self.view];
        _mainTableView.tableFooterView = [[UIView alloc] init];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.bottom.equalTo(self.view);
        }];
        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

    }
    return _mainTableView;
}

-(void)dealloc{
    NSLog(@"----%@类释放了----",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- 橫豎屏設置
- (BOOL)shouldAutorotate{
    return NO;
} //NS_AVAILABLE_IOS(6_0);当前viewcontroller是否支持转屏

- (NSUInteger)supportedInterfaceOrientation{
    return UIInterfaceOrientationPortrait;
} //当前viewcontroller支持哪些转屏方向

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
} //当前viewcontroller默认的屏幕方向

@end
