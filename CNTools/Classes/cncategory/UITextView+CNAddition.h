//
//  UITextView+Addition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Addition)

/// 占位文字
@property(nonatomic, copy) NSString *cn_placeholderText;
/// 占位文字字号
@property(nonatomic, strong) UIFont *cn_placeholderFont;
/// 占位文字颜色
@property(nonatomic, strong) UIColor *cn_placeholderColor;
/// 文本字符长度最大限制长度
@property(nonatomic, assign) NSInteger cn_maximumLimit;

#pragma mark - 创建UITextView
+ (UITextView *)textViewWithTextColor:(nullable UIColor *)textColor font:(CGFloat)font;
@end

NS_ASSUME_NONNULL_END
