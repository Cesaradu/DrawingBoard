//
//  ADDrawingBoard.h
//  DrawingBoard
//
//  Created by admin on 2020/3/20.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>
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

@property (nonatomic, weak) id <ADDrawingBoardDelegate> delegate;
@property (nonatomic, assign) ADDrawingType drawingType;
@property (nonatomic, assign) BOOL isEntering;
@property (nonatomic, assign) BOOL isColorMode; //是否处在选颜色模式
@property (nonatomic, strong) UIColor *lineColor; //画笔颜色
@property (nonatomic, strong) UIImage *bgImage; //背景图
@property (nonatomic, strong) NSMutableArray *layerArray; //所有的layer
@property (nonatomic, strong) NSMutableArray *noteArray; //所有的note
@property (nonatomic, strong) NSMutableArray *undoArray; //后退操作数组
@property (nonatomic, strong) NSMutableArray *redoArray; //前进操作数组

//添加可后退操作
- (void)addUndoSteps;

//后退一步操作
- (void)undoAction;

//前进一步操作
- (void)redoAction;

//删除当前note
- (void)removeCurrentNoteView:(ADNoteView *)noteView;

//删除当前layer
- (void)removeCurrentLayer:(ADDrawingLayer *)drawingLayer;

//刷新noteArray中noteView的序号
- (void)refreshNoteArray;

//移除没有文本内容的noteView
- (void)removeEmptyNote;

@end

NS_ASSUME_NONNULL_END
