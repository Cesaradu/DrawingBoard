//
//  ADDrawingBoard.h
//  DrawingBoard
//
//  Created by admin on 2020/3/20.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADDrawingLayer.h"
#import "ADNoteView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ADDrawingBoardDelegate <NSObject>

- (void)didSelectDrawingLayer:(ADDrawingLayer *)drawingLayer;
- (void)didSelectNoteTextView:(ADNoteView *)noteView;
- (void)currentDrawingType:(ADDrawingType)drawingType;
- (void)didTouchEmptyZone;
- (void)didEndMoveAndTouchAction;

@end

@interface ADDrawingBoard : UIView

//@property (nonatomic, strong) ProjectModel *projectModel;
@property (nonatomic, weak) id <ADDrawingBoardDelegate> delegate;
@property (nonatomic, assign) ADDrawingType drawingType;
@property (nonatomic, assign) BOOL isEntering;
@property (nonatomic, assign) BOOL isColorMode; //是否处在选颜色模式
@property (nonatomic, strong) UIColor *lineColor; //画笔颜色
@property (nonatomic, strong) UIImage *bgImage; //背景图
@property (nonatomic, strong) NSMutableArray *layerArray;
@property (nonatomic, strong) NSMutableArray *noteArray;
@property (nonatomic, strong) NSMutableArray *previousLayerArray;
@property (nonatomic, strong) NSMutableArray *previousNoteArray;

@property (nonatomic, strong) NSMutableArray *undoArray;
@property (nonatomic, strong) NSMutableArray *redoArray;

- (void)addUndoSteps;

//撤回一步操作
- (void)undoAction;

//前进一步操作
- (void)redoAction;

- (void)removeCurrentNoteView:(ADNoteView *)noteView;
- (void)removeCurrentLayer:(ADDrawingLayer *)drawingLayer;

//刷新noteArray中noteView的序号
- (void)refreshNoteArray;

//移除没有文本内容的noteView
- (void)removeEmptyNote;

@end

NS_ASSUME_NONNULL_END
