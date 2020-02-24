//
//  CNNetworkMonitoring.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/15.
//  Copyright © 2019 Mac mini. All rights reserved.
//  网络监听类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /** 无网络连接 */
    NetworkStatusNotReachable = 0,
    /** 未知网络连接 */
    NetworkStatusUnknown,
    /** 2G网络 */
    NetworkStatusWWAN2G,
    /** 3G网络 */
    NetworkStatusWWAN3G,
    /** 4G网络 */
    NetworkStatusWWAN4G,
    /** WiFi网络 */
    NetworkStatusWiFi
} CNNetworkStatus;

@interface CNNetworkMonitoring : NSObject

/// 当前网络状态
@property(nonatomic, assign, readonly) CNNetworkStatus cn_networkStatus;
/// 网络状态改变后是否需要弹窗警告 默认 YES
@property(nonatomic, assign) BOOL cn_networkChangedAlert;

/// 网络监控单例
+ (instancetype)cn_networkMonitoring;

/// 开启网络监听
- (void)cn_startNetworkConnectionListening;

/// 网络连接状态改变后的block事件 调用后将设置networkChangedAlert为NO
- (void)cn_networkConnectionChanged:(void(^)(CNNetworkStatus networkStatus))networkStatusHandler;

/// 移除网络连接监听
- (void)cn_removeNetworkConnectionListening;

@end

NS_ASSUME_NONNULL_END
