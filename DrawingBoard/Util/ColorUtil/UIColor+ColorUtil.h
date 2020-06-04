//
//  UIColor+ColorUtil.h
//  PREXISO
//
//  Created by admin on 2018/11/26.
//  Copyright © 2018 prexiso. All rights reserved.
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
