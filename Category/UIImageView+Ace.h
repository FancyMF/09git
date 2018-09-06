//
//  UIImageView+Ace.h
//  Huolala
//
//  Created by ace.peng on 16/6/25.
//  Copyright © 2016年 huolala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Ace)

/// 加载本地图片（透明度渐变）
- (void)animationSetImageWithName:(NSString *)imageName;

/**
 异步加载图片

 @param url        图片url
 @param imageName  占位图片名
 @param completion 加载完毕的回掉
 */
- (void)setImageWithUrl:(NSString *)url
       placeHolderImage:(NSString*)imageName
             completion:(void(^)(UIImage *image))completion;

/**
 异步加载图片（带透明度渐变效果）
 
 @param url        图片url
 @param imageName  占位图片名
 @param completion 加载完毕的回掉
 */
- (void)animationSetImageWithUrl:(NSString *)url
                placeHolderImage:(NSString*)imageName
                      completion:(void(^)(UIImage *image))completion;

@end
