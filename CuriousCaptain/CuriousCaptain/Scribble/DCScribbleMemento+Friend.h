//
//  DCScribbleMemento+Friend.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCScribbleMemento.h"
#import "DCMark.h"

@interface DCScribbleMemento ()

@property (nonatomic, copy) id<DCMark> mark;
@property (nonatomic, assign) BOOL hasCompleteSnapshot;

- (id)initWithMark:(id<DCMark>)aMark;

@end
