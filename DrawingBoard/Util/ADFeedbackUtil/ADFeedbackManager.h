//
//  ADFeedbackManager.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADFeedbackManager : NSObject

#pragma mark - UINotificationFeedbackGenerator
+ (void)executeSuccessFeedback;
+ (void)executeWarningFeedback;
+ (void)excuteErrorFeedback;

#pragma mark - UIImpactFeedbackGenerator
+ (void)excuteLightFeedback;
+ (void)excuteMediumFeedback;
+ (void)excuteHeavyFeedback;

#pragma mark - UISelectionFeedbackGenerator
+ (void)excuteSelectionFeedback;

@end

NS_ASSUME_NONNULL_END
