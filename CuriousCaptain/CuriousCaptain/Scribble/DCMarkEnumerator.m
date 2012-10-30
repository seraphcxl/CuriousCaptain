//
//  DCMarkEnumerator.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCMarkEnumerator.h"
#import "DCMarkEnumerator+Internal.h"

@interface DCMarkEnumerator () {
    
}

@end

@implementation DCMarkEnumerator

- (NSArray *)allObjects {
    // returns an array of yet-visited Mark nodes
    // i.e. the remaining elements in the stack
    return [[_stack reverseObjectEnumerator] allObjects];
}

- (id)nextObject {
    return [_stack pop];
}

- (void) dealloc {
    [_stack release];
    [super dealloc];
}

@end
