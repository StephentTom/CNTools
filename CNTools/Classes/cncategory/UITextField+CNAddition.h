//
//  UITextField+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CNAddition)


/// 文本最大支持多少个字符，设置后会自动根据该属性截取文本字符长度
@property (nonatomic, assign) NSInteger cn_maximumLimit;
/// 是否禁止复制粘贴 默认允许
@property (nonatomic, assign) BOOL cn_allowCopyPaste;

#pragma mark - 创建TextField
/// 创建没有设置frame的textField 安全属性设置
/// @param secureText 是否需要安全显示
/// @param placeholder 占位文本
/// @param placeholderColor 占位文本颜色
/// @param placeholderFontSize 占位文本字体大小
/// @param textFontSize 文本字体大小
/// @param textColor 文本颜色
/// @param borderStyle 边框类型
/// @param keyboardType 唤醒的键盘类型
+ (UITextField *)cn_textFieldSecureTextEntry:(BOOL)secureText
                              placeholder:(NSString *)placeholder
                         placeholderColor:(UIColor *)placeholderColor
                      placeholderFontSize:(CGFloat)placeholderFontSize
                             textFontSize:(CGFloat)textFontSize
                                textColor:(UIColor *)textColor
                              borderStyle:(UITextBorderStyle)borderStyle
                             keyboardType:(UIKeyboardType)keyboardType;
@end

NS_ASSUME_NONNULL_END
