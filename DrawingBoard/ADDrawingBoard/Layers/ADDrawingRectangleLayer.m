//
//  ADDrawingRectangleLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/8.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingRectangleLayer.h"

@implementation ADDrawingRectangleLayer

- (void)configPath {
    [super configPath];
    CGRect rectToFill = CGRectMake(self.endPoint.x - (self.endPoint.x - self.startPoint.x) * 2, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2, (self.endPoint.x - self.startPoint.x) * 2, (self.endPoint.y - self.startPoint.y) * 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectToFill];
    self.path = path.CGPath;
}

@end
