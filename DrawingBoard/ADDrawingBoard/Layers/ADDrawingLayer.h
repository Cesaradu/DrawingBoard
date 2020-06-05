//
//  ADDrawingLayer.h
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LineLayerModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ADDrawingType) {
    ADDrawingTypeGraffiti = 0, //自由涂鸦
    ADDrawingTypeStraightLine = 1, //直线
    ADDrawingTypeDottedLine = 2, //虚线
    ADDrawingTypeRulerLine = 3, //线段
    ADDrawingTypeArrow = 4, //箭头
    ADDrawingTypeRulerArrow = 5, //双箭头
    ADDrawingTypeRightTriangle = 6, //直角三角形
    ADDrawingTypeRectangle = 7, //矩形
    ADDrawingTypeDiamond = 8, //菱形
    ADDrawingTypeTrapezoid = 9, //梯形
    ADDrawingTypePentagon = 10, //五角形
    ADDrawingTypeHexagon = 11, //六边形
    ADDrawingTypeCircular = 12, //圆形
    ADDrawingTypeOval = 13, //椭圆形
    ADDrawingTypeText = 14, //文本
};

@interface ADDrawingLayer : CAShapeLayer

@property (nonatomic, assign) int index;                         //序号
@property (nonatomic, assign) ADDrawingType drawingType;
@property (nonatomic, assign) CGPoint startPoint;                //起始坐标
@property (nonatomic, assign) CGPoint endPoint;                  //终点坐标
@property (nonatomic, assign) CGPoint centerPoint;               //中心点
@property (nonatomic, strong) NSMutableArray *pointArray;         //记录图形绘制点
@property (nonatomic, strong) UIColor *lineColor;                //画笔颜色（默认黑色）
@property (nonatomic, assign) CGFloat layerLineWidth;            //线宽（1~20,默认2）
@property (nonatomic, assign) BOOL isEditable;                   //是否可编辑

@property (nonatomic, strong) LineLayerModel *layerModel;

+ (instancetype)createLayerWithStartPoint:(CGPoint)startPoint type:(ADDrawingType)type;

- (instancetype)initWithStartPoint:(CGPoint)startPoint;
- (void)movePathWithStartPoint:(CGPoint)startPoint;
- (void)movePathWithEndPoint:(CGPoint)endPoint;
- (void)movePathWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint;
- (void)movePathFromStartPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint;

- (CGFloat)angleWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint;
- (CGFloat)angleEndWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint;

@end

NS_ASSUME_NONNULL_END
