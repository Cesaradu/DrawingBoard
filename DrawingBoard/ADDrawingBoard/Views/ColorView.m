//
//  ColorView.m
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "ColorView.h"
#import "SelectCell.h"

@interface ColorView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colorArray;

@end

@implementation ColorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInit];
        [self buildUI];
    }
    return self;
}

- (void)configInit {
    self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.8];
    self.selectIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
}

- (void)buildUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(40, 40)];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
    layout.minimumLineSpacing = (self.width - 240 - 36) / 5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SelectCell class] forCellWithReuseIdentifier:@"SelectCell"];
    [self addSubview:self.collectionView];
    
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCell" forIndexPath:indexPath];
    NSDictionary *dict = self.colorArray[indexPath.row];
    [cell.image setImage:[UIImage imageNamed:dict[@"imageNormal"]] forState:UIControlStateNormal];
    [cell.image setImage:[UIImage imageNamed:dict[@"imageSelect"]] forState:UIControlStateSelected];
    
    if ([indexPath isEqual:self.selectIndexPath]) {
        cell.image.selected = YES;
    } else {
        cell.image.selected = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    [self.collectionView reloadData];
    if (self.selectBlock) {
        self.selectBlock(self.colorArray[indexPath.row]);
    }
}

- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = @[@{@"imageNormal": @"color_red_normal", @"imageSelect": @"color_red_selected", @"imageCurrent": @"color_red_current", @"color": RedColor},
                        @{@"imageNormal": @"color_yellow_normal", @"imageSelect": @"color_yellow_selected", @"imageCurrent": @"color_yellow_current", @"color": YellowColor},
                        @{@"imageNormal": @"color_green_normal", @"imageSelect": @"color_green_selected", @"imageCurrent": @"color_green_current", @"color": GreenColor},
                        @{@"imageNormal": @"color_blue_normal", @"imageSelect": @"color_blue_selected", @"imageCurrent": @"color_blue_current", @"color": BlueColor},
                        @{@"imageNormal": @"color_white_normal", @"imageSelect": @"color_white_selected", @"imageCurrent": @"color_white_current", @"color": Whitecolor},
                        @{@"imageNormal": @"color_black_normal", @"imageSelect": @"color_black_selected", @"imageCurrent": @"color_black_current", @"color": Blackcolor}];
    }
    return _colorArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
