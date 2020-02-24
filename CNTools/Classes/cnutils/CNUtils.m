//
//  CNUtils.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "CNUtils.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHPhotoLibrary.h>


@implementation CNUtils

/// 是否空字符串
/// @param string 字符串值
+ (BOOL)cn_isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

/// 移除字符串中的空格和换行
/// @param string 字符串值
+ (NSString *)cn_removeSpaceAndNewline:(NSString *)string {
    NSString *tempString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return tempString;
}

/// 随机颜色
+ (UIColor *)cn_getRandomColor {
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

/// json转NSString
/// @param object 数据源(json字符串)
+ (NSString *)cn_dataTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                options:NSJSONWritingPrettyPrinted error:&error];
    
    NSAssert(jsonData != nil, @"JSON串转NSString失败");
    
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

/// 将JSON串转化为NSDictionary
/// @param jsonString json串
+ (NSDictionary *)cn_jsonStrToDict:(NSString *)jsonString {
    if ([CNUtils cn_isBlankString:jsonString]) {
        return nil;
    }
    
    NSError *error;
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSAssert(data != nil, @"将JSON串转化为NSDictionary失败");
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return dic;
}

#pragma mark - 键盘
/// 统一关闭键盘
+ (void)cn_closeKeyboard {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    // 或者 [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 时间转换
+ (NSString *)cn_timeStrWithMsTime:(NSTimeInterval)msTime {
    return [self cn_timeStrWithSecTime:msTime / 1000];
}
+ (NSString *)cn_timeStrWithSecTime:(NSTimeInterval)secTime {
    NSInteger time = (NSInteger)secTime;
    
    if (time / 3600 > 0) { // 时分秒
        NSInteger hour   = time / 3600;
        NSInteger minute = (time % 3600) / 60;
        NSInteger second = (time % 3600) % 60;
        
        return [NSString stringWithFormat:@"%02zd:%02zd:%02zd", hour, minute, second];
    } else { // 分秒
        NSInteger minute = time / 60;
        NSInteger second = time % 60;
        
        return [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    }
}

#pragma mark - 其他
/// 获取当前屏幕显示的UIViewController
+ (UIViewController *)cn_getCurrentController {
    UIViewController *result = nil;
    UIWindow* window = nil;
     
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;

                break;
            }
        }
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    if ([window subviews].count>0) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            result = nextResponder;
        }
        else{
            result = window.rootViewController;
        }
    }
    else{
        result = window.rootViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [((UITabBarController*)result) selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [((UINavigationController*)result) visibleViewController];
    }
    
    return result;
}
+ (void)cn_showAlert:(NSString *)mediaType superController:(UIViewController *)superController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您尚未开启%@权限，立即开启?",mediaType] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    
    [superController presentViewController:alert animated:YES completion:nil];
}
@end
