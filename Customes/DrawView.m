//
//  DrawView.m
//  YTZL
//
//  Created by 侯佩岑 on 2018/3/27.
//  Copyright © 2018年 wzt. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property (nonatomic, strong) CAShapeLayer * shaperLayer;
@property (nonatomic, strong) UIBezierPath * path;
@property (nonatomic, strong) NSMutableArray * layerArray;

@end

@implementation DrawView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layerArray = [NSMutableArray array];
//        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    self.shaperLayer = [CAShapeLayer layer];
    self.shaperLayer.lineWidth = 3;
    self.shaperLayer.strokeColor = [UIColor blackColor].CGColor;
    self.shaperLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.shaperLayer];
    [self.layerArray addObject:self.shaperLayer];
    
    CGPoint starPoint = [[touches anyObject] locationInView:self];
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:starPoint];
    self.shaperLayer.path = self.path.CGPath;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    CGPoint starPoint = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:starPoint];
    self.shaperLayer.path = self.path.CGPath;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    CGPoint starPoint = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:starPoint];
    self.shaperLayer.path = self.path.CGPath;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    CGPoint starPoint = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:starPoint];
    self.shaperLayer.path = self.path.CGPath;
}


-(void)clearAllLayer{
    for (CALayer * layer in self.layerArray) {
        [layer removeFromSuperlayer];
    }
    [self.layerArray removeAllObjects];
}

-(UIImage*)cutTheView{
    if (self.layerArray.count<=0) {
        return nil;
    }
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
