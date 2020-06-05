//
//  ADDrawingLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/3/23.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingRulerLineLayer.h"

@implementation ADDrawingRulerLineLayer

//画线段
- (void)configPath {
    [super configPath];
    UIBezierPath *path = [UIBezierPath bezierPath];
    //画直线
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.endPoint];
    
    //画线段两头
    CGFloat angle = [self angleEndWithFirstPoint:self.startPoint andSecondPoint:self.endPoint];
    CGPoint point1 = CGPointMake(self.endPoint.x+5*sin(angle), self.endPoint.y+5*cos(angle));
    CGPoint point2 = CGPointMake(self.endPoint.x-5*sin(angle), self.endPoint.y-5*cos(angle));
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    CGPoint point3 = CGPointMake(point1.x-(self.endPoint.x-self.startPoint.x), point1.y-(self.endPoint.y-self.startPoint.y));
    CGPoint point4 = CGPointMake(point2.x-(self.endPoint.x-self.startPoint.x), point2.y-(self.endPoint.y-self.startPoint.y));
    [path moveToPoint:point3];
    [path addLineToPoint:point4];
    
    [self setPath:path.CGPath];
}

@end
