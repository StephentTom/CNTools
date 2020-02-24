//
//  UILabel+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/12.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UILabel+CNAddition.h"
#import <objc/runtime.h>


@implementation UILabel (CNAddition)

+ (void)load {
    SEL method_name_1 = @selector(textRectForBounds:limitedToNumberOfLines:);
    SEL method_name_2 = @selector(cn_textRectForBounds:cn_limitedToNumberOfLines:);
    method_exchangeImplementations(class_getInstanceMethod(self.class, method_name_1), class_getInstanceMethod(self.class, method_name_2));
    
    
    SEL draw_method_name_1 = @selector(drawTextInRect:);
    SEL draw_method_name_2 = @selector(cn_drawTextInRect:);
    method_exchangeImplementations(class_getInstanceMethod(self.class, draw_method_name_1), class_getInstanceMethod(self.class, draw_method_name_2));
}

#pragma mark - runtime添加属性
- (void)setCn_textInsets:(UIEdgeInsets)cn_textInsets {
    NSArray *textInsets = @[@(cn_textInsets.top),@(cn_textInsets.left),@(cn_textInsets.bottom),@(cn_textInsets.right)];
    objc_setAssociatedObject(self, @selector(cn_textInsets), textInsets, OBJC_ASSOCIATION_RETAIN);
}
- (UIEdgeInsets)cn_textInsets {
    NSArray *textInsets = objc_getAssociatedObject(self, @selector(cn_textInsets));
    return UIEdgeInsetsMake([textInsets[0] floatValue], [textInsets[1] floatValue], [textInsets[2] floatValue], [textInsets[3] floatValue]);
}


#pragma mark - 黑魔法替换方法 自定义方法
- (CGRect)cn_textRectForBounds:(CGRect)bounds cn_limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [self cn_textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.cn_textInsets) cn_limitedToNumberOfLines:numberOfLines];
    
    // 根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.cn_textInsets.left;
    rect.origin.y -= self.cn_textInsets.top;
    rect.size.width += self.cn_textInsets.left + self.cn_textInsets.right;
    rect.size.height += self.cn_textInsets.top + self.cn_textInsets.bottom;
    
    return rect;
}
// 绘制文字
- (void)cn_drawTextInRect:(CGRect)rect {
    [self cn_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.cn_textInsets)];
}
                                   
#pragma mark - 创建UIlabel
/// 创建没有设置frame的label
+ (UILabel *)cn_labelWithText:(nullable NSString *)text
                 textColor:(UIColor *)color
                 alignment:(NSTextAlignment)textAlignment
                      font:(CGFloat)font
                    isBold:(BOOL)isBold {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    
    if (isBold) {
        label.font = [UIFont boldSystemFontOfSize:font];
    } else {
        label.font = [UIFont systemFontOfSize:font];
    }
    return label;
}

/// 创建设置frame的label
+ (UILabel *)cn_labelWithFrame:(CGRect)frame
                       text:(nullable NSString *)text
                  textColor:(UIColor *)color
                  alignment:(NSTextAlignment)textAlignment
                       font:(CGFloat)font isBold:(BOOL)isBold {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    
    if (isBold) {
        label.font = [UIFont boldSystemFontOfSize:font];
    } else {
        label.font = [UIFont systemFontOfSize:font];
    }
    return label;
}

@end
