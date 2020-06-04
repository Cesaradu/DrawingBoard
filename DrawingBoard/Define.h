//
//  Define.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#ifndef Define_h
#define Define_h

//屏幕宽高
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width

// 系统判定
#define IOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IOS8        (IOS_VERSION >= 8.0 && IOS_VERSION < 9.0)
#define IS_IOS9        (IOS_VERSION >= 9.0 && IOS_VERSION < 10.0)
#define IS_IOS10       (IOS_VERSION >= 10.0 && IOS_VERSION < 11.0)
#define IS_IOS11       (IOS_VERSION >= 11.0 && IOS_VERSION < 12.0)
#define IS_IOS12       (IOS_VERSION >= 12.0 && IOS_VERSION < 13.0)
#define IS_IOS13       (IOS_VERSION >= 13.0 && IOS_VERSION < 14.0)

#define IS_ABOVE_IOS10  IOS_VERSION >= 10.0
#define IS_ABOVE_IOS13  IOS_VERSION >= 13.0

// 屏幕判定（最低5）
#define IS_IPHONE4INCH      (ScreenHeight == 568 ? YES : NO)//5，se
#define IS_IPHONE47INCH     (ScreenHeight == 667 ? YES : NO)//6, 7，8
#define IS_IPHONE55INCH     (ScreenHeight == 736 ? YES : NO)//6,7,8 plus
#define IS_IPHONE58INCH     (ScreenHeight == 812 ? YES : NO)//x, xs
#define IS_IPHONE6INCH      (ScreenHeight == 896 ? YES : NO)//xr, xs max

// naviBar, statusBar, tabBar
#define IS_SPECIALHEIGHTBAR         ((IS_IPHONE58INCH || IS_IPHONE6INCH) ? YES : NO)
#define HEIGHT_STATUSBAR            [UIApplication sharedApplication].statusBarFrame.size.height
#define HEIGHT_TABBAR               (IS_SPECIALHEIGHTBAR ? 83 : 49)
#define HEIGHT_NAVBAR               (IS_SPECIALHEIGHTBAR ? 88 : 64)
#define EXTRA_HEIGHT_STATUSBAR      (HEIGHT_STATUSBAR - 20) //额外增加的状态栏高度（打电话时、定位时、连接热点时等）

#define OnePX   ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)
#define WeakSelf(type) __weak __typeof__(type) weakSelf = type;

#define MainColor       @"F5C242"
#define BGDarkColor     @"1D1D1D"
#define BGLightColor    @"2C2C2C"
#define TextColor       @"1D1D1D"
#define LineColor       @"3A3A3C"
#define NaviColor       @"CCCCCC"
#define RedColor        @"FF2D55"
#define YellowColor     @"FCC344"
#define GreenColor      @"00D39C"
#define BlueColor       @"52A3FD"
#define Whitecolor      @"FFFFFF"
#define Blackcolor      @"000000"

#endif /* Define_h */
