//
//  RuntimeUtil.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeUtil : NSObject

/**
 获取类名
 
 @param class 相应类
 @return NSString：类名
 */
+ (NSString *)getClassName:(Class)class;

/**
 获取成员变量
 
 @param class 成员变量所在的类
 @return 返回成员变量字符串数组
 */
+ (NSArray *)getIvarList:(Class)class;

/**
 获取类的属性列表, 包括私有和公有属性，即定义在延展中的属性
 
 @param class Class
 @return 属性列表数组
 */
+ (NSArray *)getPropertyList:(Class)class;

/**
 获取对象方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @param class 方法所在的类
 @return 该类的方法列表
 */
+ (NSArray *)getMethodList:(Class)class;

/**
 获取协议列表
 
 @param class 实现协议的类
 @return 返回该类实现的协议列表
 */
+ (NSArray *)getProtocolList:(Class)class;


/**
 添加新的方法
 
 @param class 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+ (void)addMethod: (Class)class method:(SEL)methodSel method:(SEL)methodSelImpl;

/**
 
 方法交换
 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2;

@end

NS_ASSUME_NONNULL_END
