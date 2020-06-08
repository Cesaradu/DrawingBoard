//
//  ADDrawingDiamondLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/8.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingDiamondLayer.h"

@implementation ADDrawingDiamondLayer

- (void)configPath {
    [super configPath];
    CGFloat midX = self.startPoint.x + (self.endPoint.x - self.startPoint.x)/2;
    CGFloat midY = self.startPoint.y + (self.endPoint.y - self.startPoint.y)/2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(midX, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, midY)];
    [path addLineToPoint:CGPointMake(midX, self.endPoint.y)];
    [path addLineToPoint:CGPointMake(self.endPoint.x, midY)];
    [path addLineToPoint:CGPointMake(midX, self.startPoint.y)];
    self.path = path.CGPath;
}

@end
