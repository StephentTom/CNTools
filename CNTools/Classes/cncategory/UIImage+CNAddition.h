//
//  UIImage+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/15.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (CNAddition)

/// 根据iamge返回一个圆形的头像
/// @param iconImage 要切割的图片
/// @param border 边框的宽度
/// @param color 边框的颜色
+ (UIImage *)cn_captureCircleImageWithImage:(UIImage *)iconImage
                              andBorderWith:(CGFloat)border andBorderColor:(nullable UIColor *)color;


/// 生成毛玻璃效果的图片
/// @param blurAmount 模糊化指数
- (UIImage *)cn_blurredImage:(CGFloat)blurAmount;


/// 设置图片的颜色
/// @param tintColor 颜色
/// @param imageSize 图片size
- (UIImage *)cn_tintColor:(UIColor *)tintColor
                imageSize:(CGSize)imageSize;




@end

NS_ASSUME_NONNULL_END
