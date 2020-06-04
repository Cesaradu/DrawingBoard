//
//  ADDrawingRulerLineLayer.h
//  DrawingBoard
//
//  Created by admin on 2020/3/23.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LineLayerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADDrawingRulerLineLayer : CAShapeLayer

- (instancetype)initWithStartPoint:(CGPoint)startPoint;

@property (nonatomic, assign) CGPoint startPoint;                //起始坐标
@property (nonatomic, assign) CGPoint endPoint;                  //终点坐标
@property (nonatomic, strong) UIColor *lineColor;                //画笔颜色
@property (nonatomic, assign) CGFloat layerLineWidth;            //线宽（1~20,默认2）
@property (nonatomic, assign) BOOL isEditable;                   //是否可编辑
@property (nonatomic, assign) int index;                         //序号
@property (nonatomic, assign) CGPoint centerPoint;               //中心点

@property (nonatomic, strong) LineLayerModel *layerModel;

- (void)movePathWithStartPoint:(CGPoint)startPoint;
- (void)movePathWithEndPoint:(CGPoint)endPoint;
- (void)movePathWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint;
- (void)movePathFromStartPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint;

- (CGFloat)angleWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint;
- (CGFloat)angleEndWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint;
    
@end

NS_ASSUME_NONNULL_END
