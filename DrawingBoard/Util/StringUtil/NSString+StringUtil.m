//
//  NSString+StringUtil.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "NSString+StringUtil.h"

@implementation NSString (StringUtil)

+ (BOOL)isNULL:(NSString *)string {
    NSString *str = [NSString stringWithFormat:@"%@", string];
    if ([str isEqualToString:@""]) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    if (str.length == 0) {
        return YES;
    }
    if (str == nil) {
        return YES;
    }
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([str isEqualToString:@"null"]) {
        return YES;
    }
    if (str == NULL) {
        return YES;
    }
    return NO;
}

@end
