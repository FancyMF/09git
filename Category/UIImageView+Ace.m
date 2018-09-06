//
//  UIImageView+Ace.m
//  Huolala
//
//  Created by ace.peng on 16/6/25.
//  Copyright © 2016年 huolala. All rights reserved.
//

#import "UIImageView+Ace.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Ace)

/// 加载本地图片（透明度渐变）
- (void)animationSetImageWithName:(NSString *)imageName{
    UIImage* image = [UIImage imageNamed:imageName];
    self.image = image;
    self.alpha = 0.1;
    kSelfWeak;
    [UIView animateWithDuration:kAnimateInterval animations:^{
        weakSelf.alpha = 1.0;
    } completion:nil];
}

- (void)setImageWithUrl:(NSString *)url placeHolderImage:(NSString *)imageName completion:(void (^)(UIImage *))completion
{
    [self setImageWithUrl:url placeHolderImage:imageName animation:NO completion:completion];
}

- (void)animationSetImageWithUrl:(NSString *)url placeHolderImage:(NSString *)imageName completion:(void (^)(UIImage *))completion{
    [self setImageWithUrl:url placeHolderImage:imageName animation:YES completion:completion];
}

- (void)setImageWithUrl:(NSString *)url placeHolderImage:(NSString *)imageName animation:(BOOL)animate completion:(void (^)(UIImage *))completion{
    if (animate) {
        self.alpha = 0.1;
    }
    
    kSelfWeak;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (animate) {
            [UIView animateWithDuration:kAnimateInterval animations:^{
                weakSelf.alpha = 1.0;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion(image);
                }
            }];
        }
    }];
}


@end
