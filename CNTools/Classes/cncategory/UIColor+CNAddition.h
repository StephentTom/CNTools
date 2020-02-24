//
//  UIColor+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CNAddition)

/// 十六进制转换成的颜色
/// @param hexColor @"0x333333" @"333333" @"#333333"
+ (UIColor *)cn_hexColor:(NSString *)hexColor;

@end

NS_ASSUME_NONNULL_END
