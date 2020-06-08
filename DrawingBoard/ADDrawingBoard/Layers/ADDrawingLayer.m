//
//  ADDrawingLayer.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingLayer.h"
#import "ADDrawingGraffitiLayer.h"
#import "ADDrawingStraightLineLayer.h"
#import "ADDrawingRulerLineLayer.h"
#import "ADDrawingDottedLineLayer.h"
#import "ADDrawingArrowLayer.h"
#import "ADDrawingRulerArrowLayer.h"
#import "ADDrawingRightTriangleLayer.h"
#import "ADDrawingRectangleLayer.h"
#import "ADDrawingDiamondLayer.h"
#import "ADDrawingTrapezoidLayer.h"
#import "ADDrawingPentagonLayer.h"
#import "ADDrawingHexagonLayer.h"
#import "ADDrawingCircularLayer.h"
#import "ADDrawingOvalLayer.h"

@interface ADDrawingLayer ()

@property (nonatomic, strong) CAShapeLayer *startRoundLayer;
@property (nonatomic, strong) CAShapeLayer *endRoundLayer;

@end

@implementation ADDrawingLayer

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.lineJoin = kCALineJoinRound;
        self.lineCap = kCALineCapRound;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineColor = [UIColor colorWithHexString:YellowColor];
        self.lineWidth = 2;
        self.pointArray = [NSMutableArray new];
    }
    return self;
}

+ (instancetype)createLayerWithStartPoint:(CGPoint)startPoint type:(ADDrawingType)type {
    ADDrawingLayer *layer;
    switch (type) {
        case ADDrawingTypeGraffiti: {
            layer = [[ADDrawingGraffitiLayer alloc] initWithStartPoint:startPoint];
            break;
        }
        case ADDrawingTypeStraightLine: {
            layer = [[ADDrawingStraightLineLayer alloc] init];
            break;
        }
        case ADDrawingTypeDottedLine: {
            layer = [[ADDrawingDottedLineLayer alloc] init];
            break;
        }
        case ADDrawingTypeRulerLine: {
            layer = [[ADDrawingRulerLineLayer alloc] init];
            break;
        }
        case ADDrawingTypeArrow: {
            layer = [[ADDrawingArrowLayer alloc] init];
            break;
        }
        case ADDrawingTypeRulerArrow: {
            layer = [[ADDrawingRulerArrowLayer alloc] init];
            break;
        }
        case ADDrawingTypeRightTriangle: {
            layer = [[ADDrawingRightTriangleLayer alloc] init];
            break;
        }
        case ADDrawingTypeRectangle: {
            layer = [[ADDrawingRectangleLayer alloc] init];
            break;
        }
        case ADDrawingTypeDiamond: {
            layer = [[ADDrawingDiamondLayer alloc] init];
            break;
        }
        case ADDrawingTypeTrapezoid: {
            layer = [[ADDrawingTrapezoidLayer alloc] init];
            break;
        }
        case ADDrawingTypePentagon: {
            layer = [[ADDrawingPentagonLayer alloc] init];
            break;
        }
        case ADDrawingTypeHexagon: {
            layer = [[ADDrawingHexagonLayer alloc] init];
            break;
        }
        case ADDrawingTypeCircular: {
            layer = [[ADDrawingCircularLayer alloc] init];
            break;
        }
        case ADDrawingTypeOval: {
            layer = [[ADDrawingOvalLayer alloc] init];
            break;
        }
        
        default:
            break;
    }
    layer.startPoint = startPoint;
    layer.drawingType = type;
    return layer;
}

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

