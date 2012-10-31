//
//  DCScribbleMemento.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCScribbleMemento.h"
#import "DCScribbleMemento+Friend.h"
#import "DCMark.h"

@implementation DCScribbleMemento

@synthesize mark = _mark;
@synthesize hasCompleteSnapshot = _hasCompleteSnapshot;

- (NSData *)data
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.mark];
    return data;
}

+ (DCScribbleMemento *)mementoWithData:(NSData *)data
{
    // It raises an NSInvalidArchiveOperationException if data is not a valid archive
    id<DCMark> retoredMark = (id<DCMark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    DCScribbleMemento *memento = [[[DCScribbleMemento alloc] initWithMark:retoredMark] autorelease];
    
    return memento;
}

- (void) dealloc
{
    self.mark = nil;
    [super dealloc];
}

#pragma mark Private methods

- (id)initWithMark:(id<DCMark>)aMark
{
    if (self = [super init])
    {
        self.mark = aMark;
    }
    
    return self;
}

@end
