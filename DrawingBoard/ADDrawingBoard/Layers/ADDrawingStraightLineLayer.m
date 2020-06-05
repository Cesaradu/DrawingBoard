//
//  ADDrawingStraightLineLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingStraightLineLayer.h"

@implementation ADDrawingStraightLineLayer

//画直线
- (void)configPath {
    [super configPath];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.endPoint];
    self.path = path.CGPath;
}

@end
