//
//  LayerView.h
//  myFrame
//
//  Created by 侯佩岑 on 2018/7/23.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientLayerView2 : UIView

/// CGPoint(0~1,0~1)  可取:0, 0.5, 1,
-(void)setStartPoint:(CGPoint)startPoint;
/// CGPoint(0~1,0~1) 可取:0, 0.5, 1,
-(void)setEndPoint:(CGPoint)endPoint;
/// <CGColor>
-(void)setColors:(NSArray <UIColor *> *)colorsArray;



@end
