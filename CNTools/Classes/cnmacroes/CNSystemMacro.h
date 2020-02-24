//
//  CNSystemMacro.h
//  CommonDemo
//
//  Created by Mac mini on 2019/11/13.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#ifndef CNSystemMacro_h
#define CNSystemMacro_h

#import <Foundation/Foundation.h>


#pragma mark - 屏幕size, width, height
#define kcnScreenSize [UIScreen mainScreen].bounds.size
#define kcnScreenW    [[UIScreen mainScreen] bounds].size.width
#define kcnScreenH    [[UIScreen mainScreen] bounds].size.height

#pragma mark - 状态栏
#define kcnStatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)

#endif /* CNSystemMacro_h */
