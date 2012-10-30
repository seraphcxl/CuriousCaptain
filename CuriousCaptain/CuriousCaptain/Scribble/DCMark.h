//
//  DCMark.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCMarkVisitor.h"

@protocol DCMark <NSObject>

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id<DCMark> lastChild;

- (id)copy;
- (void)addMark:(id<DCMark>)mark;
- (void)removeMark:(id<DCMark>)mark;
- (id<DCMark>)childMarkAtIndex:(NSUInteger)index;

// for the Visitor pattern
- (void)acceptMarkVisitor:(id<DCMarkVisitor>)visitor;

// for the Iterator pattern
- (NSEnumerator *)enumerator;

// for internal iterator implementation
- (void)enumerateMarksUsingBlock:(void (^)(id<DCMark> item, BOOL *stop))block;

// for a bad example
- (void)drawWithContext:(CGContextRef)context;

@end
