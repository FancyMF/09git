//
//  UIImage+Handle.m
//

#import "UIImage+Handle.h"

@implementation UIImage (Handle)

/**
 *  返回一张纯色片可以圆角的图片
 *
 *  @param color            指定的颜色
 *  @param cornerRadius     指定的圆角数据
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    CGFloat minEdgeSize = cornerRadius * 2 + 1;
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)colorImageWithColor:(UIColor *)color{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextDrawImage(context, rect, self.CGImage);

    CGContextClipToMask(context, rect, self.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImg;
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color{
    UIImage *img = [UIImage imageNamed:name];
    if (!img)
        return nil;
    UIImage* coloredImg = [img colorImageWithColor:color];
    return coloredImg;
}


- (UIImage *)cropImageInRect:(CGRect )rect{
    CGImageRef cgImage = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *img = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return img;
}

- (instancetype)circleImageWithCornerRadius:(CGFloat)cornerRadius
{
    if (!self) {
        return self;
    }
    cornerRadius = MAX(cornerRadius, 0);
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:MIN(cornerRadius, self.size.height/2)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)resizeImageToWidth:(float )width{
    CGSize reSize;
    CGSize imageSize = self.size;
    reSize = CGSizeMake(width, imageSize.height*(width/imageSize.width));
    UIGraphicsBeginImageContext(reSize);
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

- (UIImage *)maskImageWithColor:(UIColor *)maskColor{
    UIImage* maskImage = [UIImage imageWithColor:maskColor andSize:self.size];
    return [self maskImageWithMask:maskImage];
}

- (UIImage *)maskImageWithMask:(UIImage *)maskImage{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef masked = CGImageCreateWithMask([self CGImage], mask);
    
    UIImage* resultImage = [UIImage imageWithCGImage:masked];
    
    CFRelease(mask);
    CFRelease(masked);
    
    return resultImage;
}

- (UIImage *)rotateImageWithDegree:(CGFloat)degree{
    CGImageRef imageRef = self.CGImage;
    CGFloat width = CGImageGetWidth(imageRef);
    CGFloat height = CGImageGetHeight(imageRef);
    CGSize rotatedSize;
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degree * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), imageRef);
    UIImage* expectedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return expectedImage;
}

- (UIImage *)rotateImageWithRightAndle:(NSUInteger)count{
    if (count == 0){
        return self;
    }
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    CGSize originSize = CGSizeMake(width, height);
    CGSize rotatedSize;
    if (count%2 == 1) // 奇数，宽高颠倒
    {
        CGFloat cacheWidth = width;
        width = height;
        height = cacheWidth;
    }

    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(originSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(bitmap, count * M_PI / 2);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* expectedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return expectedImage;
}

+ (UIImage*)imageForImages:(NSArray<UIImage*>*)images andHorizontal:(BOOL)isHorizontal{
    
    if (images.count == 0) {
        return nil;
    }
    
    UIImage* targetImage = nil;
    
    CGFloat targetWidth,targetHeight = 0.0;
    UIImage* firstImage = [images firstObject];
    CGFloat firstWidth = firstImage.size.width;
    CGFloat firstHeight = firstImage.size.height;
    CGFloat count = images.count;
    if (isHorizontal) {
        targetWidth = firstWidth * count;
        targetHeight = firstHeight;
        
    }else{
        targetWidth = firstWidth;
        targetHeight = firstHeight * count;
    }
    
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    
    UIGraphicsBeginImageContext(targetSize);
    
    for (UIImage* image in images) {
        NSInteger index = [images indexOfObject:image];
        CGRect targetRect = CGRectZero;
        if (isHorizontal) {
            targetRect = CGRectMake(firstWidth * index, 0, firstWidth, firstHeight);
        }else{
            targetRect = CGRectMake(0, firstHeight * index, firstWidth, firstHeight);
        }
        [image drawInRect:targetRect];
    }
    
    targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}

@end
