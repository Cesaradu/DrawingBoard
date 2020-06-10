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
    CGFloat longWidth = (self.endPoint.x - self.startPoint.x) * 2;
    [path moveToPoint:CGPointMake(self.startPoint.x - longWidth/4, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2)];
    [path addLineToPoint:CGPointMake(self.endPoint.x - (self.endPoint.x - self.startPoint.x) * 2, self.endPoint.y)];
    [path addLineToPoint:self.endPoint];
    [path addLineToPoint:CGPointMake(self.startPoint.x + longWidth/4, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2)];
    [path addLineToPoint:CGPointMake(self.startPoint.x - longWidth/4, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2)];
    self.path = path.CGPath;
}

@end
