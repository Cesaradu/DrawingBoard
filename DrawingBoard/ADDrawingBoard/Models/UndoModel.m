//
//  UndoModel.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "UndoModel.h"
#import "ADDrawingRulerLineLayer.h"
#import "ADNoteView.h"
#import "NoteModel.h"
#import "LineLayerModel.h"

@implementation UndoModel

- (instancetype)initWithLayerArray:(NSMutableArray *)layerArray andNoteArray:(NSMutableArray *)noteArray {
    if (self = [super init]) {
        //layer数组
        for (ADDrawingLayer *drawingLayer in layerArray) {
            LineLayerModel *model = [self createLayerModel:drawingLayer];
            [self.layerArray addObject:model];
        }
        //note数组
        for (ADNoteView *noteView in noteArray) {
            NoteModel *model = [self createNoteModel:noteView];
            [self.noteArray addObject:model];
        }
    }
    return self;
}

- (LineLayerModel *)createLayerModel:(ADDrawingLayer *)drawingLayer {
    LineLayerModel *model = [[LineLayerModel alloc] init];
    model.layerId = drawingLayer.index;
    model.startPointString = NSStringFromCGPoint(drawingLayer.startPoint);
    model.endPointString = NSStringFromCGPoint(drawingLayer.endPoint);
    model.lineColorString = [UIColor hexStringWithColor:drawingLayer.lineColor];
    return model;
}

- (NoteModel *)createNoteModel:(ADNoteView *)noteView {
    NoteModel *noteModel = [[NoteModel alloc] init];
    noteModel.noteId = noteView.index;
    noteModel.positionString = NSStringFromCGPoint(noteView.position);
    noteModel.noteText = noteView.text;
    noteModel.isIndexLeft = noteView.isIndexLeft;
    return noteModel;
}

- (NSMutableArray *)layerArray {
    if (!_layerArray) {
        _layerArray = [NSMutableArray new];
    }
    return _layerArray;
}

- (NSMutableArray *)noteArray {
    if (!_noteArray) {
        _noteArray = [NSMutableArray new];
    }
    return _noteArray;
}

@end
