//
//  ADDrawingStraightLineLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingStraightLineLayer.h"

@implementation ADDrawingStraightLineLayer

//绘制直线
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:endPoint];
    
    self.path = path.CGPath;
}

@end
