//
//  UITextView+Addition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UITextView+CNAddition.h"
#import <objc/runtime.h>


@interface UITextView ()
// 标记是否添加通知
@property(nonatomic, assign) BOOL cn_addNoti;
@property (nonatomic, weak) UILabel *cn_placeholderLable;
@end

@implementation UITextView (Addition)


#pragma mark - runtime添加属性
// 标记是否添加通知
- (void)setCn_addNoti:(BOOL)cn_addNoti {
    objc_setAssociatedObject(self, @selector(cn_addNoti), [NSNumber numberWithBool:cn_addNoti], OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)cn_addNoti {
    return [objc_getAssociatedObject(self, @selector(cn_addNoti)) boolValue];
}

// 占位文字
- (void)setCn_placeholderText:(NSString *)cn_placeholderText {
    objc_setAssociatedObject(self, @selector(cn_placeholderText), cn_placeholderText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 添加占位Label
    [self insertSubview:self.cn_placeholderLable atIndex:0];
    // 监听文本改变
    [self cn_addTextChangeNotification];
}
- (NSString *)cn_placeholderText {
    return objc_getAssociatedObject(self, @selector(cn_placeholderText));
}

// 占位文字颜色
- (void)setCn_placeholderColor:(UIColor *)cn_placeholderColor {
    objc_setAssociatedObject(self, @selector(cn_placeholderColor), cn_placeholderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 添加占位Label
    [self insertSubview:self.cn_placeholderLable atIndex:0];
}
- (UIColor *)cn_placeholderColor {
    return objc_getAssociatedObject(self, @selector(cn_placeholderColor));
}

// 占位文字字体大小
- (void)setCn_placeholderFont:(UIFont *)cn_placeholderFont {
    objc_setAssociatedObject(self, @selector(cn_placeholderFont), cn_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 添加占位Label
    [self insertSubview:self.cn_placeholderLable atIndex:0];
}
- (UIFont *)cn_placeholderFont {
    return objc_getAssociatedObject(self, @selector(cn_placeholderFont));
}

// 文本限制长度
- (void)setCn_maximumLimit:(NSInteger)cn_maximumLimit {
    objc_setAssociatedObject(self, @selector(cn_maximumLimit), @(cn_maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    // 设置限制长度属性时, 监听文本改变通知
    [self cn_addTextChangeNotification];
}
- (NSInteger)cn_maximumLimit {
    return [objc_getAssociatedObject(self, @selector(cn_maximumLimit)) integerValue];
}

#pragma mark - 创建UITextView
+ (UITextView *)textViewWithTextColor:(nullable UIColor *)textColor font:(CGFloat)font {
    
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = textColor? textColor : [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:font];
    
    return textView;
}

#pragma mark - 监听文字改变通知
- (void)cn_addTextChangeNotification {
    if (self.cn_maximumLimit <= 0) {
        self.cn_maximumLimit = MAXFLOAT;
    }
    
    if (self.cn_addNoti == NO) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cn_textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.cn_addNoti = YES;
}
- (void)cn_textDidChange {
    if (self.cn_maximumLimit > 0) {
        if (self.text.length > self.cn_maximumLimit) {
            self.text = [self.text substringToIndex:self.cn_maximumLimit];
        }
    }
    
    self.cn_placeholderLable.hidden = self.text.length > 0? YES : NO;
}

#pragma mark - Private Method
- (UILabel *)cn_placeholderLable {
    UILabel *placeholderLabel = objc_getAssociatedObject(self, @selector(cn_placeholderLable));
    
    if (placeholderLabel == nil) {
        placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 8.0f, self.frame.size.width - 8.0*2, 0)];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.userInteractionEnabled = NO;
        
        objc_setAssociatedObject(self, @selector(cn_placeholderLable), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 设置占位文字属性
    placeholderLabel.font = self.cn_placeholderFont? self.cn_placeholderFont : self.font;
    placeholderLabel.textColor = self.cn_placeholderColor? self.cn_placeholderColor : [UIColor lightGrayColor];
    placeholderLabel.text = self.cn_placeholderText;
    [placeholderLabel sizeToFit];
    
    return placeholderLabel;
}


#pragma mark -
- (void)dealloc {
    if(self.cn_addNoti == YES) {
       [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}
@end
