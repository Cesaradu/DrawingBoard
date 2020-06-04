//
//  NoteModel.h
//  DrawingBoard
//
//  Created by admin on 2020/6/4.
//  Copyright © 2020 Adu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteModel : NSObject

@property (nonatomic, assign) int noteId;
@property (nonatomic, strong) NSString *positionString; //中心点
@property (nonatomic, strong) NSString *noteText;
@property (nonatomic, assign) BOOL isIndexLeft; //索引居左？

- (id)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
