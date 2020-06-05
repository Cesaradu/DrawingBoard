//
//  ADDrawingLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/3/23.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingRulerLineLayer.h"

@interface ADDrawingRulerLineLayer ()

@property (nonatomic, strong) UIBezierPath *rulerLinePath;
@property (nonatomic, strong) CAShapeLayer *roundLayer1;
@property (nonatomic, strong) CAShapeLayer *roundLayer2;

@end

@implementation ADDrawingRulerLineLayer

- (instancetype)initWithStartPoint:(CGPoint)startPoint {
    if (self = [super init]) {
        self.startPoint = startPoint;
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {
    super.lineColor = lineColor;
    self.strokeColor = lineColor.CGColor;
    self.roundLayer1.strokeColor = lineColor.CGColor;
    self.roundLayer2.strokeColor = lineColor.CGColor;
}

- (void)setCenterPoint:(CGPoint)centerPoint {
    super.centerPoint = centerPoint;
}

- (void)setIsEditable:(BOOL)isEditable {
    super.isEditable = isEditable;
    _roundLayer1.strokeColor = self.lineColor.CGColor;
    _roundLayer2.strokeColor = self.lineColor.CGColor;
    if (isEditable) {
        [self addSublayer:self.roundLayer1];
        [self addSublayer:self.roundLayer2];
    } else {
        [self.roundLayer1 removeFromSuperlayer];
        [self.roundLayer2 removeFromSuperlayer];
    }
}

- (void)setLayerModel:(LineLayerModel *)layerModel {
    super.layerModel = layerModel;
    self.index = layerModel.layerId;
    self.startPoint = CGPointFromString(layerModel.startPointString);
    self.endPoint = CGPointFromString(layerModel.endPointString);
    self.lineColor = [UIColor colorWithHexString:layerModel.lineColorString];
    [self movePathFromStartPoint:self.startPoint toEndPoint:self.endPoint];
}

- (void)movePathFromStartPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint {
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    self.centerPoint = CGPointMake((self.startPoint.x+self.endPoint.x)/2, (self.startPoint.y+self.endPoint.y)/2);
    [self configPath];
}

//双杠直线
- (void)movePathWithEndPoint:(CGPoint)endPoint {
    self.endPoint = endPoint;
    self.centerPoint = CGPointMake((self.startPoint.x+self.endPoint.x)/2, (self.startPoint.y+self.endPoint.y)/2);
    [self configPath];
}

- (void)movePathWithStartPoint:(CGPoint)startPoint {
    self.startPoint = startPoint;
    self.centerPoint = CGPointMake((self.startPoint.x+self.endPoint.x)/2, (self.startPoint.y+self.endPoint.y)/2);
    [self configPath];
}

- (void)movePathWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint {
    CGFloat moveX = currentPoint.x - previousPoint.x;
    CGFloat moveY = currentPoint.y - previousPoint.y;
    
    //新的起点终点坐标
    self.startPoint = CGPointMake(self.startPoint.x + moveX, self.startPoint.y + moveY);
    self.endPoint = CGPointMake(self.endPoint.x + moveX, self.endPoint.y + moveY);
    self.centerPoint = CGPointMake((self.startPoint.x+self.endPoint.x)/2, (self.startPoint.y+self.endPoint.y)/2);
    
    [self configPath];
}

- (void)configPath {
    self.rulerLinePath = [UIBezierPath bezierPath];
    //画直线
    [self.rulerLinePath moveToPoint:self.startPoint];
    [self.rulerLinePath addLineToPoint:self.endPoint];
    
    //画线段两头
    CGFloat angle = [self angleEndWithFirstPoint:self.startPoint andSecondPoint:self.endPoint];
    CGPoint point1 = CGPointMake(self.endPoint.x+5*sin(angle), self.endPoint.y+5*cos(angle));
    CGPoint point2 = CGPointMake(self.endPoint.x-5*sin(angle), self.endPoint.y-5*cos(angle));
    [self.rulerLinePath addLineToPoint:point1];
    [self.rulerLinePath addLineToPoint:point2];
    CGPoint point3 = CGPointMake(point1.x-(self.endPoint.x-self.startPoint.x), point1.y-(self.endPoint.y-self.startPoint.y));
    CGPoint point4 = CGPointMake(point2.x-(self.endPoint.x-self.startPoint.x), point2.y-(self.endPoint.y-self.startPoint.y));
    [self.rulerLinePath moveToPoint:point3];
    [self.rulerLinePath addLineToPoint:point4];
    
    [self setPath:self.rulerLinePath.CGPath];
    
    self.roundLayer1.path = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    self.roundLayer2.path = [UIBezierPath bezierPathWithArcCenter:self.endPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
}

- (CGFloat)getWidth:(NSString *)str withHeight:(CGFloat)height withFont:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(100000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

- (CGFloat)angleWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint {
    CGFloat dx = secondPoint.x - firstPoint.x;
    CGFloat dy = secondPoint.y - firstPoint.y;
    CGFloat angle = atan2f(dy, dx);
    return angle;
}

- (CGFloat)angleEndWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint {
    CGFloat dx = secondPoint.x - firstPoint.x;
    CGFloat dy = secondPoint.y - firstPoint.y;
    CGFloat angle = atan2f(fabs(dy), fabs(dx));
    if (dx * dy > 0) {
        return M_PI-angle;
    }
    return angle;
}

- (CAShapeLayer *)roundLayer1 {
    if (!_roundLayer1) {
        _roundLayer1 = [CAShapeLayer layer];
        _roundLayer1.lineJoin = kCALineJoinRound;
        _roundLayer1.lineCap = kCALineCapRound;
        _roundLayer1.strokeColor = self.lineColor.CGColor;
        _roundLayer1.fillColor = [UIColor clearColor].CGColor;
        _roundLayer1.lineWidth = 2;
        _roundLayer1.path = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    }
    return _roundLayer1;
}

- (CAShapeLayer *)roundLayer2 {
    if (!_roundLayer2) {
        _roundLayer2 = [CAShapeLayer layer];
        _roundLayer2.lineJoin = kCALineJoinRound;
        _roundLayer2.lineCap = kCALineCapRound;
        _roundLayer2.strokeColor = self.lineColor.CGColor;
        _roundLayer2.fillColor = [UIColor clearColor].CGColor;
        _roundLayer2.lineWidth = 2;
        _roundLayer2.path = [UIBezierPath bezierPathWithArcCenter:self.endPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    }
    return _roundLayer2;
}

@end
