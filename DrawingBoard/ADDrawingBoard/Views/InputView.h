//
//  InputView.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputView : UIView

//输入最大行数
@property (nonatomic, assign) NSInteger maxLine;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSString *noteText;

@property (nonatomic, copy) void (^textDidChangeBlock)(NSString *text);
@property (nonatomic, copy) void (^clickConfirmBlock)(NSString *text);

- (void)becomeFirstResponder;
- (void)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
