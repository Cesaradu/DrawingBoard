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
        self.pointArray = [NSMutableArray array];
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
            
            break;
        }
        case ADDrawingTypeDottedLine: {
            
            break;
        }
        case ADDrawingTypeRulerLine: {
            layer = [[ADDrawingRulerLineLayer alloc] initWithStartPoint:startPoint];
            break;
        }
        case ADDrawingTypeArrow: {
            
            break;
        }
        case ADDrawingTypeRulerArrow: {
            
            break;
        }
        case ADDrawingTypeRightTriangle: {
            
            break;
        }
        case ADDrawingTypeRectangle: {
            
            break;
        }
        case ADDrawingTypeDiamond: {
            
            break;
        }
        case ADDrawingTypeTrapezoid: {
            
            break;
        }
        case ADDrawingTypePentagon: {
            
            break;
        }
        case ADDrawingTypeHexagon: {
            
            break;
        }
        case ADDrawingTypeCircular: {
            
            break;
        }
        case ADDrawingTypeOval: {
            
            break;
        }
        case ADDrawingTypeText: {
            
            break;
        }
    }
    return layer;
}

- (void)movePathWithEndPoint:(CGPoint)endPoint {
    
}

- (void)movePathWithStartPoint:(CGPoint)startPoint {
    
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
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
}

@end
