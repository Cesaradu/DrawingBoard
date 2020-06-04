//
//  ToolView.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ToolView.h"

@interface ToolView ()

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *undoBtn; //撤销
@property (nonatomic, strong) UIButton *redoBtn; //反撤销

@end

@implementation ToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInit];
        [self buildUI];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(180, HEIGHT_NAVBAR - HEIGHT_STATUSBAR);
}

- (void)configInit {
    
}

- (void)buildUI {
    [self addSubview:self.redoBtn];
    [self.redoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(self.mas_height);
    }];

    [self addSubview:self.undoBtn];
    [self.undoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(self.redoBtn);
        make.right.equalTo(self.redoBtn.mas_left).offset(-16);
    }];

    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(self.redoBtn);
        make.left.equalTo(self.redoBtn.mas_right).offset(16);
    }];
}

- (void)clickDeleteButton {
    if ([self.delegate respondsToSelector:@selector(deleteAction)]) {
        [self.delegate deleteAction];
    }
}

- (void)clickRedoButton {
    if ([self.delegate respondsToSelector:@selector(redoAction)]) {
        [self.delegate redoAction];
    }
}

- (void)clickUndoButton {
    if ([self.delegate respondsToSelector:@selector(undoAction)]) {
        [self.delegate undoAction];
    }
}

- (void)enableDeleteButton {
    self.deleteBtn.selected = YES;
    self.deleteBtn.enabled = YES;
}

- (void)disableDeleteButton {
    self.deleteBtn.selected = NO;
    self.deleteBtn.enabled = NO;
}

- (void)enableRedoButton {
    self.redoBtn.selected = YES;
    self.redoBtn.enabled = YES;
}

- (void)disableRedoButton {
    self.redoBtn.selected = NO;
    self.redoBtn.enabled = NO;
}

- (void)enableUndoButton {
    self.undoBtn.selected = YES;
    self.undoBtn.enabled = YES;
}

- (void)disableUndoButton {
    self.undoBtn.selected = NO;
    self.undoBtn.enabled = NO;
}

- (UIButton *)redoBtn {
    if (!_redoBtn) {
        _redoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_redoBtn setImage:[UIImage imageNamed:@"redo"] forState:UIControlStateNormal];
        [_redoBtn setImage:[UIImage imageNamed:@"redo_selected"] forState:UIControlStateSelected];
        [_redoBtn addTarget:self action:@selector(clickRedoButton) forControlEvents:UIControlEventTouchUpInside];
        _redoBtn.selected = NO;
        _redoBtn.enabled = NO;
    }
    return _redoBtn;
}

- (UIButton *)undoBtn {
    if (!_undoBtn) {
        _undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_undoBtn setImage:[UIImage imageNamed:@"undo"] forState:UIControlStateNormal];
        [_undoBtn setImage:[UIImage imageNamed:@"undo_selected"] forState:UIControlStateSelected];
        [_undoBtn addTarget:self action:@selector(clickUndoButton) forControlEvents:UIControlEventTouchUpInside];
        _undoBtn.selected = NO;
        _undoBtn.enabled = NO;
    }
    return _undoBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete_selected"] forState:UIControlStateSelected];
        [_deleteBtn addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.selected = NO;
        _deleteBtn.enabled = NO;
    }
    return _deleteBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
