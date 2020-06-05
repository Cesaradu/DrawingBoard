//
//  ViewController.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ViewController.h"
#import "ADDrawingBoard.h"
#import "ADTabBar.h"
#import "ColorView.h"
#import "InputView.h"
#import "ToolView.h"
#import "LayerTypeView.h"

@interface ViewController () <ADDrawingBoardDelegate, ToolViewDelegate> {
    NSInteger _oldIndex;
}

@property (nonatomic, strong) ADDrawingBoard *drawingBoard;
@property (nonatomic, strong) ADTabBar *tabBar;
@property (nonatomic, strong) ColorView *colorView;
@property (nonatomic, strong) InputView *inputView;
@property (nonatomic, strong) ToolView *toolView;
@property (nonatomic, strong) LayerTypeView *typeView;

@property (nonatomic, strong) ADNoteView *selectedNoteView;
@property (nonatomic, strong) ADDrawingLayer *selectedLayer;

@property (nonatomic, assign) ADDrawingType drawingType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSetting];
    [self buildUI];
    
}

- (void)initSetting {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:BGDarkColor]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = self.toolView;
}

- (void)buildUI {
    [self.view addSubview:self.drawingBoard];
    [self.view addSubview:self.tabBar];
    WeakSelf(self);
    self.tabBar.clickImageTitleButtonBlock = ^(NSInteger tag) {
        weakSelf.tabBar.index = tag;
        [weakSelf clickImageTitleButton:tag];
    };
}

- (void)refreshTitleViewButtons {
    if (self.drawingBoard.undoArray.count > 0) {
        [self.toolView enableUndoButton];
    } else {
        [self.toolView disableUndoButton];
    }
    
    if (self.drawingBoard.redoArray.count) {
        [self.toolView enableRedoButton];
    } else {
        [self.toolView disableRedoButton];
    }
}

#pragma mark - ProjectTitleViewDelegate
- (void)deleteAction {
    if (self.tabBar.index == 1 && self.selectedNoteView) {
        //删除note
        [self.drawingBoard removeCurrentNoteView:self.selectedNoteView];
        [self hideInputView:YES];
        [self refreshTitleViewButtons];
    }
    if (self.tabBar.index == 2 && self.selectedLayer) {
        //删除layer
        [self.drawingBoard removeCurrentLayer:self.selectedLayer];
        [self.toolView disableDeleteButton];
        [self refreshTitleViewButtons];
    }
}

- (void)redoAction {
    [self hideColorView];
    [self.drawingBoard redoAction];
    self.drawingBoard.isColorMode = NO;
    [self refreshTitleViewButtons];
}

- (void)undoAction {
    [self hideColorView];
    [self.drawingBoard undoAction];
    self.drawingBoard.isColorMode = NO;
    [self refreshTitleViewButtons];
    [self hideInputView:YES];
}

#pragma mark - ADDrawingBoardDelegate
- (void)didSelectDrawingLayer:(ADDrawingLayer *)drawingLayer {
    self.selectedLayer = drawingLayer;
    if (drawingLayer) {
        if (self.tabBar.index != 0) {
            [self.toolView enableDeleteButton];
        }
    } else {
        [self.toolView disableDeleteButton];
    }
}

- (void)didSelectNoteTextView:(ADNoteView *)noteView {
    if (noteView) {
        self.selectedNoteView = noteView;
        //若在颜色模式，不弹出
        if (self.tabBar.index != 0) {
            //选中note
            [self showInputView];
        }
    } else {
        [self hideInputView:YES];
    }
    
    WeakSelf(self);
    self.inputView.textDidChangeBlock = ^(NSString * _Nonnull text) {
        noteView.text = text;
        weakSelf.selectedNoteView.isTextChanged = YES;
    };
    
    self.inputView.clickConfirmBlock = ^(NSString * _Nonnull text) {
        noteView.text = text;
        noteView.isEditable = NO;
        [weakSelf hideInputView:YES];
    };
}

- (void)showInputView {
    self.inputView.noteText = self.selectedNoteView.text;
    [self.view addSubview:self.inputView];
    [UIView animateWithDuration:0.3 animations:^{
        self.inputView.frame = CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR - self.inputView.height, ScreenWidth, self.inputView.height);
    } completion:^(BOOL finished) {
        [self.inputView setNeedsLayout];
        self.drawingBoard.isEntering = YES;
        [self.toolView enableDeleteButton];
    }];
}

- (void)hideInputView:(BOOL)disableDeleteBtn {
    [self.inputView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.inputView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.inputView.height);
    } completion:^(BOOL finished) {
        self.drawingBoard.isEntering = NO;
        [self.inputView removeFromSuperview];
        if (disableDeleteBtn) {
            [self.toolView disableDeleteButton];
        }
        if (self.selectedNoteView.isTextChanged) {
            [self.drawingBoard addUndoSteps];
            [self refreshTitleViewButtons];
        }
        self.selectedNoteView.isTextChanged = NO;
        self.selectedNoteView = nil;
    }];
}

- (void)currentDrawingType:(ADDrawingType)drawingType {
    if (self.tabBar.index == 0) {
        return;
    }
    switch (drawingType) {
        case ADDrawingTypeText: {
            self.tabBar.index = 1;
        }
            break;

        default: {
            //除了text，其余都是2
            self.tabBar.index = 2;
            if (self.inputView) {
                [self hideInputView:NO];
            }
        }
            break;
    }
    _oldIndex = self.tabBar.index;
    [self refreshTitleViewButtons];
}

- (void)didTouchEmptyZone {
    [self hideColorView];
    self.tabBar.index = _oldIndex;
}

- (void)didEndMoveAndTouchAction {
    [self refreshTitleViewButtons];
}