- (void)movePathFromStartPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint {
    self.startPoint = startPoint;
    self.endPoint = endPoint;
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
    switch (self.drawingType) {
            //自由涂鸦
        case ADDrawingTypeGraffiti: {
            self.startRoundLayer.path = [UIBezierPath bezierPathWithArcCenter:((NSValue *)self.pointArray.firstObject).CGPointValue radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
            self.endRoundLayer.path = [UIBezierPath bezierPathWithArcCenter:((NSValue *)self.pointArray.lastObject).CGPointValue radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
        }
            break;
            
            //线条
        case ADDrawingTypeStraightLine:
        case ADDrawingTypeDottedLine:
        case ADDrawingTypeRulerLine:
        case ADDrawingTypeArrow:
        case ADDrawingTypeRulerArrow: {
            self.startRoundLayer.path = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
            self.endRoundLayer.path = [UIBezierPath bezierPathWithArcCenter:self.endPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
        }
            break;
            
            //图形
        case ADDrawingTypeRightTriangle:
        case ADDrawingTypeRectangle:
        case ADDrawingTypeDiamond:
        case ADDrawingTypeTrapezoid:
        case ADDrawingTypePentagon:
        case ADDrawingTypeHexagon:
        case ADDrawingTypeCircular:
        case ADDrawingTypeOval: {
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)movePathWithPointArray:(NSMutableArray *)pointArray {
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < pointArray.count; i ++) {
        CGPoint point = ((NSValue *)pointArray[i]).CGPointValue;
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }
    self.path = path.CGPath;
    [self configPath];
}

- (CGFloat)distanceBetweenStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGFloat xDist = (endPoint.x - startPoint.x);
    CGFloat yDist = (endPoint.y - startPoint.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
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

#pragma mark - 箭头
- (UIBezierPath *)createArrowWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGPoint controllPoint = CGPointZero;
    CGPoint pointUp = CGPointZero;
    CGPoint pointDown = CGPointZero;
    CGFloat distance = [self distanceBetweenStartPoint:startPoint endPoint:endPoint];
    CGFloat distanceX = 10.0 * (ABS(endPoint.x - startPoint.x) / distance);
    CGFloat distanceY = 10.0 * (ABS(endPoint.y - startPoint.y) / distance);
    CGFloat distX = 5.0 * (ABS(endPoint.y - startPoint.y) / distance);
    CGFloat distY = 5.0 * (ABS(endPoint.x - startPoint.x) / distance);
    if (endPoint.x >= startPoint.x) {
        if (endPoint.y >= startPoint.y) {
            controllPoint = CGPointMake(endPoint.x - distanceX, endPoint.y - distanceY);
            pointUp = CGPointMake(controllPoint.x + distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x - distX, controllPoint.y + distY);
        } else {
            controllPoint = CGPointMake(endPoint.x - distanceX, endPoint.y + distanceY);
            pointUp = CGPointMake(controllPoint.x - distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x + distX, controllPoint.y + distY);
        }
    } else {
        if (endPoint.y >= startPoint.y) {
            controllPoint = CGPointMake(endPoint.x + distanceX, endPoint.y - distanceY);
            pointUp = CGPointMake(controllPoint.x - distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x + distX, controllPoint.y + distY);
        } else {
            controllPoint = CGPointMake(endPoint.x + distanceX, endPoint.y + distanceY);
            pointUp = CGPointMake(controllPoint.x + distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x - distX, controllPoint.y + distY);
        }
    }
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:endPoint];
    [arrowPath addLineToPoint:pointDown];
    [arrowPath addLineToPoint:pointUp];
    [arrowPath addLineToPoint:endPoint];
    return arrowPath;
}

#pragma mark - Setter
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.strokeColor = lineColor.CGColor;
    self.startRoundLayer.strokeColor = lineColor.CGColor;
    self.endRoundLayer.strokeColor = lineColor.CGColor;
    
    if (self.drawingType == ADDrawingTypeArrow || self.drawingType == ADDrawingTypeRulerArrow) {
        self.fillColor = lineColor.CGColor;
    }
}

- (void)setLayerLineWidth:(CGFloat)layerLineWidth {
    if (layerLineWidth <= 1) {
        layerLineWidth = 1;
    } else if (layerLineWidth >= 20) {
        layerLineWidth = 20;
    }
    _layerLineWidth = layerLineWidth;
    self.lineWidth = layerLineWidth;
}

- (void)setIsEditable:(BOOL)isEditable {
    _isEditable = isEditable;
    self.startRoundLayer.strokeColor = self.lineColor.CGColor;
    self.endRoundLayer.strokeColor = self.lineColor.CGColor;
    if (isEditable) {
        [self addSublayer:self.startRoundLayer];
        [self addSublayer:self.endRoundLayer];
    } else {
        [self.startRoundLayer removeFromSuperlayer];
        [self.endRoundLayer removeFromSuperlayer];
    }
}

- (void)setCenterPoint:(CGPoint)centerPoint {
    _centerPoint = centerPoint;
}

- (void)setLayerModel:(LineLayerModel *)layerModel {
    _layerModel = layerModel;
    self.index = layerModel.layerId;
    self.drawingType = layerModel.drawingType;
    self.startPoint = CGPointFromString(layerModel.startPointString);
    self.endPoint = CGPointFromString(layerModel.endPointString);
    self.pointArray = layerModel.pointArray;
    self.lineColor = [UIColor colorWithHexString:layerModel.lineColorString];
    if (layerModel.drawingType == ADDrawingTypeGraffiti) {
        [self movePathWithPointArray:self.pointArray]; //自由涂鸦
    } else {
        [self movePathFromStartPoint:self.startPoint toEndPoint:self.endPoint];
    }
}

- (void)setStartPoint:(CGPoint)startPoint {
    _startPoint = startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint {
    _endPoint = endPoint;
}

#pragma mark - Lazzy
- (CAShapeLayer *)startRoundLayer {
    if (!_startRoundLayer) {
        _startRoundLayer = [CAShapeLayer layer];
        _startRoundLayer.lineJoin = kCALineJoinRound;
        _startRoundLayer.lineCap = kCALineCapRound;
        _startRoundLayer.strokeColor = self.lineColor.CGColor;
        _startRoundLayer.fillColor = [UIColor clearColor].CGColor;
        _startRoundLayer.lineWidth = 2;
        _startRoundLayer.path = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    }
    return _startRoundLayer;
}

- (CAShapeLayer *)endRoundLayer {
    if (!_endRoundLayer) {
        _endRoundLayer = [CAShapeLayer layer];
        _endRoundLayer.lineJoin = kCALineJoinRound;
        _endRoundLayer.lineCap = kCALineCapRound;
        _endRoundLayer.strokeColor = self.lineColor.CGColor;
        _endRoundLayer.fillColor = [UIColor clearColor].CGColor;
        _endRoundLayer.lineWidth = 2;
        _endRoundLayer.path = [UIBezierPath bezierPathWithArcCenter:self.endPoint radius:16 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    }
    return _endRoundLayer;
}

@end
