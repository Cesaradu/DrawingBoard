//
//  ADDrawingTrapezoidLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/8.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingTrapezoidLayer.h"

@implementation ADDrawingTrapezoidLayer

- (void)configPath {
    [super configPath];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = self.endPoint.x-self.startPoint.x;
    [path moveToPoint:CGPointMake(width/4*1+self.startPoint.x, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(width/4*3+self.startPoint.x, self.startPoint.y)];
    [path addLineToPoint:self.endPoint];
    [path addLineToPoint:CGPointMake(self.startPoint.x, self.endPoint.y)];
    [path addLineToPoint:CGPointMake(width/4*1+self.startPoint.x, self.startPoint.y)];
    self.path = path.CGPath;
}

@end
