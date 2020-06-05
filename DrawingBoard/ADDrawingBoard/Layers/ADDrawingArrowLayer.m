//
//  ADDrawingArrowLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingArrowLayer.h"

@implementation ADDrawingArrowLayer

//单箭头
- (void)configPath {
    [super configPath];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.endPoint];
    [path appendPath:[self createArrowWithStartPoint:self.startPoint endPoint:self.endPoint]];
    self.fillColor = self.lineColor.CGColor;
    self.path = path.CGPath;
}

@end
