//
//  UIViewController+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UIViewController+CNAddition.h"


@implementation UIViewController (CNAddition)


#pragma mark - AlertStyle
- (void)cn_alertControllerWithTitle:(NSString *)title
                            message:(NSString *)message sureActionTitle:(NSString *)sureTitle
                            handler:(void (^ _Nullable)(void))handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) { handler(); }
    }];
    [alertController addAction:sureAction];

    [self presentViewController:alertController animated:true completion:nil];
}

- (void)cn_alertControllerWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelActionTitle:(NSString *)cancelTitle
                    sureActionTitle:(NSString *)sureTitle
                   cancelTitleColor:(nullable UIColor *)cancelTitleColor
                     sureTitleColor:(nullable UIColor *)sureTitleColor
                      cancelHandler:(void (^ _Nullable)(void))cancelHandler
                        sureHandler:(void (^ _Nullable)(void))sureHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandler) { cancelHandler(); }
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureHandler) { sureHandler(); }
    }];
    
    if (cancelTitle && cancelTitleColor) {
        [cancelAction setValue:cancelTitleColor forKey:@"titleTextColor"];
    }
    if (sureTitle && sureTitleColor) {
        [sureAction setValue:sureTitleColor forKey:@"titleTextColor"];
    }
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - SheetStyle
- (void)cn_sheetControllerWithTitle:(nullable NSString *)title
                            message:(nullable NSString *)message
                       actionTitles:(NSArray<NSString *> * _Nullable)actionTitles
                        cancelTitle:(NSString *)cancelTitle
                      cancelHandler:(void (^ _Nullable)(void))cancelHandler
                            othersHandler:(void (^ _Nullable)(UIAlertAction * _Nonnull alertAction, NSInteger index))othersHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

    for (NSString *actionTitle in actionTitles) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (othersHandler) {
                othersHandler(action, [actionTitles indexOfObject:action.title]);
            }
        }];
        [alertController addAction:alertAction];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandler) {
            cancelHandler();
        }
    }];
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

@end
