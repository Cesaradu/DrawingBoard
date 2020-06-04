//
//  ColorCell.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ColorCell.h"

@implementation ColorCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.colorImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.colorImage.userInteractionEnabled = NO;
        [self addSubview:self.colorImage];
        [self.colorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
