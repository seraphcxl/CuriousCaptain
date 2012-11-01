//
//  DCScribble.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCScribble.h"
#import "DCScribbleMemento+Friend.h"
#import "DCStroke.h"

@interface DCScribble () {
    id<DCMark> _incrementalMark;
}

@property (nonatomic, retain) id<DCMark> mark;

@end

@implementation DCScribble

@synthesize mark = _mark;

- (id)init {
    if (self = [super init]) {
        // the parent should be a composite
        // object (i.e. Stroke)
        _mark = [[DCStroke alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    [_incrementalMark release];
    [_mark release];
    [super dealloc];
}

#pragma mark Methods for Mark management

- (void)addMark:(id<DCMark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark {
    // manual KVO invocation
    [self willChangeValueForKey:@"mark"];
    
    // if the flag is set to YES
    // then add this aMark to the
    // *PREVIOUS*Mark as part of an
    // aggregate.
    // Based on our design, it's supposed
    // to be the last child of the main
    // parent
    if (shouldAddToPreviousMark) {
        [[self.mark lastChild] addMark:aMark];
    } else { // otherwise attach it to the parent
        [self.mark addMark:aMark];
        _incrementalMark = [aMark retain];
    }
    
    // manual KVO invocation
    [self didChangeValueForKey:@"mark"];
}

- (void)removeMark:(id<DCMark>)aMark {
    // do nothing if aMark is the parent
    if (aMark == self.mark) {
        return;
    }
    
    // manual KVO invocation
    [self willChangeValueForKey:@"mark"];
    
    [self.mark removeMark:aMark];
    
    // we don't need to keep the
    // incrementalMark_ reference
    // as it's just removed in the parent
    if (aMark == _incrementalMark) {
        [_incrementalMark release];
        _incrementalMark = nil;
    }
    
    // manual KVO invocation
    [self didChangeValueForKey:@"mark"];
}

#pragma mark Methods for memento

- (id)initWithMemento:(DCScribbleMemento *)aMemento {
    if (self = [super init]) {
        if ([aMemento hasCompleteSnapshot]) {
            [self setMark:[aMemento mark]];
        } else {
            // if the memento contains only
            // incremental mark, then we need to
            // create a parent Stroke object to
            // hold it
            _mark = [[DCStroke alloc] init];
            [self attachStateFromMemento:aMemento];
        }
    }
    
    return self;
}


- (void)attachStateFromMemento:(DCScribbleMemento *)memento {
    // attach any mark from a memento object
    // to the main parent
    [self addMark:[memento mark] shouldAddToPreviousMark:NO];
}


- (DCScribbleMemento *)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot {
    id<DCMark> mementoMark = _incrementalMark;
    
    // if the resulting memento asks
    // for a complete snapshot, then
    // set it with parentMark_
    if (hasCompleteSnapshot) {
        mementoMark = self.mark;
    } else if (mementoMark == nil) { // but if _incrementalMark is nil then we can't do anything but bail out
        return nil;
    }
    
    DCScribbleMemento *memento = [[[DCScribbleMemento alloc] initWithMark:mementoMark] autorelease];
    [memento setHasCompleteSnapshot:hasCompleteSnapshot];
    
    return memento;
}


- (DCScribbleMemento *)scribbleMemento {
    return [self scribbleMementoWithCompleteSnapshot:YES];
}


+ (DCScribble *)scribbleWithMemento:(DCScribbleMemento *)aMemento {
    DCScribble *scribble = [[[DCScribble alloc] initWithMemento:aMemento] autorelease];
    return scribble;
}

@end
