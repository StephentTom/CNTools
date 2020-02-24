//
//  UITableViewCell+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UITableViewCell+CNAddition.h"
#import <objc/runtime.h>


@implementation UITableViewCell (CNAddition)

/// 设置cell右侧箭头
- (void)setCn_rightArrowImage:(UIImage *)cn_rightArrowImage {
    if (cn_rightArrowImage == nil) { return; }
    
    objc_setAssociatedObject(self, @selector(cn_rightArrowImage), cn_rightArrowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:cn_rightArrowImage];
    self.accessoryView = accessoryView;
}
- (UIImage *)cn_rightArrowImage {
    return objc_getAssociatedObject(self, @selector(cn_rightArrowImage));
}

/// 设置tableViewCell分割线左侧, 右侧间距(默认置顶)
- (void)cn_setCellSeparatorInsets:(UIEdgeInsets)insets {
    if([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.superview;
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:insets];
        }
        
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [tableView setLayoutMargins:insets];
        }
    }
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:insets];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:insets];
    }
}

@end
