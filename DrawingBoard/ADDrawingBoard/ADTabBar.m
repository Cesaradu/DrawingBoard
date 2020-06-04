//
//  ADTabBar.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ADTabBar.h"

@interface ADTabBar ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *line;

@end

@implementation ADTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self configInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self removeAllSubviews];
    
    if (self.titleNameArray.count) {
        [self buildTitleButton];
    }
    if (self.imageNameArray.count) {
        [self buildImageButton];
    }
    if (self.titleImageArray.count) {
        [self builtTitleImageButton];
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (void)setTitleNameArray:(NSArray *)titleNameArray {
    [self.buttonArray removeAllObjects];
    _titleNameArray = titleNameArray;
    [self buildTitleButton];
}

- (void)setImageNameArray:(NSArray *)imageNameArray {
    [self.buttonArray removeAllObjects];
    _imageNameArray = imageNameArray;
    [self buildImageButton];
}

- (void)setTitleImageArray:(NSArray *)titleImageArray {
    [self.buttonArray removeAllObjects];
    _titleImageArray = titleImageArray;
    [self builtTitleImageButton];
}

- (void)setIsHighlight:(BOOL)isHighlight {
    _isHighlight = isHighlight;
    if (!isHighlight) {
        for (int i = 0; i < self.buttonArray.count; i ++) {
            UIButton *button = self.buttonArray[i];
            [button setTitleColor:[UIColor colorWithHexString:@"212121"] forState:UIControlStateNormal];
        }
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *button = self.buttonArray[i];
        button.titleLabel.font = titleFont;
        [self adjustButtonImageViewUPTitleDownWithButton:button withIVOffsetY:5 withTitleSpace:0];
    }
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *btn = self.buttonArray[i];
        if (index == btn.tag - 1000) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)adjustButtonWithImageOffsetY:(float)imageOffset withTitleSpace:(float)titleSpace {
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *button = self.buttonArray[i];
        [self adjustButtonImageViewUPTitleDownWithButton:button withIVOffsetY:imageOffset withTitleSpace:titleSpace];
    }
}

- (void)setIsShowLine:(BOOL)isShowLine {
    _isShowLine = isShowLine;
    if (isShowLine) {
        [self addSubview:self.line];
    }
}

- (void)configInit {
    self.backgroundColor = [UIColor whiteColor];
    self.index = 0;
    self.isHighlight = YES;
    self.isShowLine = NO;
}

- (void)buildTitleButton {
    CGFloat buttonWidth = self.width/self.titleNameArray.count;
    CGFloat buttonHeight = self.height;
    for (int i = 0; i < self.titleNameArray.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight)];
        [button setTitle:self.titleNameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"8a8a8a"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:TextColor] forState:UIControlStateSelected];
        button.tag = 1000 + i;
        if (i == self.index) {
            button.selected = YES;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        } else {
            button.selected = NO;
            button.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        [self.buttonArray addObject:button];
        [button addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buildImageButton {
    CGFloat buttonWidth = self.width/self.imageNameArray.count;
    CGFloat buttonHeight = self.height;
    for (int i = 0; i < self.imageNameArray.count; i ++) {
        NSDictionary *dict = self.imageNameArray[i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight)];
        [button setImage:[UIImage imageNamed:dict[@"image_normal"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dict[@"image_select"]] forState:UIControlStateSelected];
        button.tag = 1000 + i;
        if (i == self.index) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
        [self.buttonArray addObject:button];
        [button addTarget:self action:@selector(clickImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)builtTitleImageButton {
    CGFloat buttonWidth = self.width/self.titleImageArray.count;
    CGFloat buttonHeight = self.height;
    for (int i = 0; i < self.titleImageArray.count; i ++) {
        NSDictionary *dict = self.titleImageArray[i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight)];
        [button setImage:[UIImage imageNamed:dict[@"image_normal"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dict[@"image_select"]] forState:UIControlStateSelected];
        [button setTitle:dict[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"C7C7CC"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:MainColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        button.tag = 1000 + i;
        if (i == self.index && self.isHighlight) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
        [self.buttonArray addObject:button];
        [self adjustButtonImageViewUPTitleDownWithButton:button withIVOffsetY:IS_SPECIALHEIGHTBAR ? 15 : 10 withTitleSpace:IS_SPECIALHEIGHTBAR ? 5 : 2.5];
        [button addTarget:self action:@selector(clickTitleImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)adjustButtonImageViewUPTitleDownWithButton:(UIButton *)button withIVOffsetY:(float)iVOffsetY withTitleSpace:(float)titleSpace {
    [button.superview layoutIfNeeded];
    //使图片和文字居左上角
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CGFloat buttonWidth = CGRectGetWidth(button.frame);
    CGFloat ivWidth = CGRectGetWidth(button.imageView.frame);
    CGFloat titleWidth = CGRectGetWidth(button.titleLabel.frame);
    //调整图片
    float iVOffsetX = buttonWidth / 2.0 - ivWidth / 2.0;
    [button setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
    
    //调整文字
    float titleOffsetY = iVOffsetY + CGRectGetHeight(button.imageView.frame) + titleSpace;
    float titleOffsetX = 0;
    if (CGRectGetWidth(button.imageView.frame) >= (CGRectGetWidth(button.frame) / 2.0)) {
        //如果图片的宽度超过或等于button宽度的一半
        titleOffsetX = -(ivWidth + titleWidth - buttonWidth / 2.0 - titleWidth / 2.0);
    } else {
        titleOffsetX = buttonWidth / 2.0 - ivWidth - titleWidth / 2.0;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
}

- (void)clickTitleButton:(UIButton *)button {
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *btn = self.buttonArray[i];
        if (button.tag == btn.tag && self.isHighlight) {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        } else {
            btn.selected = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    
    if (self.clickTitleButtonBlock) {
        self.clickTitleButtonBlock(button.tag - 1000);
    }
}

- (void)clickImageButton:(UIButton *)button {
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *btn = self.buttonArray[i];
        if (button.tag == btn.tag) {
            btn.selected = YES;
            [self playAnimation:btn.imageView textLabel:btn.titleLabel];
        } else {
            btn.selected = NO;
            [self deselectAnimation:btn.imageView textLabel:btn.titleLabel];
        }
    }
    
    if (self.clickImageButtonBlock) {
        self.clickImageButtonBlock(button.tag - 1000);
    }
}

- (void)clickTitleImageButton:(UIButton *)button {
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *btn = self.buttonArray[i];
        if (button.tag == btn.tag && self.isHighlight) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    
    if (self.clickImageTitleButtonBlock) {
        self.clickImageTitleButtonBlock(button.tag - 1000);
    }
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray new];
    }
    return _buttonArray;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, OnePX)];
        _line.backgroundColor = [UIColor colorWithHexString:LineColor];
    }
    return _line;
}

#pragma mark - Animation
- (void)playAnimation:(UIImageView *)barIcon textLabel:(UILabel *)barTitle {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [barIcon.layer addAnimation:animation forKey:nil];
}

- (void)selectedState:(UIImageView *)barIcon textLabel:(UILabel *)barTitle {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = @(-2);
    animation.toValue = @(2);
    animation.duration = 0.25;
    animation.autoreverses = YES;
    animation.repeatCount = 1;
    [barIcon.layer addAnimation:animation forKey:nil];
}

- (void)deselectAnimation:(UIImageView *)barIcon textLabel:(UILabel *)barTitle {
    CATransition *transiton = [CATransition animation];
    transiton.type = kCATransitionFade;
    transiton.duration = 0.25;
    transiton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [barIcon.layer addAnimation:transiton forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
