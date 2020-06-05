//
//  ADDrawingBoard.m
//  DrawingBoard
//
//  Created by admin on 2020/3/20.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADDrawingBoard.h"
#import "UndoModel.h"
#import "NoteModel.h"
#import "LineLayerModel.h"

@interface ADDrawingBoard ()

@property (nonatomic, assign) BOOL isTouch; //区分是点击还是滑动手势
@property (nonatomic, strong) UIImageView *bgImageView; //背景图

//layer
@property (nonatomic, strong) ADDrawingLayer *drawingLayer;
@property (nonatomic, strong) ADDrawingLayer *selectedLayer; //选中的
@property (nonatomic, assign) BOOL isMoveStartPoint;
@property (nonatomic, assign) BOOL isMoveEndPoint;
@property (nonatomic, assign) BOOL isMoveLine;

//note
@property (nonatomic, strong) ADNoteView *noteView;
@property (nonatomic, strong) ADNoteView *selectedNote; //选中的


@end

@implementation ADDrawingBoard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInit];
    }
    return self;
}

- (void)configInit {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.drawingType = ADDrawingTypeRulerLine;
    self.lineColor = [UIColor colorWithHexString:YellowColor];
}

- (void)judgeSelectObj:(CGPoint)currentPoint {
    [self getSelectNote:currentPoint];
    [self getSelectLayer:currentPoint];
    if (self.selectedLayer) {
        self.drawingType = self.selectedLayer.drawingType;
        return;
    }
    if (self.selectedNote) {
        self.drawingType = ADDrawingTypeText;
        return;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    if (self.isColorMode) {
        //颜色模式
        [self getSelectLayer:currentPoint];
        if (self.selectedLayer == nil) { //点击空白处
            if ([self.delegate respondsToSelector:@selector(didTouchEmptyZone)]) {
                [self.delegate didTouchEmptyZone];
            }
        }
    } else {
        //不在选颜色模式
        [self judgeSelectObj:currentPoint];
        if ([self.delegate respondsToSelector:@selector(currentDrawingType:)]) {
            [self.delegate currentDrawingType:self.drawingType];
        }
    }
    
    switch (self.drawingType) {
        case ADDrawingTypeGraffiti:
        case ADDrawingTypeStraightLine:
        case ADDrawingTypeDottedLine:
        case ADDrawingTypeRulerLine:
        case ADDrawingTypeArrow:
        case ADDrawingTypeRulerArrow: {
            [self configLayerTouchBeginWithCurrentPoint:currentPoint];
            break;
        }
        case ADDrawingTypeText: {
            if (!self.isColorMode) {
                [self configTextTouchBeginWithCurrentPoint:currentPoint];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    
    //判断是否在画板范围内
    BOOL isAvaliable = CGRectContainsPoint(self.frame, currentPoint);
    if (!isAvaliable) {
        return;
    }
    
    if (self.isColorMode) {
        return;
    }
    
    switch (self.drawingType) {
        case ADDrawingTypeGraffiti:
        case ADDrawingTypeStraightLine:
        case ADDrawingTypeDottedLine:
        case ADDrawingTypeRulerLine:
        case ADDrawingTypeArrow:
        case ADDrawingTypeRulerArrow: {
            [self configLayerMoveWithCurrentPoint:currentPoint andPreviousPoint:previousPoint];
            break;
        }
        case ADDrawingTypeText: {
            [self configTextMoveWithCurrentPoint:currentPoint andPreviousPoint:previousPoint];
            break;
        }
        
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    
    if (self.isColorMode) {
        return;
    }
    
    switch (self.drawingType) {
        case ADDrawingTypeGraffiti:
        case ADDrawingTypeStraightLine:
        case ADDrawingTypeDottedLine:
        case ADDrawingTypeRulerLine:
        case ADDrawingTypeArrow:
        case ADDrawingTypeRulerArrow: {
            if (CGPointEqualToPoint(currentPoint, previousPoint)) {
                return;
            }
            [self configLayerTouchEnd];
            break;
        }
        case ADDrawingTypeText: {
            [self configTextTouchEnd];
            break;
        }
            
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(didEndMoveAndTouchAction)]) {
        [self.delegate didEndMoveAndTouchAction];
    }
}

- (void)addUndoSteps {
    UndoModel *model = [[UndoModel alloc] initWithLayerArray:self.layerArray andNoteArray:self.noteArray];
    [self.undoArray addObject:model];
}

#pragma mark - LayerAction
- (ADDrawingLayer *)getSelectLayer:(CGPoint)point {
    //判断距离最小值，取出最小值以及所在下标
    ADDrawingLayer *firstLayer = self.layerArray.firstObject;
    double minDistance = [self calculateDistanceFromTouchPoint:point toStartPoint:firstLayer.startPoint andEndPoint:firstLayer.endPoint];
    int minIndex = 0;
    NSMutableArray *distanceArray = [NSMutableArray new];
    for (int i = 0; i < self.layerArray.count; i ++) {
        ADDrawingLayer *layer = self.layerArray[i];
        double distance = [self calculateDistanceFromTouchPoint:point toStartPoint:layer.startPoint andEndPoint:layer.endPoint];
        [distanceArray addObject:[NSNumber numberWithDouble:distance]];
        if (distance < minDistance) {
            minIndex = i;
        }
        minDistance = distance > minDistance ? minDistance : distance;
    }
    
    //若最小值小于20, 则根据最小值下标，取出layer，否则layer为nil
    if (minDistance <= 20) {
        for (NSInteger i = 0; i < self.layerArray.count; i ++) {
            ADDrawingLayer *layer = self.layerArray[i];
            if (i == minIndex) {
                layer.isEditable = YES;
                self.selectedLayer = layer;
            } else {
                layer.isEditable = NO;
            }
        }
    } else {
        self.selectedLayer.isEditable = NO;
        self.selectedLayer = nil;
    }
    
    return self.selectedLayer;
}

- (void)configLayerTouchBeginWithCurrentPoint:(CGPoint)currentPoint {
    //获取选中的layer
    [self getSelectLayer:currentPoint];
    
    if (self.selectedLayer) {
        //有选中的layer, 则编辑该layer
        double startDis = [self distanceBetweenTwoPoint:self.selectedLayer.startPoint point2:currentPoint]; //触摸点与起点的距离
        double endDis = [self distanceBetweenTwoPoint:self.selectedLayer.endPoint point2:currentPoint]; //触摸点与终点的距离
        if ((startDis <= 16 && endDis > 16) || (startDis <= 16 && endDis <= 16 && startDis < endDis)) {
            //刚好触摸到起点，或者同时触摸到起点和终点，但是距离起点更近，则移动起点
            self.isMoveStartPoint = YES;
            self.isMoveEndPoint = NO;
            self.isMoveLine = NO;
        } else if ((startDis > 16 && endDis <= 16) || (startDis <= 16 && endDis <= 16 && startDis > endDis)) {
            //刚好触摸到终点，或者同时触摸到起点和终点，但是距离终点更近，则移动终点
            self.isMoveEndPoint = YES;
            self.isMoveStartPoint = NO;
            self.isMoveLine = NO;
        } else {
            self.isMoveLine = YES;
            self.isMoveStartPoint = NO;
            self.isMoveEndPoint = NO;
        }
    }
    
    //传递选中、取消选中事件
    if ([self.delegate respondsToSelector:@selector(didSelectDrawingLayer:)]) {
        [self.delegate didSelectDrawingLayer:self.selectedLayer];
    }
    self.isTouch = YES;
}

- (void)configLayerMoveWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint {
    if (CGPointEqualToPoint(currentPoint, previousPoint)) {
        return;
    }
    
    if (self.selectedLayer) {
        if (self.isMoveStartPoint) {
            [self.selectedLayer movePathWithStartPoint:currentPoint];
        }
        if (self.isMoveEndPoint) {
            [self.selectedLayer movePathWithEndPoint:currentPoint];
        }
        if (self.isMoveLine) {
            [self.selectedLayer movePathWithCurrentPoint:currentPoint andPreviousPoint:previousPoint];
        }
    } else {
        //没有选中layer，则新画一个layer
        if (self.isTouch) {
            self.drawingLayer = [ADDrawingLayer createLayerWithStartPoint:currentPoint type:self.drawingType];
            self.drawingLayer.lineColor = self.lineColor;
            self.drawingLayer.index = (int)self.layerArray.count + 1;
            [self.layer addSublayer:self.drawingLayer];
        } else {
            [self.drawingLayer movePathWithEndPoint:currentPoint];
        }
        self.isTouch = NO;
    }
}

- (void)configLayerTouchEnd {
    if (self.selectedLayer) {
        [self replaceLayerToLayerArray];
        [self addUndoSteps]; //移动layer可撤回
        return;
    }
    if (self.drawingLayer && ![self.layerArray containsObject:self.drawingLayer]) {
        [self.layerArray addObject:self.drawingLayer];
        [self addUndoSteps]; //新增layer可撤回
    }
}

- (void)replaceLayerToLayerArray {
    for (int i = 0; i < self.layerArray.count; i ++) {
        ADDrawingLayer *layer = self.layerArray[i];
        if (layer.index == self.selectedLayer.index) {
            [self.layerArray replaceObjectAtIndex:i withObject:self.selectedLayer];
        }
    }
}

#pragma mark - TextAction
- (ADNoteView *)getSelectNote:(CGPoint)point {
    self.selectedNote = nil;
    for (int i = 0; i < self.noteArray.count; i ++) {
        ADNoteView *noteView = self.noteArray[i];
        if (CGRectContainsPoint(noteView.frame, point)) {
            self.selectedNote = noteView;
            self.selectedNote.isEditable = YES;
        } else {
            noteView.isEditable = NO;
        }
    }
    
    return self.selectedNote;
}

- (void)configTextTouchBeginWithCurrentPoint:(CGPoint)currentPoint {
    //获取选中的note
    [self getSelectNote:currentPoint];
    self.noteView = nil;
    //未选中，则添加
    if (!self.selectedNote && !self.isEntering) {
        [self removeEmptyNote]; //避免快速点击一下子添加多个
        self.noteView = [[ADNoteView alloc] initWithStartPoint:currentPoint];
        self.noteView.index = (int)self.noteArray.count + 1;
        self.noteView.isEditable = YES;
        [self addSubview:self.noteView];
    }
    
    //传递选中、取消选中事件
    if ([self.delegate respondsToSelector:@selector(didSelectNoteTextView:)]) {
        [self.delegate didSelectNoteTextView:self.selectedNote ? self.selectedNote : self.noteView];
    }
}

- (void)configTextMoveWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint {
    if (self.selectedNote) {
        if (!CGRectContainsPoint(self.selectedNote.frame, currentPoint)) {
            [self.selectedNote moveToPointWithCurrentPoint:currentPoint andPreviousPoint:previousPoint];
            self.selectedNote.isMoved = YES;
        }
    }
}

- (void)configTextTouchEnd {
    if (self.selectedNote) {
        if (self.selectedNote.isMoved) {
            [self replaceNoteToNoteArray];
            [self addUndoSteps]; //移动note可撤回
        }
        self.selectedNote.isMoved = NO;
        return;
    }
    if (self.noteView && ![self.noteArray containsObject:self.noteView]) {
        [self.noteArray addObject:self.noteView];
        [self addUndoSteps]; //新增note可撤回
    }
}

//每次选中，触摸结束，都将选中的note替换到数组中去更新坐标，方便一起保存
- (void)replaceNoteToNoteArray {
    for (int i = 0; i < self.noteArray.count; i ++) {
        ADNoteView *noteView = self.noteArray[i];
        if (noteView.index == self.selectedNote.index) {
            [self.noteArray replaceObjectAtIndex:i withObject:self.selectedNote];
        }
    }
}

//移除没有文本内容的noteView
- (void)removeEmptyNote {
    for (int i = 0; i < self.noteArray.count; i ++) {
        ADNoteView *noteView = self.noteArray[i];
        if ([NSString isNULL:noteView.text]) {
            [noteView removeFromSuperview];
            [self.noteArray removeObject:noteView];
        }
    }
    [self refreshNoteArray];
}

#pragma mark - Actions
- (void)removeCurrentNoteView:(ADNoteView *)noteView {
    [self.noteArray removeObject:noteView];
    [noteView removeFromSuperview];
    [self refreshNoteArray];
    [self addUndoSteps];
}

- (void)removeCurrentLayer:(ADDrawingLayer *)drawingLayer {
    [self.layerArray removeObject:drawingLayer];
    [drawingLayer removeFromSuperlayer];
    [self addUndoSteps]; //删除layer可撤回
}

//删除某个note之后，重新排列note序号
- (void)refreshNoteArray {
    for (int i = 0; i < self.noteArray.count; i ++) {
        ADNoteView *noteView = self.noteArray[i];
        if (noteView.index != i + 1) {
            //序号对不上
            noteView.index = i + 1;
        }
    }
}

//撤回一步
- (void)undoAction {
    [ADFeedbackManager excuteLightFeedback];
    if (!self.undoArray.count) {
        return;
    }
    
    //先清除
    [self clean];
    
    UndoModel *model = self.undoArray.lastObject;
    [self.undoArray removeObject:model];
    [self.redoArray addObject:model];
    
    //再重画
    [self redraw];
}

//前进一步
- (void)redoAction {
    [ADFeedbackManager excuteLightFeedback];
    if (!self.redoArray.count) {
        return;
    }
    
    //先清除
    [self clean];
    
    UndoModel *model = self.redoArray.lastObject;
    [self.redoArray removeObject:model];
    [self.undoArray addObject:model];
    
    //再重画
    [self redraw];
}

- (void)clean {
    //移除线段layer
    for (ADDrawingLayer *layer in self.layerArray) {
        [layer removeFromSuperlayer];
    }
    [self.layerArray removeAllObjects];
    //移除noteView
    for (ADNoteView *noteView in self.noteArray) {
        [noteView removeFromSuperview];
    }
    [self.noteArray removeAllObjects];
}

- (void)redraw {
    UndoModel *undoModel = self.undoArray.lastObject;
    //添加noteView
    for (NoteModel *noteModel in undoModel.noteArray) {
        ADNoteView *noteView = [[ADNoteView alloc] initWithStartPoint:CGPointFromString(noteModel.positionString)];
        noteView.noteModel = noteModel;
        [self addSubview:noteView];
        [self.noteArray addObject:noteView];
    }
    
    //添加drawLayer
    for (LineLayerModel *layerModel in undoModel.layerArray) {
        ADDrawingLayer *drawingLayer = [ADDrawingLayer createLayerWithStartPoint:CGPointFromString(layerModel.startPointString) type:self.drawingType];
        drawingLayer.layerModel = layerModel;
        [self.layer addSublayer:drawingLayer];
        [self.layerArray addObject:drawingLayer];
    }
}

//计算点到线段的距离
- (double)calculateDistanceFromTouchPoint:(CGPoint)touchPoint toStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint {
    double x1 = startPoint.x;
    double y1 = startPoint.y;
    double x2 = endPoint.x;
    double y2 = endPoint.y;
    double x3 = touchPoint.x;
    double y3 = touchPoint.y;
    
    double px = x2 - x1;
    double py = y2 - y1;
    double som = px * px + py * py;
    double u = ((x3 - x1) * px + (y3 - y1) * py) / som;
    if (u > 1) {
        u = 1;
    }
    if (u < 0) {
        u = 0;
    }
    //the closest point
    double x = x1 + u * px;
    double y = y1 + u * py;
    double dx = x - x3;
    double dy = y - y3;
    double dist = sqrt(dx*dx + dy*dy);
    
    return dist;
}

//计算两点距离
- (double)distanceBetweenTwoPoint:(CGPoint)point1 point2:(CGPoint)point2 {
    return sqrtf(powf(point1.x - point2.x, 2) + powf(point1.y - point2.y, 2));
}

#pragma mark - Setter
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    if (self.selectedLayer) {
        self.selectedLayer.lineColor = self.lineColor;
        [self addUndoSteps]; //选中线段改颜色可撤回
    }
}

- (void)setDrawingType:(ADDrawingType)drawingType {
    _drawingType = drawingType;
}

- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    [self addSubview:self.bgImageView];
    self.bgImageView.image = bgImage;
}

- (void)setIsColorMode:(BOOL)isColorMode {
    _isColorMode = isColorMode;
}

#pragma mark - LazzyLoad
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImageView;
}

- (NSMutableArray *)layerArray {
    if (!_layerArray) {
        _layerArray = [NSMutableArray new];
    }
    return _layerArray;
}

- (NSMutableArray *)previousLayerArray {
    if (!_previousLayerArray) {
        _previousLayerArray = [NSMutableArray new];
    }
    return _previousLayerArray;
}

- (NSMutableArray *)noteArray {
    if (!_noteArray) {
        _noteArray = [NSMutableArray new];
    }
    return _noteArray;
}

- (NSMutableArray *)previousNoteArray {
    if (!_previousNoteArray) {
        _previousNoteArray = [NSMutableArray new];
    }
    return _previousNoteArray;
}

- (NSMutableArray *)undoArray {
    if (!_undoArray) {
        _undoArray = [NSMutableArray new];
    }
    return _undoArray;
}

- (NSMutableArray *)redoArray {
    if (!_redoArray) {
        _redoArray = [NSMutableArray new];
    }
    return _redoArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
