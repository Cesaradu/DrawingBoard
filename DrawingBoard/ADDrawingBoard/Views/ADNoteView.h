//
//  ADNoteView.h
//  DrawingBoard
//
//  Created by admin on 2020/3/24.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADNoteView : UIView

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int index; //序号
@property (nonatomic, assign) BOOL isIndexLeft; //索引是否居左显示
@property (nonatomic, strong) NSString *text; //文本内容
@property (nonatomic, assign) BOOL isEditable; //是否可编辑
@property (nonatomic, assign) BOOL isMoved; //是否已移动
@property (nonatomic, assign) BOOL isTextChanged; //文本是否改变

@property (nonatomic, strong) NoteModel *noteModel;

- (instancetype)initWithStartPoint:(CGPoint)startPoint;

- (void)moveToPointWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint;

@end

NS_ASSUME_NONNULL_END
