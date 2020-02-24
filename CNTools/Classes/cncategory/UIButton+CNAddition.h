//
//  UIButton+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/12.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片、文字相对位置

 - CNButtonLayoutStatus: 默认
 - CNButtonLayoutStatus: 图右字左
 - CNButtonLayoutStatus: 图上字下
 - CNButtonLayoutStatus: 图下字上
 */
typedef NS_ENUM(NSUInteger, CNButtonLayoutStatus) {
    CNButtonLayoutStatusNormal,
    CNButtonLayoutStatusImageRight,
    CNButtonLayoutStatusImageTop,
    CNButtonLayoutStatusImageBottom,
};


@interface UIButton (CNAddition)

#pragma mark - 创建UIButton
/// 创建没有设置frame的button
/// @param title 按钮标题
/// @param color 标题颜色
/// @param font 文本字体大小
/// @param backgroundColor 按钮背景颜色
+ (UIButton *)cn_buttonWithTitle:(NSString *)title
                   titleColor:(nullable UIColor *)color
                         font:(CGFloat)font
              backgroundColor:(nullable UIColor *)backgroundColor
                       target:(nullable id)target
                       action:(nullable SEL)action;


/// 创建设置frame的button
/// @param frame 按钮frame
/// @param title 按钮标题
/// @param color 标题颜色
/// @param font 文本字体大小
/// @param backgroundColor 按钮背景颜色
+ (UIButton *)cn_buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleColor:(nullable UIColor *)color
                         font:(CGFloat)font
              backgroundColor:(nullable UIColor *)backgroundColor
                       target:(nullable id)target
                       action:(nullable SEL)action;



/// 创建图片button
/// @param iconString 正常图片名
/// @param selIconString 选中后图片名
+ (UIButton *)cn_buttonWithIconString:(NSString *)iconString
                     selIconString:(nullable NSString *)selIconString
                            target:(nullable id)target
                            action:(nullable SEL)action;


/// 创建文字+图片
/// @param title 按钮标题
/// @param color 标题颜色
/// @param iconString 正常图片名
+ (UIButton *)cn_buttonWithTitle:(NSString *)title
                   titleColor:(nullable UIColor *)color
                         font:(CGFloat)font
                   iconString:(NSString *)iconString
                       target:(nullable id)target
                       action:(nullable SEL)action;


#pragma mark - 设置图片、文字相对位置
/// 设置图片、文字位置
/// @param status 图片的位置
/// @param margin 图片和文字的间隔
- (void)cn_buttonLayoutWithStatus:(CNButtonLayoutStatus)status
                  margin:(CGFloat)margin;


#pragma mark - 设置圆角
- (void)cn_buttonRadius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
