//
//  LayerTypeView.m
//  DrawingBoard
//
//  Created by admin on 2020/6/5.
//  Copyright © 2020 Adu. All rights reserved.
//

#import "LayerTypeView.h"
#import "SelectCell.h"

@interface LayerTypeView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation LayerTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInit];
        [self buildUI];
    }
    return self;
}

- (void)configInit {
    self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.8];
    self.selectIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
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
    return self.typeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCell" forIndexPath:indexPath];
    [cell.image setImage:[UIImage imageNamed:self.typeArray[indexPath.row][@"imageName"]] forState:UIControlStateNormal];
    if ([indexPath isEqual:self.selectIndexPath]) {
        cell.image.selected = YES;
        cell.image.backgroundColor = [UIColor darkGrayColor];
        cell.image.layer.cornerRadius = 20;
        cell.layer.masksToBounds = YES;
    } else {
        cell.image.selected = NO;
        cell.image.backgroundColor = [UIColor clearColor];
        cell.image.layer.cornerRadius = 0;
        cell.layer.masksToBounds = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    [self.collectionView reloadData];
    if (self.selectBlock) {
        self.selectBlock(self.typeArray[indexPath.row]);
    }
}

- (NSArray *)typeArray {
    if (!_typeArray) {
        _typeArray = @[@{@"imageName": @"class_graffiti", @"type": @"0"},
                       @{@"imageName": @"class_straightline", @"type": @"1"},
                       @{@"imageName": @"class_dottedline", @"type": @"2"},
                       @{@"imageName": @"class_rulerline", @"type": @"3"},
                       @{@"imageName": @"class_arrow", @"type": @"4"},
                       @{@"imageName": @"class_rulerarrow", @"type": @"5"},
                       @{@"imageName": @"class_triangle", @"type": @"6"},
                       @{@"imageName": @"class_rectangle", @"type": @"7"},
                       @{@"imageName": @"class_diamond", @"type": @"8"},
                       @{@"imageName": @"class_trapezoid", @"type": @"9"},
                       @{@"imageName": @"class_pentagon", @"type": @"10"},
                       @{@"imageName": @"class_hexagon", @"type": @"11"},
                       @{@"imageName": @"class_circular", @"type": @"12"},
                       @{@"imageName": @"class_oval", @"type": @"13"}];
    }
    return _typeArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
