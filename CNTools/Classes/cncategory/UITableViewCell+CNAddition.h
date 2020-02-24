//
//  UITableViewCell+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (CNAddition)

/// 设置tableViewCell自定义右箭头图片
@property (nonatomic, strong) UIImage *cn_rightArrowImage;

/// 设置tableViewCell分割线左侧, 右侧间距(默认置顶)
- (void)cn_setCellSeparatorInsets:(UIEdgeInsets)insets;
@end

NS_ASSUME_NONNULL_END
