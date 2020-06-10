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
    CGRect rectToFill = CGRectMake(self.endPoint.x - (self.endPoint.x - self.startPoint.x) * 2, self.endPoint.y - (self.endPoint.y - self.startPoint.y) * 2, (self.endPoint.x - self.startPoint.x) * 2, (self.endPoint.y - self.startPoint.y) * 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
    self.path = path.CGPath;
}

@end
