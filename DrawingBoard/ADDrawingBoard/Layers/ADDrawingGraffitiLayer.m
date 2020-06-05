//
//  ADDrawingGraffitiLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingGraffitiLayer.h"

@implementation ADDrawingGraffitiLayer

- (instancetype)initWithStartPoint:(CGPoint)startPoint {
    if (self = [super init]) {
        self.startPoint = startPoint;
        [self.pointArray addObject:[NSValue valueWithCGPoint:startPoint]];
        self.path = [UIBezierPath bezierPath].CGPath;
    }
    return self;
}

- (void)configPath {
    [super configPath];
    self.startPoint = ((NSValue *)self.pointArray.lastObject).CGPointValue;
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.path];
    [path moveToPoint:((NSValue *)self.pointArray.lastObject).CGPointValue];
    [path addLineToPoint:self.endPoint];
    self.path = path.CGPath;
    [self.pointArray addObject:[NSValue valueWithCGPoint:self.endPoint]];
}

@end
