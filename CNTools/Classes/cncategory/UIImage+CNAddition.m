//
//  UIImage+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/15.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UIImage+CNAddition.h"
#import <Accelerate/Accelerate.h>


@implementation UIImage (CNAddition)


#pragma mark - 对外函数
/// 根据iamge返回一个圆形的头像
/// @param iconImage 要切割的图片
/// @param border 边框的宽度
/// @param color 边框的颜色
+ (UIImage *)cn_captureCircleImageWithImage:(UIImage *)iconImage
                              andBorderWith:(CGFloat)border andBorderColor:(nullable UIColor *)color {
    CGFloat imageW = iconImage.size.width + border * 2;
    CGFloat imageH = iconImage.size.height + border * 2;
    imageW = MIN(imageH, imageW);
    imageH = imageW;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    //新建一个图形上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (color) { [color set]; }
    //画大圆
    CGFloat bigRadius = imageW * 0.5;
    CGFloat centerX = imageW * 0.5;
    CGFloat centerY = imageH * 0.5;
    CGContextAddArc(ctx,centerX , centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    //画小圆
    CGFloat smallRadius = bigRadius - border;
    CGContextAddArc(ctx , centerX , centerY , smallRadius ,0, M_PI * 2, 0);
    //切割
    CGContextClip(ctx);
    //画图片
    [iconImage drawInRect:CGRectMake(border, border, iconImage.size.width, iconImage.size.height)];
    //从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}





/// 生成毛玻璃效果的图片
/// @param blurAmount 模糊化指数
- (UIImage *)cn_blurredImage:(CGFloat)blurAmount {
    if (blurAmount < 0.0 || blurAmount > 2.0) {
        blurAmount = 0.5;
    }
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    int boxSize = blurAmount * 40;
    boxSize = boxSize - (boxSize % 2) + 1;
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (!error)
    {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}


/// 设置图片的颜色
/// @param tintColor 颜色
/// @param imageSize 图片size
- (UIImage *)cn_tintColor:(UIColor *)tintColor
                imageSize:(CGSize)imageSize {
    
    CGRect drawRect = CGRectMake(0.0f, 0.0f, imageSize.width == 0.0? self.size.width : imageSize.width, imageSize.height == 0.0 ? self.size.height : imageSize.height);

    UIGraphicsBeginImageContextWithOptions(CGSizeEqualToSize(imageSize, CGSizeZero)? self.size : imageSize, false, self.scale);
    [tintColor setFill];
    UIRectFill(drawRect);
    [self drawInRect:drawRect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
