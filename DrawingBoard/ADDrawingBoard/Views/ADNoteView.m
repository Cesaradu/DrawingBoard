//
//  ADNoteView.m
//  DrawingBoard
//
//  Created by admin on 2020/3/24.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADNoteView.h"

@interface ADNoteView ()

@property (nonatomic, strong) UIButton *indexBtn; //索引
@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, assign) CGFloat textWidth; //文本宽度

@end

@implementation ADNoteView

- (instancetype)initWithStartPoint:(CGPoint)startPoint {
    if (self = [super init]) {
        self.position = startPoint;
        [self configInit];
        [self buildUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.size = CGSizeMake(28 + (self.textWidth == 0 ? 0 : 4) + self.textWidth + (self.textWidth == 0 ? 0 : 10), 28);
    self.center = self.position;
    [self rectLimit];
}

- (void)rectLimit {
    if (self.x <= 0) {
        self.x = 0;
        [self toLeft];
    } else if (self.x >= self.superview.width - self.width) {
        self.x = self.superview.width - self.width;
        [self toRight];
    } else {
        if (self.isIndexLeft) {
            [self toLeft];
        } else {
            [self toRight];
        }
    }
}

- (void)toLeft {
    self.isIndexLeft = YES;
    self.noteLabel.frame = CGRectMake(32, 0, self.textWidth, 28);
    [self.indexBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(self.indexBtn.mas_height);
    }];
}

- (void)toRight {
    self.isIndexLeft = NO;
    self.noteLabel.frame = CGRectMake((self.textWidth == 0 ? 0 : 10), 0, self.textWidth, 28);
    [self.indexBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(self.indexBtn.mas_height);
    }];
}

- (void)configInit {
    self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.8];
    self.layer.cornerRadius = 14;
    [self.layer setShouldRasterize:YES];
    [self.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    self.isIndexLeft = YES;
    self.size = CGSizeMake(28, 28);
    self.center = self.position;
}

- (void)buildUI {
    [self addSubview:self.indexBtn];
    [self.indexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(self.indexBtn.mas_height);
    }];
    [self addSubview:self.noteLabel];
}

- (void)moveToPointWithCurrentPoint:(CGPoint)currentPoint andPreviousPoint:(CGPoint)previousPoint {
    CGFloat offsetX = currentPoint.x - previousPoint.x; //x轴偏移的量
    CGFloat offsetY = currentPoint.y - previousPoint.y; //Y轴偏移的量
    self.position = CGPointMake(self.position.x + offsetX, self.position.y + offsetY);
    [self setNeedsLayout];
}

- (void)setIndex:(int)index {
    _index = index;
    [self.indexBtn setTitle:[NSString stringWithFormat:@"%d", index] forState:UIControlStateNormal];
}

- (void)setText:(NSString *)text {
    _text = text;
    //计算宽度
    CGFloat width = [self getSpaceLabelWidth:text withHeight:28 withFont:[UIFont systemFontOfSize:13]];
    CGFloat totalWidth = width + 42;
    if (self.position.x <= totalWidth/2 && self.position.x <= ScreenWidth/2) {
        //顶到了最左边
        self.position = CGPointMake(totalWidth/2, self.position.y);
        self.isIndexLeft = YES;
    }
    if ((ScreenWidth - self.position.x) <= totalWidth/2 && self.position.x > ScreenWidth/2) {
        //顶到了最右边
        self.position = CGPointMake(ScreenWidth - totalWidth/2, self.position.y);
        self.isIndexLeft = NO;
    }
    self.textWidth = width;
    self.noteLabel.text = text;
    [self setNeedsLayout];
}

- (CGFloat)getSpaceLabelWidth:(NSString *)str withHeight:(CGFloat)height withFont:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(100000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.indexBtn.backgroundColor = [UIColor colorWithHexString:MainColor];
        [self.indexBtn setTitleColor:[UIColor colorWithHexString:BGLightColor] forState:UIControlStateNormal];
    } else {
        self.indexBtn.backgroundColor = [UIColor colorWithHexString:BGDarkColor];
        [self.indexBtn setTitleColor:[UIColor colorWithHexString:MainColor] forState:UIControlStateNormal];
    }
}

- (void)setNoteModel:(NoteModel *)noteModel {
    _noteModel = noteModel;
    self.position = CGPointFromString(noteModel.positionString);
    self.index = noteModel.noteId;
    self.text = noteModel.noteText;
    self.isIndexLeft = noteModel.isIndexLeft;
}

- (UIButton *)indexBtn {
    if (!_indexBtn) {
        _indexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _indexBtn.userInteractionEnabled = NO;
        _indexBtn.size = CGSizeMake(28, 28);
        _indexBtn.backgroundColor = [UIColor colorWithHexString:BGDarkColor];
        _indexBtn.layer.cornerRadius = 14;
        [_indexBtn setTitleColor:[UIColor colorWithHexString:MainColor] forState:UIControlStateNormal];
        _indexBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _indexBtn.layer.borderColor = [UIColor colorWithHexString:BGDarkColor].CGColor;
        _indexBtn.layer.borderWidth = 1.f;
        [_indexBtn.layer setShouldRasterize:YES];
        [_indexBtn.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    }
    return _indexBtn;
}

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textColor = [UIColor colorWithHexString:@"F6F7FA"];
        _noteLabel.font = [UIFont systemFontOfSize:13];
        _noteLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _noteLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
