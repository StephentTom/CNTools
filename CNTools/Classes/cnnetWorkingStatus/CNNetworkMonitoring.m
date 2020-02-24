//
//  CNNetworkMonitoring.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/15.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNNetworkMonitoring.h"
#import "Reachability.h"


@interface CNNetworkMonitoring ()
@property(nonatomic, copy) void(^networkStatusHandler)(CNNetworkStatus networkStatus);
@property(nonatomic, strong) Reachability *reachability;
@property(nonatomic, strong) UIAlertController *alertController;
@end


@implementation CNNetworkMonitoring

/// 网络监控单例
+ (instancetype)cn_networkMonitoring {
    static dispatch_once_t onceToken;
    static CNNetworkMonitoring *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[CNNetworkMonitoring alloc] init];
    });
    return _instance;
}

/// 当前网络状态
- (CNNetworkStatus)cn_networkStatus {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    return [self cn_networkWithReachability: reachability];
}

/// 开启网络监听
- (void)cn_startNetworkConnectionListening {
    self.cn_networkChangedAlert = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cn_networkConnectionChanged) name:kReachabilityChangedNotification object:nil];
    
    if(_reachability == nil) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    [_reachability startNotifier];
}

/// 网络连接状态改变后的block事件
- (void)cn_networkConnectionChanged:(void(^)(CNNetworkStatus networkStatus))networkStatusHandler {
    self.cn_networkChangedAlert = NO;
    _networkStatusHandler = networkStatusHandler;
}

/// 移除网络连接监听
- (void)cn_removeNetworkConnectionListening {
    [_reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    _reachability = nil;
    _alertController = nil;
}


#pragma mark - 通知
- (void)cn_networkConnectionChanged {
    [self cn_networkWithReachability:_reachability];
    [self cn_dismissAlertAction];
    [self performSelector:@selector(cn_pushAlertAction) withObject:nil afterDelay:2];
}

#pragma mark - Private Method
- (CNNetworkStatus)cn_networkWithReachability:(Reachability *)reachability {
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    switch (internetStatus) {
        case ReachableViaWiFi:
            return NetworkStatusWiFi;
            break;
            
        case ReachableViaWWAN:
            return [self cn_mobileParse];
            break;
            
        case NotReachable:
            return NetworkStatusNotReachable;
            
        default:
            return NetworkStatusUnknown;
            break;
    }
}
- (CNNetworkStatus)cn_mobileParse {
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *statusBar = [[[application valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"] subviews];
    for (id statusBarType in statusBar) {
        if ([statusBarType isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            switch ([[statusBarType valueForKeyPath:@"dataNetworkType"]intValue]) {
                case 0:
                    return NetworkStatusNotReachable;
                    break;
                case 1:
                    return NetworkStatusWWAN2G;
                    break;
                case 2:
                    return NetworkStatusWWAN3G;
                    break;
                case 3:
                    return NetworkStatusWWAN4G;
                    break;
                case 5:
                    return NetworkStatusWiFi;
                    break;
                default:
                    return NetworkStatusUnknown;
                    break;
            }
        }
    }
    return NetworkStatusUnknown;
}


#pragma mark - AlerController
- (void)cn_pushAlertAction {
    CNNetworkStatus currentNetworkStatus = [self cn_networkStatus];
    
    if(_networkStatusHandler) {
        _networkStatusHandler(currentNetworkStatus);
    }
    
    if(self.cn_networkChangedAlert == NO) return;
       
    if (currentNetworkStatus == NetworkStatusNotReachable ||
        currentNetworkStatus == NetworkStatusUnknown) {
        if(self.alertController == nil) {
            self.alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"抱歉，请监测您的网络" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
            [_alertController addAction:action];
        }
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.alertController animated:YES completion:nil];
    }
}

- (void)cn_dismissAlertAction {
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
}
@end
