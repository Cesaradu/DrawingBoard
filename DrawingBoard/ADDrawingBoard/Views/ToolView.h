//
//  ToolView.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ToolViewDelegate <NSObject>

- (void)deleteAction;
- (void)redoAction;
- (void)undoAction;

@end

@interface ToolView : UIView

@property (nonatomic, weak) id <ToolViewDelegate> delegate;

- (void)enableDeleteButton;
- (void)disableDeleteButton;
- (void)enableUndoButton;
- (void)disableUndoButton;
- (void)enableRedoButton;
- (void)disableRedoButton;

@end

NS_ASSUME_NONNULL_END
