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
    self = [super init];
    if (self) {
        [self.pointArray addObject:[NSValue valueWithCGPoint:startPoint]];
        self.path = [UIBezierPath bezierPath].CGPath;
    }
    return self;
}

- (void)movePathWithEndPoint:(CGPoint)endPoint {
    self.endPoint = endPoint;
    self.startPoint = ((NSValue*)self.pointArray.lastObject).CGPointValue;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.path];
    [path moveToPoint:((NSValue *)self.pointArray.lastObject).CGPointValue];
    [path addLineToPoint:endPoint];
    self.path = path.CGPath;
    
    [self.pointArray addObject:[NSValue valueWithCGPoint:endPoint]];
}

@end