#pragma mark - ClickTabBar
- (void)clickImageTitleButton:(NSInteger)tag {
    switch (tag) {
        case 0: {
            [self showColorView];
            [self hideTypeView];
            self.drawingBoard.isColorMode = YES;
            break;
        }
            
        case 1: {
            [self hideColorView];
            [self hideTypeView];
            self.drawingBoard.drawingType = ADDrawingTypeText;
            self.drawingBoard.isColorMode = NO;
            _oldIndex = self.tabBar.index;
            break;
        }
            
        case 2: {
            [self hideColorView];
            if (_oldIndex == 2) {
                [self showTypeView];
            }
            self.drawingBoard.drawingType = self.drawingType;
            self.drawingBoard.isColorMode = NO;
            _oldIndex = self.tabBar.index;
            break;
        }
    }
    [self refreshTitleViewButtons];
}

- (void)showTypeView {
    if ([self.view.subviews containsObject:self.typeView]) {
        [self hideTypeView];
        self.tabBar.index = _oldIndex;
    } else {
        [self.view insertSubview:self.typeView belowSubview:self.tabBar];
        [UIView animateWithDuration:0.3 animations:^{
            self.typeView.frame = CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR - self.tabBar.height - self.typeView.height, ScreenWidth, self.typeView.height);
        }];
    }
}

- (void)hideTypeView {
    [UIView animateWithDuration:0.3 animations:^{
        self.typeView.frame = CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR, ScreenWidth, self.typeView.height);
    } completion:^(BOOL finished) {
        [self.typeView removeFromSuperview];
    }];
}

- (void)showColorView {
    if ([self.view.subviews containsObject:self.colorView]) {
        [self hideColorView];
        self.tabBar.index = _oldIndex;
    } else {
        [self.view insertSubview:self.colorView belowSubview:self.tabBar];
        [UIView animateWithDuration:0.3 animations:^{
            self.colorView.frame = CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR - self.tabBar.height - self.colorView.height, ScreenWidth, self.colorView.height);
        }];
    }
}

- (void)hideColorView {
    [UIView animateWithDuration:0.3 animations:^{
        self.colorView.frame = CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR, ScreenWidth, self.colorView.height);
    } completion:^(BOOL finished) {
        [self.colorView removeFromSuperview];
        self.drawingBoard.isColorMode = NO;
    }];
}

- (void)refreshColor:(NSDictionary *)dict {
    self.drawingBoard.lineColor = [UIColor colorWithHexString:dict[@"color"]];
    self.tabBar.titleImageArray = @[@{@"image_normal": dict[@"imageNormal"], @"image_select": dict[@"imageCurrent"], @"title": @"颜色"},
                                  @{@"image_normal": @"note_normal", @"image_select": @"note_selected", @"title": @"颜色"},
                                  @{@"image_normal": @"distance_normal", @"image_select": @"distance_selected", @"title": @"线段"}];
}

- (ADDrawingBoard *)drawingBoard {
    if (!_drawingBoard) {
        _drawingBoard = [[ADDrawingBoard alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - HEIGHT_NAVBAR - self.tabBar.height)];
        _drawingBoard.backgroundColor = [UIColor colorWithHexString:BGDarkColor];
        _drawingBoard.bgImage = [UIImage imageNamed:@"bg"];
        _drawingBoard.delegate = self;
    }
    return _drawingBoard;
}

- (ADTabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = [[ADTabBar alloc] initWithFrame:CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR - (IS_SPECIALHEIGHTBAR ? 90 : 80), ScreenWidth, (IS_SPECIALHEIGHTBAR ? 90 : 80))];
        _tabBar.backgroundColor = [UIColor colorWithHexString:BGDarkColor];
        _tabBar.titleImageArray = @[@{@"image_normal": @"color_yellow_normal", @"image_select": @"color_yellow_current", @"title": @"颜色"},
                                  @{@"image_normal": @"note_normal", @"image_select": @"note_selected", @"title": @"备注"},
                                  @{@"image_normal": @"distance_normal", @"image_select": @"distance_selected", @"title": @"线段"}];
        _tabBar.index = 2;
        _oldIndex = _tabBar.index;
    }
    return _tabBar;
}

- (ColorView *)colorView {
    if (!_colorView) {
        _colorView = [[ColorView alloc] initWithFrame:CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR, ScreenWidth, 60)];
        WeakSelf(self);
        _colorView.selectBlock = ^(NSDictionary * _Nonnull dict) {
            [weakSelf refreshColor:dict];
        };
    }
    return _colorView;
}

- (InputView *)inputView {
    if (!_inputView) {
        _inputView = [[InputView alloc] initWithFrame:CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR, ScreenWidth, self.tabBar.height)];
    }
    return _inputView;
}

- (ToolView *)toolView {
    if (!_toolView) {
        _toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, 0, 180, HEIGHT_NAVBAR - HEIGHT_STATUSBAR)];
        _toolView.delegate = self;
    }
    return _toolView;
}

- (LayerTypeView *)typeView {
    if (!_typeView) {
        _typeView = [[LayerTypeView alloc] initWithFrame:CGRectMake(0, ScreenHeight - HEIGHT_NAVBAR, ScreenWidth, 60)];
        WeakSelf(self);
        _typeView.selectBlock = ^(NSDictionary * _Nonnull dict) {
            weakSelf.drawingType = (ADDrawingType)[dict[@"type"] integerValue];
            weakSelf.drawingBoard.drawingType = weakSelf.drawingType;
            weakSelf.typeView.selectIndexPath = [NSIndexPath indexPathForRow:[dict[@"type"] integerValue] inSection:0];
            [weakSelf hideTypeView];
        };
    }
    return _typeView;
}

@end
