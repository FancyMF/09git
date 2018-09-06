//
//  LayerView.m
//  myFrame
//
//  Created by 侯佩岑 on 2018/7/23.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "GradientLayerView.h"

@interface GradientLayerView ()

@property (nonatomic, strong) CAGradientLayer * gradientLayer;

@end

@implementation GradientLayerView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        CAGradientLayer *gradientLayer= [CAGradientLayer layer];
        gradientLayer.frame       =self.bounds;
        gradientLayer.colors =@[
                                (id)([UIColor colorWithRed:53/255.0 green:175/255.0 blue:255/255.0 alpha:1]),
                                (id)([UIColor colorWithRed:91/255.0 green:233/255.0 blue:205/255.0 alpha:1]),
                                (id)([UIColor colorWithRed:146/255.0 green:249/255.0 blue:228/255.0 alpha:1]),
                                ];
        gradientLayer.startPoint =CGPointMake(0,0.5);
        gradientLayer.endPoint =CGPointMake(1,0.5);
        gradientLayer.borderWidth  =0.0;
        [self.layer addSublayer:gradientLayer];
        self.gradientLayer = gradientLayer;
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAGradientLayer *gradientLayer= [CAGradientLayer layer];
        gradientLayer.frame       = CGRectMake(0, 0, kScreenWidth(), 175);
        gradientLayer.colors =@[
                                (id)([UIColor colorWithRed:53/255.0 green:175/255.0 blue:255/255.0 alpha:1].CGColor),
                                (id)([UIColor colorWithRed:91/255.0 green:233/255.0 blue:205/255.0 alpha:1].CGColor),
                                (id)([UIColor colorWithRed:146/255.0 green:249/255.0 blue:228/255.0 alpha:1].CGColor),
                                ];

        gradientLayer.startPoint =CGPointMake(0.5,0);
        gradientLayer.endPoint =CGPointMake(0.5,1);
        gradientLayer.borderWidth  =0.0;
        gradientLayer.position = CGPointMake(kScreenWidth()/2, 175/2);
        [self.layer addSublayer:gradientLayer];
        
        self.gradientLayer = gradientLayer;
        
        
    }
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
//    self.gradientLayer.bounds = self.bounds;
//    self.gradientLayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
}



@end
