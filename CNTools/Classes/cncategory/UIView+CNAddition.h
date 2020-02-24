//
//  UIView+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CNAddition)

#pragma mark - frame相关属性
/** view.width */
@property(nonatomic, assign) CGFloat cn_width;
/** view.height */
@property(nonatomic, assign) CGFloat cn_height;
/** view.size */
@property(nonatomic, assign) CGSize cn_size;
/** view.origin.x */
@property(nonatomic, assign) CGFloat cn_x;
/** view.origin.y */
@property(nonatomic, assign) CGFloat cn_y;
/** view.center.x */
@property (nonatomic, assign) CGFloat cn_centerX;
/** view.center.y */
@property (nonatomic, assign) CGFloat cn_centerY;
/** view.origin */
@property (nonatomic, assign) CGPoint cn_origin;


#pragma mark - 圆角
/// 设置四角圆角 无设置边框
/// @param radius 圆角半径
/// @param cornerBgColor 圆角背景色,必填项 需要与当前控件的父视图背景颜色相同(默认whiteColor)
- (void)cn_cornerRadius:(CGFloat)radius
            cornerBgColor:(UIColor *)cornerBgColor;

/// 设置四角圆角 有边框 虚线/实线
/// @param radius 圆角半径
/// @param borderWidth 边框
/// @param borderColor 边框颜色(默认clearColor)
/// @param cornerBgColor 圆角背景色,必填项 需要与当前控件的父视图背景颜色相同(默认whiteColor)
- (void)cn_cornerRadius:(CGFloat)radius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor isDashPattern:(BOOL)isDashPattern
            cornerBgColor:(UIColor *)cornerBgColor;


/// 设置指定某个角圆角
/// @param roundCorner 圆角类型
/// @param radius 圆角半径
/// @param borderWidth 边框
/// @param borderColor 边框颜色(默认clearColor)
/// @param cornerBgColor 圆角背景色,必填项 需要与当前控件的父视图背景颜色相同(默认whiteColor)
- (void)cn_roundingCorner:(UIRectCorner)roundCorner
                   radius:(CGFloat)radius
              borderWidth:(CGFloat)borderWidth
              borderColor:(nullable UIColor *)borderColor
              cornerBgColor:(UIColor *)cornerBgColor;


/// 截取某个范围内的图像
/// @param rect 需要截取的尺寸
- (UIImage *)cn_screenshotsAtFrame:(CGRect)rect
           savedPhotosAlbumHandler:(void(^ _Nullable)(UIImage *image, NSError * error))handle;

@end

NS_ASSUME_NONNULL_END
