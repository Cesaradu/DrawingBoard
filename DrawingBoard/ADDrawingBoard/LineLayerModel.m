//
//  LineLayerModel.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "LineLayerModel.h"

@implementation LineLayerModel

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        //runtime获取model的属性列表
        NSArray *propertyList = [RuntimeUtil getPropertyList:[self class]];
        //根据类型给属性赋值
        for (NSString *key in propertyList) {
            if ([dict valueForKey:key] == nil) {
                [self setValue:@"" forKey:key];
            } else {
                [self setValue:[dict valueForKey:key] forKey:key];
            }
        }
        
    }
    return self;
}

@end
