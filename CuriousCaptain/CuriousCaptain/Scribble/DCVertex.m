//
//  DCVertex.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCVertex.h"

@implementation DCVertex

@synthesize location = _location;
@dynamic color;
@dynamic size;

- (id)initWithLocation:(CGPoint)aLocation {
    if (self = [super init]) {
        [self setLocation:aLocation];
    }
    
    return self;
}

- (void)setColor:(UIColor *)color {
}

- (UIColor *)color {
    return nil;
}

- (void)setSize:(CGFloat)size {
}

- (CGFloat)size {
    return 0.0;
}

- (void)addMark:(id<DCMark>)mark {
}

- (void)removeMark:(id<DCMark>)mark {
}

- (id<DCMark>)childMarkAtIndex:(NSUInteger)index {
    return nil;
}

- (id<DCMark>)lastChild {
    return nil;
}

- (NSUInteger)count {
    return 0;
}

- (NSEnumerator *)enumerator {
    return nil;
}

- (void)acceptMarkVisitor:(id<DCMarkVisitor>)visitor {
    [visitor visitVertex:self];
}

#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone {
    DCVertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
    
    return vertexCopy;
}


#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.location = [(NSValue *)[coder decodeObjectForKey:@"VertexLocation"] CGPointValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSValue valueWithCGPoint:self.location] forKey:@"VertexLocation"];
}

#pragma mark MarkIterator methods

// for internal iterator implementation
- (void)enumerateMarksUsingBlock:(void (^)(id<DCMark> item, BOOL *stop))block {
}

#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void)drawWithContext:(CGContextRef)context
{
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    
    CGContextAddLineToPoint(context, x, y);
}
@end
