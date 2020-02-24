//
//  UIViewController+CNAddition.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CNAddition)

#pragma mark - AlertStyle
/// 显示alert 只显示一个确定/取消按钮
/// @param title 提示框title
/// @param message 提示框消息
/// @param sureTitle 确定/取消
/// @param handler 点击 确定/取消 回调
- (void)cn_alertControllerWithTitle:(NSString *)title
                            message:(NSString *)message sureActionTitle:(NSString *)sureTitle
                            handler:(void (^ _Nullable)(void))handler;


/// 显示alert 显示一个 取消 ` 确定 按钮, 可修改取消`确定按钮文字颜色
/// @param title 提示框title
/// @param message 提示框消息
/// @param cancelTitle 取消title
/// @param sureTitle 确定title
/// @param cancelTitleColor 取消title颜色
/// @param sureTitleColor 确定title颜色
/// @param cancelHandler 点击 取消 回调
/// @param sureHandler 点击 确定 回调
- (void)cn_alertControllerWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelActionTitle:(NSString *)cancelTitle
                    sureActionTitle:(NSString *)sureTitle
                   cancelTitleColor:(nullable UIColor *)cancelTitleColor
                     sureTitleColor:(nullable UIColor *)sureTitleColor
                        cancelHandler:(void (^ _Nullable)(void))cancelHandler
                        sureHandler:(void (^ _Nullable)(void))sureHandler;


#pragma mark - SheetStyle
/// 显示sheet
/// @param title 提示框title
/// @param message 提示框消息
/// @param actionTitles actions的title
/// @param cancelTitle 取消title
/// @param cancelHandler 点击 取消 回调
/// @param othersHandler actions的 回调
- (void)cn_sheetControllerWithTitle:(nullable NSString *)title
                            message:(nullable NSString *)message
                       actionTitles:(NSArray<NSString *> * _Nullable)actionTitles
                        cancelTitle:(NSString *)cancelTitle
                      cancelHandler:(void (^ _Nullable)(void))cancelHandler
                      othersHandler:(void (^ _Nullable)(UIAlertAction * _Nonnull alertAction, NSInteger index))othersHandler;
@end

NS_ASSUME_NONNULL_END
