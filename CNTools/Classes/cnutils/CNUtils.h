//
//  CNUtils.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface CNUtils : NSObject

#pragma mark - 字符串
/// 是否空字符串
/// @param string 字符串值
+ (BOOL)cn_isBlankString:(NSString *)string;

/// 移除字符串中的空格和换行
/// @param string 字符串值
+ (NSString *)cn_removeSpaceAndNewline:(NSString *)string;

#pragma mark - 颜色
/// 随机颜色
+ (UIColor *)cn_getRandomColor;

#pragma mark - 转换
/// json转NSString
/// @param object 数据源(json字符串)
+ (NSString *)cn_dataTOjsonString:(id)object;

/// 将JSON串转化为NSDictionary
/// @param jsonString json串
+ (NSDictionary *)cn_jsonStrToDict:(NSString *)jsonString;

#pragma mark - 键盘
/// 统一关闭键盘
+ (void)cn_closeKeyboard;

#pragma mark - 秒->时间字符串
/// 毫秒转时间字符串
+ (NSString *)cn_timeStrWithMsTime:(NSTimeInterval)msTime;
/// 秒转时间字符串
+ (NSString *)cn_timeStrWithSecTime:(NSTimeInterval)secTime;

#pragma mark - 其他
/// 获取当前屏幕显示的UIViewController
+ (UIViewController *)cn_getCurrentController;

@end

NS_ASSUME_NONNULL_END
