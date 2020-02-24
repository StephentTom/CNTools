//
//  UITextField+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UITextField+CNAddition.h"
#import <objc/runtime.h>


@interface UITextField ()
// 标记是否添加通知
@property(nonatomic, assign) BOOL cn_addNoti;
@end


@implementation UITextField (CNAddition)

#pragma mark - runtime添加属性
// 标记是否添加通知
- (void)setCn_addNoti:(BOOL)cn_addNoti {
    objc_setAssociatedObject(self, @selector(cn_addNoti), [NSNumber numberWithBool:cn_addNoti], OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)cn_addNoti {
    return [objc_getAssociatedObject(self, @selector(cn_addNoti)) boolValue];
}

// 限制长度属性
- (void)setCn_maximumLimit:(NSInteger)cn_maximumLimit {
    objc_setAssociatedObject(self, @selector(cn_maximumLimit), @(cn_maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    // 设置限制长度属性时, 监听文本改变通知
    [self cn_addTextChangeNotification];
}
- (NSInteger)cn_maximumLimit {
    return [objc_getAssociatedObject(self, @selector(cn_maximumLimit)) integerValue];
}

// 是否禁止复制粘贴
- (void)setCn_allowCopyPaste:(BOOL)cn_allowCopyPaste {
    cn_allowCopyPaste = !cn_allowCopyPaste;
    
    objc_setAssociatedObject(self, @selector(cn_allowCopyPaste), [NSNumber numberWithBool:cn_allowCopyPaste], OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)cn_allowCopyPaste {
    BOOL isAllow = ![objc_getAssociatedObject(self, @selector(cn_allowCopyPaste)) boolValue];
    return isAllow;
}


#pragma mark - 创建TextField
+ (UITextField *)cn_textFieldSecureTextEntry:(BOOL)secureText
                              placeholder:(NSString *)placeholder
                         placeholderColor:(UIColor *)placeholderColor
                      placeholderFontSize:(CGFloat)placeholderFontSize
                             textFontSize:(CGFloat)textFontSize
                                textColor:(UIColor *)textColor
                              borderStyle:(UITextBorderStyle)borderStyle
                             keyboardType:(UIKeyboardType)keyboardType {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = textColor;
    textField.font = [UIFont systemFontOfSize:textFontSize];
    textField.borderStyle = borderStyle;
    textField.keyboardType = keyboardType;
    textField.secureTextEntry = secureText;
    textField.backgroundColor = [UIColor whiteColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:
    @{NSForegroundColorAttributeName: placeholderColor,
      NSFontAttributeName: [UIFont systemFontOfSize:placeholderFontSize]}];
    textField.attributedPlaceholder = attrString;
    
    return textField;
}


#pragma mark - Private Method
/// ++++++  关于限制文本长度 ++++++
- (void)cn_addTextChangeNotification {
    if (self.cn_maximumLimit <= 0) {
        self.cn_maximumLimit = MAXFLOAT;
    }
    
    if (self.cn_addNoti == NO) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cn_textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    self.cn_addNoti = YES;
}
- (void)cn_textDidChange {
    if (self.cn_maximumLimit > 0) {
        if (self.text.length > self.cn_maximumLimit) {
            self.text = [self.text substringToIndex:self.cn_maximumLimit];
        }
    }
}

/// ++++++  关于复制/粘贴操作 ++++++
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // 是否允许剪切
    if (action == @selector(cut:)) return self.cn_allowCopyPaste;
    // 是否允许粘贴
    if (action == @selector(paste:)) return self.cn_allowCopyPaste;
    // 是否允许选择
    if (action == @selector(select:)) return self.cn_allowCopyPaste;
    // 是否允许全选
    if (action == @selector(selectAll:)) return self.cn_allowCopyPaste;
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark -
- (void)dealloc {
    if(self.cn_addNoti == YES) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}
@end
