//
//  UIView+CNAddition.m
//  CommonDemo
//
//  Created by Mac mini on 2019/11/14.
//  Copyright © 2019 Mac mini. All rights reserved.
//

#import "UIView+CNAddition.h"
#import <objc/runtime.h>
#import <Photos/PHPhotoLibrary.h>

static NSString *CNCornerLayerName = @"CNCornerShapeLayer";
#define kCNScreenScale [UIScreen mainScreen].scale


@interface UIView ()
/// 保存截图到相册的回调
@property(nonatomic, copy) void(^cn_savedPhotosAlbumHandler)(UIImage *image, NSError *error);
@end

@implementation UIView (CNAddition)


#pragma mark - runtime属性
- (void)setCn_savedPhotosAlbumHandler:(void (^)(UIImage *, NSError *))cn_savedPhotosAlbumHandler {
    objc_setAssociatedObject(self, @selector(cn_savedPhotosAlbumHandler), cn_savedPhotosAlbumHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIImage *, NSError *))cn_savedPhotosAlbumHandler {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - width, height, size
/** width */
- (void)setCn_width:(CGFloat)cn_width {
    CGRect frame = self.frame;
    frame.size.width = cn_width;
    self.frame = frame;
}
- (CGFloat)cn_width {
    return self.frame.size.width;
}

/** height */
- (void)setCn_height:(CGFloat)cn_height {
    CGRect frame = self.frame;
    frame.size.height = cn_height;
    self.frame = frame;
}
- (CGFloat)cn_height {
    return self.frame.size.height;
}

/** size */
- (void)setCn_size:(CGSize)cn_size {
    CGRect frame = self.frame;
    frame.size = cn_size;
    self.frame = frame;
}
- (CGSize)cn_size {
    return self.frame.size;
}


#pragma mark - x, y, origin
/** x */
- (void)setCn_x:(CGFloat)cn_x {
    CGRect frame = self.frame;
    frame.origin.x = cn_x;
    self.frame = frame;
}
- (CGFloat)cn_x {
    return self.frame.origin.x;
}

/** y */
- (void)setCn_y:(CGFloat)cn_y {
    CGRect frame = self.frame;
    frame.origin.y = cn_y;
    self.frame = frame;
}
- (CGFloat)cn_y {
    return self.frame.origin.y;
}

/** origin */
- (void)setCn_origin:(CGPoint)cn_origin {
    CGRect frame = self.frame;
    frame.origin = cn_origin;
    self.frame = frame;
}
- (CGPoint)cn_origin {
    return self.frame.origin;
}

#pragma mark - center.x, center.y
/** center.x */
- (void)setCn_centerX:(CGFloat)cn_centerX {
    self.center = CGPointMake(cn_centerX, self.center.y);
}
- (CGFloat)cn_centerX {
    return self.center.x;
}

/** center.y */
- (void)setCn_centerY:(CGFloat)cn_centerY {
    self.center = CGPointMake(self.center.x, cn_centerY);
}
- (CGFloat)cn_centerY {
    return self.center.y;
}


#pragma mark - 圆角
- (void)cn_cornerRadius:(CGFloat)radius
          cornerBgColor:(UIColor *)cornerBgColor {
    [self _cn_roundingCorner:UIRectCornerAllCorners radius:radius borderWidth:0 borderColor:nil isDashPattern:NO cornerBgColor:cornerBgColor];
}

- (void)cn_cornerRadius:(CGFloat)radius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
          isDashPattern:(BOOL)isDashPattern
          cornerBgColor:(UIColor *)cornerBgColor {
    [self _cn_roundingCorner:UIRectCornerAllCorners radius:radius borderWidth:borderWidth borderColor:borderColor isDashPattern:isDashPattern cornerBgColor:cornerBgColor];
}

- (void)cn_roundingCorner:(UIRectCorner)roundCorner
                   radius:(CGFloat)radius
              borderWidth:(CGFloat)borderWidth
              borderColor:(nullable UIColor *)borderColor
              cornerBgColor:(UIColor *)cornerBgColor {
    [self _cn_roundingCorner:roundCorner radius:radius borderWidth:borderWidth borderColor:borderColor isDashPattern:NO cornerBgColor:cornerBgColor];
}


#pragma mark - 特定size的截图
/// 截取某个范围内的图像
/// @param rect 需要截取的尺寸
- (UIImage *)cn_screenshotsAtFrame:(CGRect)rect
           savedPhotosAlbumHandler:(void(^ _Nullable)(UIImage *image, NSError * error))handle {
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (handle) {
        self.cn_savedPhotosAlbumHandler = handle;
        // 先保证相册权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                // 保存到相册中
                UIImageWriteToSavedPhotosAlbum(theImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
            if (status == PHAuthorizationStatusRestricted ||
                status == PHAuthorizationStatusDenied ||
                status == PHAuthorizationStatusNotDetermined) {
                NSAssert(NO, @"您尚未开启相册权限");
            }
        }];
    }
    
    return theImage;
}


