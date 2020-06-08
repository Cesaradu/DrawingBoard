//
//  ADDrawingPentagonLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/8.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingPentagonLayer.h"

@implementation ADDrawingPentagonLayer

- (instancetype)init {
    if (self = [super init]) {
        self.edgeNumber = 5;
    }
    return self;
}

- (void)configPath {
    [super configPath];
    CGFloat radius;
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:self.endPoint];
    radius = fabs(self.endPoint.y - self.startPoint.y)/sin(angle);
    UIBezierPath *path = [UIBezierPath bezierPath];
    BOOL firstPoint = YES;
    for (CGFloat angle = self.edgeNumber%2*(-M_PI_2) ; angle <= (2+self.edgeNumber%2*0.5)*M_PI; angle += 2*M_PI/self.edgeNumber) {
        CGFloat x = self.startPoint.x + radius * cos(angle);
        CGFloat y = self.startPoint.y + radius * sin(angle);
        CGPoint point = CGPointMake(x, y);
        if (firstPoint) {
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:point];
        }
        firstPoint = NO;
    }
    self.path = path.CGPath;
}

@end
