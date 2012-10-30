//
//  NSMutableArray+Stack.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void)push:(id)object {
    if (object != nil) {
        [self addObject:object];
    }
}

- (id)pop {
    if ([self count] == 0) {
        return nil;
    } else {
        id object = [[[self lastObject] retain] autorelease];
        [self removeLastObject];
        
        return object;
    }
}

- (void)dropBottom {
    if ([self count] == 0) {
        return;
    } else {
        [self removeObjectAtIndex:0];
    }
}

@end