#pragma mark - Private Method
- (void)_cn_roundingCorner:(UIRectCorner)roundCorner
                   radius:(CGFloat)radius
              borderWidth:(CGFloat)borderWidth
              borderColor:(nullable UIColor *)borderColor
             isDashPattern:(BOOL)isDashPattern
              cornerBgColor:(UIColor *)cornerBgColor {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect bounds = self.bounds;
         
         bounds.size.width += .13*kCNScreenScale;
         bounds.size.height += .13*kCNScreenScale;
         bounds.origin.x = 0;
         bounds.origin.y = 0;
         
         [self removeCNCorner];
         
         CGFloat width = CGRectGetWidth(bounds);
         CGFloat height = CGRectGetHeight(bounds);
         UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(-0.2, -0.2, width, height)];
         CAShapeLayer *shapeLayer = [CAShapeLayer layer];
         shapeLayer.name = CNCornerLayerName;
        
         UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:roundCorner cornerRadii:CGSizeMake(radius, 0)];
         [path appendPath:cornerPath];
         
         shapeLayer.path = path.CGPath;
         shapeLayer.fillRule = kCAFillRuleEvenOdd;
         shapeLayer.fillColor = cornerBgColor? cornerBgColor.CGColor : [UIColor whiteColor].CGColor;
         
         if (borderWidth > 0) {
             UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:roundCorner cornerRadii:CGSizeMake(radius, 0)];
             CAShapeLayer *borderLayer = [CAShapeLayer layer];
             
             borderLayer.path = borderPath.CGPath;
             borderLayer.strokeColor = borderColor? borderColor.CGColor : [UIColor clearColor].CGColor;
             borderLayer.lineWidth = borderWidth;
             borderLayer.lineCap = kCALineCapRound;
             borderLayer.fillColor = UIColor.clearColor.CGColor;
             
             if (isDashPattern) {
                 borderLayer.lineDashPattern = @[@5, @5]; // 虚线
             }
             [shapeLayer addSublayer:borderLayer];
         }
         
         if ([self isKindOfClass:[UILabel class]]) {
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.layer addSublayer:shapeLayer];
             });
             return;
         }
         
         [self.layer addSublayer:shapeLayer];
    });
}
- (BOOL)hasCNCornered {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAShapeLayer class]] && [subLayer.name isEqualToString:CNCornerLayerName]) {
            return YES;
        }
    }
    return NO;
}
- (void)removeCNCorner {
    if ([self hasCNCornered]) {
        CALayer *layer = nil;
        for (CALayer *subLayer in self.layer.sublayers) {
            if ([subLayer.name isEqualToString:CNCornerLayerName]) {
                layer = subLayer;
            }
        }
        [layer removeFromSuperlayer];
    }
}

/// 保存截图到本地相册的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    self.cn_savedPhotosAlbumHandler(image, error);
}
@end
