//
//  ADDrawingOvalLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/8.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingOvalLayer.h"

@implementation ADDrawingOvalLayer

- (void)configPath {
    [super configPath];
    CGRect rectToFill = CGRectMake(self.startPoint.x, self.startPoint.y, self.endPoint.x - self.startPoint.x, self.endPoint.y - self.startPoint.y);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
    self.path = path.CGPath;
}

@end
