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
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.startPoint.x, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2)];
    [path addLineToPoint:CGPointMake(self.endPoint.x - (self.endPoint.x - self.startPoint.x) * 2, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, self.endPoint.y)];
    [path addLineToPoint:CGPointMake(self.endPoint.x, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2)];
    self.path = path.CGPath;
}

@end
