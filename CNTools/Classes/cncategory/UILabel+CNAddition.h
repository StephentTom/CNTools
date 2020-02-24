//
//  UILabel+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/12.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CNAddition)


/** 设置标签文本距离边框的边距 */
@property (nonatomic, assign) UIEdgeInsets cn_textInsets;


#pragma mark - 创建UIlabel
/// 创建没有设置frame的label
/// @param text 文本
/// @param color 文本颜色
/// @param textAlignment 文本对齐方式
/// @param font 文字字体d大小
/// @param isBold 是否显示粗字体
+ (UILabel *)cn_labelWithText:(nullable NSString *)text textColor:(UIColor *)color alignment:(NSTextAlignment)textAlignment font:(CGFloat)font isBold:(BOOL)isBold;


/// 创建设置frame的label
/// @param frame 尺寸
/// @param text 文本
/// @param color 文本颜色
/// @param textAlignment 文本对齐方式
/// @param font 文字字体d大小
/// @param isBold 是否显示粗字体
+ (UILabel *)cn_labelWithFrame:(CGRect)frame
                       text:(nullable NSString *)text
                  textColor:(UIColor *)color
            alignment:(NSTextAlignment)textAlignment
                       font:(CGFloat)font isBold:(BOOL)isBold;

@end

NS_ASSUME_NONNULL_END
