//
//  SelectCell.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [UIButton buttonWithType:UIButtonTypeCustom];
        self.image.userInteractionEnabled = NO;
        [self addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
