//
//  DCScribble.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCMark.h"
#import "DCScribbleMemento.h"

@interface DCScribble : NSObject

// methods for Mark management
- (void)addMark:(id<DCMark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void)removeMark:(id<DCMark>)aMark;

// methods for memento
- (id)initWithMemento:(DCScribbleMemento *)aMemento;
+ (DCScribble *)scribbleWithMemento:(DCScribbleMemento *)aMemento;
- (DCScribbleMemento *)scribbleMemento;
- (DCScribbleMemento *)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot;
- (void)attachStateFromMemento:(DCScribbleMemento *)memento;

@end
