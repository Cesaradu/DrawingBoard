//
//  InputView.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "InputView.h"

@interface InputView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInit];
        [self buildUI];
    }
    return self;
}

- (void)configInit {
    self.backgroundColor = [UIColor colorWithHexString:@"1D1D1D"];
    self.fontSize = 17;
    self.maxLine = 2;
}

- (void)buildUI {
    //发送按钮
    [self addSubview:self.confirmBtn];
    //背景
    [self addSubview:self.bgView];
    //输入框
    [self.bgView addSubview:self.textView];
    //占位文字
    [self.bgView addSubview:self.placeholderLabel];
}

- (void)layout {
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.width.height.mas_equalTo(48);
    }];

    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.confirmBtn.mas_centerY);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.confirmBtn.mas_left).offset(-16);
        make.height.mas_equalTo(self.textView.height + 16);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
        make.left.equalTo(self.bgView.mas_left).offset(16);
        make.top.equalTo(self.bgView.mas_top).offset(8);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textView.mas_centerY);
        make.left.equalTo(self.textView.mas_left).offset(2);
    }];
}

- (void)becomeFirstResponder {
    [self.textView becomeFirstResponder];
}

- (void)resignFirstResponder {
    [self.textView resignFirstResponder];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    if (!fontSize || _fontSize < 20) {
        _fontSize = 20;
    }
    self.textView.font = [UIFont systemFontOfSize:_fontSize];
    self.placeholderLabel.font = self.textView.font;
    [self getEmptyTextViewHeight];
}

- (void)getEmptyTextViewHeight {
    CGFloat lineH = self.textView.font.lineHeight;
    self.textView.height = lineH;
}

- (void)setNoteText:(NSString *)noteText {
    _noteText = noteText;
    self.textView.text = noteText;
    self.placeholderLabel.hidden = self.textView.text.length;
    self.confirmBtn.enabled = self.textView.text.length;
    
    [self getTextViewHeight];
}

- (void)setMaxLine:(NSInteger)maxLine {
    _maxLine = maxLine;
    if (!_maxLine || _maxLine <= 0) {
        _maxLine = 2;
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self calculateTextViewHeight];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length;
    self.confirmBtn.enabled = textView.text.length;
    [self calculateTextViewHeight];
    
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(self.textView.text);
    }
}

- (void)calculateTextViewHeight {
    [self getTextViewHeight];
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.selectedRange.location, 1)];
}

- (void)getTextViewHeight {
    CGFloat contentSizeH = self.textView.contentSize.height;
    CGFloat lineH = self.textView.font.lineHeight;
    CGFloat maxTextViewHeight = ceil(lineH * self.maxLine + self.textView.textContainerInset.top + self.textView.textContainerInset.bottom);
    if (contentSizeH <= maxTextViewHeight) {
        self.textView.height = contentSizeH;
    } else {
        self.textView.height = maxTextViewHeight;
    }
    [self layout];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self resignFirstResponder];
        return NO;
    }
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (toBeString.length > 40 && range.length != 1) {
        textView.text = [toBeString substringToIndex:40];
        return NO;
    }
    return YES;
}

- (void)didClickConfirmBtn {
    if (self.clickConfirmBlock) {
        self.clickConfirmBlock(self.textView.text);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self getTextViewHeight];
    self.bgView.layer.cornerRadius = (self.textView.height + 16) / 2;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithHexString:BGLightColor];
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.enabled = NO;
        [_confirmBtn setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(didClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.textContainer.lineFragmentPadding = 0;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.keyboardAppearance = UIKeyboardAppearanceDark;
        _textView.tintColor = [UIColor colorWithHexString:MainColor];
    }
    return _textView;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = @"请输入文本";
        _placeholderLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _placeholderLabel.font = [UIFont systemFontOfSize:17];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _placeholderLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
