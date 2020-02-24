//
//  CNCountdown.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/15.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCountdown : NSObject

/// 单例对像
+ (instancetype)cn_countdown;

/// 开启倒计时
/// @param totalTime 需要倒计时的时长，单位秒
/// @param callback 倒计时block，里面返回的是剩余时长，单位秒
- (void)cn_beginCountdown:(NSInteger)totalTime
                 callback:(void(^)(NSInteger duration))callback;

/// 取消定时器
- (void)cn_cancelCountdown;

@end

NS_ASSUME_NONNULL_END
