//
//  ADDrawingRulerArrowLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingRulerArrowLayer.h"

@implementation ADDrawingRulerArrowLayer

//双箭头
- (void)configPath {
    [super configPath];
    CGFloat length = 0;
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:self.endPoint];
    CGPoint pointMiddle = CGPointMake((self.startPoint.x+self.endPoint.x)/2, (self.startPoint.y+self.endPoint.y)/2);
    CGFloat offsetX = length*cos(angle);
    CGFloat offsetY = length*sin(angle);
    CGPoint pointMiddle1 = CGPointMake(pointMiddle.x-offsetX, pointMiddle.y-offsetY);
    CGPoint pointMiddle2 = CGPointMake(pointMiddle.x+offsetX, pointMiddle.y+offsetY);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:pointMiddle1];
    [path moveToPoint:pointMiddle2];
    [path addLineToPoint:self.endPoint];
    [path appendPath:[self createArrowWithStartPoint:pointMiddle1 endPoint:self.startPoint]];
    [path appendPath:[self createArrowWithStartPoint:pointMiddle2 endPoint:self.endPoint]];
    self.fillColor = self.lineColor.CGColor;
    self.path = path.CGPath;
}

@end
