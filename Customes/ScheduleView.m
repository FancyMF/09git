//
//  ScheduleView.m
//  myFrame
//
//  Created by 侯佩岑 on 2018/5/11.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "ScheduleView.h"

NSInteger const kTagIndexView = 1000;

@implementation ScheduleView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleArray = @[];
        self.selectImageArray = @[];
        self.unSelectImageArray = @[];
        self.colorArray = @[[UIColor colorWithWhite:0.3 alpha:1],[UIColor colorWithWhite:0.8 alpha:0.9]];
        self.size = 10;
        self.index = 0;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = @[];
        self.selectImageArray = @[];
        self.unSelectImageArray = @[];
        self.colorArray = @[[UIColor colorWithWhite:0.3 alpha:1],[UIColor colorWithWhite:0.8 alpha:0.9]];
        self.size = 10;
        self.index = 0;
    }
    return self;
}


-(void)reloadUI{
    if (self.titleArray.count > self.selectImageArray.count || self.titleArray.count > self.selectImageArray.count){
        return;
    }
    self.size = MAX(self.size, 1);
    if (self.index >= self.titleArray.count) {
        self.index = self.titleArray.count-1;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat width = CGRectGetWidth(self.frame) / [self titleArray].count;
    int i = 0;
    for (NSString * title in self.titleArray) {
        NSString * headTitle = title;
        if (headTitle.length <= 0) {
            headTitle = @"空";
        }
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*width, 0, width, CGRectGetHeight(self.frame))];
        view.tag = kTagIndexView;
        [self addSubview:view];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        if (self.index<i) {
            imageView.image = self.unSelectImageArray[i];
        }else{
            imageView.image = self.selectImageArray[i];
        }
        imageView.frame = CGRectMake(0, 0, MIN(self.size, CGRectGetHeight(self.frame)/3*2), MIN(self.size, CGRectGetHeight(self.frame)/3*2));
        imageView.center = CGPointMake(width/2, CGRectGetHeight(self.frame)/3);
        imageView.backgroundColor = [UIColor grayColor];
        [view addSubview:imageView];
                                    
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)/3*2, width, CGRectGetHeight(self.frame)/3)];
        titleLabel.text = headTitle;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
        
        CGFloat lineWidth = width / 2;
        if (i == 0) {
            
        }else{
            UIView * lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(0, 0, lineWidth, 1);
            lineView.center = CGPointMake(width/4, CGRectGetHeight(self.frame)/3);
            if (self.index<i) {
                lineView.backgroundColor = self.colorArray[0];
            }else{
                lineView.backgroundColor = self.colorArray[1];
            }
//            lineView.backgroundColor = self.colorArray[0];
//            lineView.backgroundColor = [UIColor grayColor];
            [view addSubview:lineView];
            [view sendSubviewToBack:lineView];
        }
        if (i == self.titleArray.count-1) {
            
        }else{
            UIView * lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(0, 0, lineWidth, 1);
            lineView.center = CGPointMake(width/4*3, CGRectGetHeight(self.frame)/3);
            if (self.index<i+1) {
                lineView.backgroundColor = self.colorArray[0];
            }else{
                lineView.backgroundColor = self.colorArray[1];
            }
//            lineView.backgroundColor = self.colorArray[0];
//            lineView.backgroundColor = [UIColor grayColor];
            [view addSubview:lineView];
            [view sendSubviewToBack:lineView];
            
        }
        i++;
    }
}




@end
