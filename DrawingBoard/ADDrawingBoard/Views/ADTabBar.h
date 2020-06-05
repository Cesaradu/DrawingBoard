//
//  ADTabBar.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADTabBar : UIView

@property (nonatomic, assign) BOOL isHighlight;
@property (nonatomic, assign) BOOL isShowLine;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) NSArray *titleNameArray;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, strong) NSArray *titleImageArray;

@property (nonatomic, copy) void (^clickTitleButtonBlock)(NSInteger tag);
@property (nonatomic, copy) void (^clickImageButtonBlock)(NSInteger tag);
@property (nonatomic, copy) void (^clickImageTitleButtonBlock)(NSInteger tag);

- (void)adjustButtonWithImageOffsetY:(float)imageOffset withTitleSpace:(float)titleSpace;


@end

NS_ASSUME_NONNULL_END
