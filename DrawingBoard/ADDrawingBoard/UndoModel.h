//
//  UndoModel.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UndoModel : NSObject

@property (nonatomic, strong) NSMutableArray *layerArray;
@property (nonatomic, strong) NSMutableArray *noteArray;

- (instancetype)initWithLayerArray:(NSMutableArray *)layerArray andNoteArray:(NSMutableArray *)noteArray;

@end

NS_ASSUME_NONNULL_END
