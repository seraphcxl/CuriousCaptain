//
//  DCMarkEnumerator+Internal.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCMarkEnumerator+Internal.h"
#import "DCMarkEnumerator.h"

@implementation DCMarkEnumerator (Internal)

- (id)initWithMark:(id<DCMark>)aMark {
    if (self = [super init]) {
        _stack = [[NSMutableArray alloc] initWithCapacity:[aMark count]];
        [self traverseAndBuildStackWithMark:aMark];
    }
    return self;
}

- (void)traverseAndBuildStackWithMark:(id <DCMark>)mark {
    // push post-order traversal
    // into the stack
    if (mark == nil) {
        return;
    }
    
    [_stack push:mark];
    
    NSUInteger index = [mark count];
    id<DCMark> childMark = nil;
    while (childMark == [mark childMarkAtIndex:--index]) {
        [self traverseAndBuildStackWithMark:childMark];
    }
}

@end
