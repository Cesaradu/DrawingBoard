//
//  UIColor+ColorUtil.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ColorUtil)

//UIColor 转16进制字符串
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//UIColor 转16进制字符串
+ (UIColor *)colorWithHexString:(NSString *)color;

//16进制字符串 转UIColor
+ (NSString *)hexStringWithColor:(UIColor *)color;

//UIColor 转UIImage
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
