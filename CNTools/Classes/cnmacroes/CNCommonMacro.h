//
//  CNCommonMacro.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/12.
//  Copyright © 2019 Mac mini. All rights reserved.
//  公共宏

#ifndef CNCommonMacro_h
#define CNCommonMacro_h

#import <Foundation/Foundation.h>

#pragma mark - 内联函数
/** inline: 内联函数(向编译器提供的申请, 不需要预编译) */

/// 获取手机屏幕size
static inline CGSize CNScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}
/// 获取屏幕比例
static inline CGFloat CNScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}
/// 获取像素点value
static inline CGFloat CGFloatFromPixel(CGFloat value) {
    return value / CNScreenScale();
}

/// 屏幕宽度取相应的CGFloat值
static inline CGFloat CNCustomFont(CGFloat value) {
    /// 以当前手机的宽度作为基准
    CGFloat const kDesignChartWidth = 375.0f;
    
    if ((CNScreenSize().width >= kDesignChartWidth)) {
        return floor(value * CNScreenSize().width/kDesignChartWidth);
    } else {
        return ceil(value * CNScreenSize().width/kDesignChartWidth);
    }
}

#pragma mark - 正常字体宏
#define kcnAppTextFont_9   [UIFont systemFontOfSize:CNCustomFont(9.f)]
#define kcnAppTextFont_10  [UIFont systemFontOfSize:CNCustomFont(10.f)]
#define kcnAppTextFont_11  [UIFont systemFontOfSize:CNCustomFont(11.f)]
#define kcnAppTextFont_12  [UIFont systemFontOfSize:CNCustomFont(12.f)]
#define kcnAppTextFont_13  [UIFont systemFontOfSize:CNCustomFont(13.f)]
#define kcnAppTextFont_14  [UIFont systemFontOfSize:CNCustomFont(14.f)]
#define kcnAppTextFont_15  [UIFont systemFontOfSize:CNCustomFont(15.f)]
#define kcnAppTextFont_16  [UIFont systemFontOfSize:CNCustomFont(16.f)]
#define kcnAppTextFont_17  [UIFont systemFontOfSize:CNCustomFont(17.f)]
#define kcnAppTextFont_18  [UIFont systemFontOfSize:CNCustomFont(18.f)]


#pragma mark - UIColor
#define kcnRGB(r,g,b) [UIColor colorWithRed:(r)/255.f \
                            green:(g)/255.f \
                            blue:(b)/255.f \
                            alpha:1.f]

#define kcnRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.f \
                            green:(g)/255.f \
                            blue:(b)/255.f \
                            alpha:(a)]

#define kcnBlackColor         [UIColor blackColor]
#define kcnDarkGrayColor      [UIColor darkGrayColor]
#define kcnLightGrayColor     [UIColor lightGrayColor]
#define kcnWhiteColor         [UIColor whiteColor]
#define kcnGrayColor          [UIColor grayColor]
#define kcnRedColor           [UIColor redColor]
#define kcnGreenColor         [UIColor greenColor]
#define kcnBlueColor          [UIColor blueColor]
#define kcnCyanColor          [UIColor cyanColor]
#define kcnYellowColor        [UIColor yellowColor]
#define kcnMagentaColor       [UIColor magentaColor]
#define kcnOrangeColor        [UIColor orangeColor]
#define kcnPurpleColor        [UIColor purpleColor]
#define kcnClearColor         [UIColor clearColor]


#pragma mark - Dispatch
// 在主线程上运行
#define kcnDispatchMainThread(mainQueueBlock)             dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// 开启异步线程
#define kcnDispatchGlobalQueueDefault(globalQueueBlock)   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


#pragma mark - NSNotification
/// 通知中心
#define kcnNoti_Default [NSNotificationCenter defaultCenter]
/// 发通知参数
#define kcnNoti_Post_Param(n,s) [[NSNotificationCenter defaultCenter]postNotificationName:n object:nil userInfo:s]
/// 发送通知
#define kcnNotifPost(n, o) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
/// 监听通知
#define kcnNotifAdd(n, f) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
/// 通知移除
#define kcnNotifRemove() [[NSNotificationCenter defaultCenter] removeObserver:self]


#pragma mark - 其他宏
/// weakself strongself
#define kcnWeakify(o)  __weak typeof(self) fwwo = o;
#define kcnStrongify(o)  __strong typeof(self) o = fwwo;
/// 分割线
#define kcnAppSpaceHeight CGFloatFromPixel(1)

#endif /* CNCommonMacro_h */
