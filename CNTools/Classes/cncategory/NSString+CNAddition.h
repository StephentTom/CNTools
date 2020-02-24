//
//  NSString+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/12.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CNAddition)

/// md5加密
- (NSString *)cn_md5;

/// 是否符合邮箱
- (BOOL)cn_isEmail;

/// 是否符合URL
- (BOOL)cn_isURL;

/// 是否符合手机号
- (BOOL)cn_isPhone;

/// 字符串是否为空
- (BOOL)cn_isEmpty;

@end

NS_ASSUME_NONNULL_END
