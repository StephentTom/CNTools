//
//  UIButton+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/12.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UIButton+CNAddition.h"


@implementation UIButton (CNAddition)

#pragma mark - 创建UIButton
/// 创建没有设置frame的button
+ (UIButton *)cn_buttonWithTitle:(NSString *)title
                   titleColor:(nullable UIColor *)color
                         font:(CGFloat)font
              backgroundColor:(nullable UIColor *)backgroundColor
                       target:(nullable id)target
                       action:(nullable SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color? color : [UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.backgroundColor = backgroundColor? backgroundColor : [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)cn_buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleColor:(nullable UIColor *)color
                         font:(CGFloat)font
              backgroundColor:(nullable UIColor *)backgroundColor
                       target:(nullable id)target
                       action:(nullable SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color? color : [UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor? backgroundColor : [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


+ (UIButton *)cn_buttonWithIconString:(NSString *)iconString
                     selIconString:(nullable NSString *)selIconString
                            target:(nullable id)target
                            action:(nullable SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:iconString] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    if (selIconString) {
        [button setImage:[UIImage imageNamed:iconString] forState:UIControlStateSelected];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/// 创建文字+图片
/// @param title 按钮标题
/// @param color 标题颜色
/// @param iconString 正常图片名
+ (UIButton *)cn_buttonWithTitle:(NSString *)title
                   titleColor:(nullable UIColor *)color
                         font:(CGFloat)font
                   iconString:(NSString *)iconString
                       target:(nullable id)target
                       action:(nullable SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color? color : [UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:iconString] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


#pragma mark - 设置图片、文字相对位置
- (void)cn_buttonLayoutWithStatus:(CNButtonLayoutStatus)status
                  margin:(CGFloat)margin {
    [self layoutIfNeeded];
    
    CGFloat imgWidth = MIN(self.imageView.image.size.width, self.frame.size.width);
    CGFloat imgHeight = imgWidth * self.imageView.image.size.height / self.imageView.image.size.width;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (labWidth < frameSize.width) {
        labWidth = frameSize.width;
    }
    CGFloat kMargin = margin/2.0;
    
    switch (status) {
        case CNButtonLayoutStatusNormal:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
        case CNButtonLayoutStatusImageRight:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
        case CNButtonLayoutStatusImageTop:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + margin, -labWidth)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + margin, -imgWidth, 0, 0)];
            break;
        case CNButtonLayoutStatusImageBottom:
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + margin, 0, 0, -labWidth)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + margin, 0)];
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置圆角
- (void)cn_buttonRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}
@end
