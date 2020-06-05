//
//  ADDrawingDottedLineLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingDottedLineLayer.h"

@implementation ADDrawingDottedLineLayer

//画虚线
- (void)configPath {
    [super configPath];
    [self setLineDashPattern: [NSArray arrayWithObjects: [NSNumber numberWithInt:10], [NSNumber numberWithInt:5], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.startPoint.x, self.startPoint.y);
    CGPathAddLineToPoint(path, NULL, self.endPoint.x, self.endPoint.y);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:path];
    self.path = bezierPath.CGPath;
}

@end
