//
//  ADDrawingCircularLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/8.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingCircularLayer.h"

@implementation ADDrawingCircularLayer

- (void)configPath {
    [super configPath];
    CGPoint centerPoint = self.startPoint;
    CGFloat radius = [self distanceBetweenStartPoint:centerPoint endPoint:self.endPoint];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    self.path = path.CGPath;
}

@end
