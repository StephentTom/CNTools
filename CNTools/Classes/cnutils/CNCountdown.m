//
//  CNCountdown.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/15.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "CNCountdown.h"


@interface CNCountdown ()
/// 定时器
@property (nonatomic) dispatch_source_t cn_timer;
@end


@implementation CNCountdown

/// 单例对像
+ (instancetype)cn_countdown {
    static dispatch_once_t onceToken;
    static CNCountdown *_instace = nil;
    dispatch_once(&onceToken, ^{
        _instace = [[CNCountdown alloc] init];
    });
    return _instace;
}

/// 开启倒计时
- (void)cn_beginCountdown:(NSInteger)totalTime
                 callback:(void(^)(NSInteger duration))callback {
    __block NSInteger timeout = totalTime;
    
    __weak typeof(self) weakSelf = self;
    if (timeout != 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        weakSelf.cn_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(weakSelf.cn_timer, dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(weakSelf.cn_timer, ^{
            if (timeout <= 0) {
                // 倒计时end
                dispatch_source_cancel(weakSelf.cn_timer);
                weakSelf.cn_timer = nil;
            } else {
                timeout--;
                // 返回主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (callback) {
                        callback(timeout);
                    }
                });
            }
        });
        dispatch_resume(weakSelf.cn_timer);
    }
}

/// 取消定时器
- (void)cn_cancelCountdown {
    if (_cn_timer) {
        dispatch_cancel(_cn_timer);
        _cn_timer = nil;
    }
}
@end
