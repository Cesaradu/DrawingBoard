//
//  ColorView.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorView : UIView

@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (nonatomic, copy) void (^selectBlock)(NSDictionary *dict);

@end

NS_ASSUME_NONNULL_END
