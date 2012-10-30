//
//  DCMarkEnumerator+Internal.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCMarkEnumerator.h"
#include "DCMark.h"
#import "NSMutableArray+Stack.h"

@interface DCMarkEnumerator () {
    NSMutableArray *_stack;
}

@end

@interface DCMarkEnumerator (Internal) {
    
}

- (id)initWithMark:(id<DCMark>)mark;
- (void)traverseAndBuildStackWithMark:(id<DCMark>)mark;

@end
