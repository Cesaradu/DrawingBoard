//
//  LineLayerModel.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADDrawingLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface LineLayerModel : NSObject

@property (nonatomic, assign) int layerId;
@property (nonatomic, assign) NSInteger drawingType;
@property (nonatomic, strong) NSString *startPointString;
@property (nonatomic, strong) NSString *endPointString;
@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) NSString *lineColorString;

- (id)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
