//
//  DCStroke.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCStroke.h"
#import "DCMarkEnumerator+Internal.h"

@interface DCStroke () {
    NSMutableArray *_children;
}

@end

@implementation DCStroke

@synthesize color = _color;
@synthesize size = _size;
@dynamic location;

- (id)init {
    if (self = [super init]) {
        _children = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return self;
}

- (void)dealloc {
    self.color = nil;
    [_children release];
    
    [super dealloc];
}

- (void)setLocation:(CGPoint)aPoint {
    // it doesn't set any arbitrary location
}

- (CGPoint)location {
    // return the location of the first child
    if ([_children count] > 0) {
        return [[_children objectAtIndex:0] location];
    }
    
    // otherwise returns the origin
    return CGPointZero;
}

- (void)addMark:(id<DCMark>)mark {
    [_children addObject:mark];
}

- (void)removeMark:(id<DCMark>)mark {
    // if mark is at this level then
    // remove it and return
    // otherwise, let every child
    // search for it
    if ([_children containsObject:mark]) {
        [_children removeObject:mark];
    } else {
        [_children makeObjectsPerformSelector:@selector(removeMark:) withObject:mark];
    }
}


- (id<DCMark>)childMarkAtIndex:(NSUInteger)index {
    if (index >= [_children count]) {
        return nil;
    }
    
    return [_children objectAtIndex:index];
}


// a convenience method to return the last child
- (id<DCMark>)lastChild {
    return [_children lastObject];
}

// returns number of children
- (NSUInteger)count {
    return [_children count];
}


- (void)acceptMarkVisitor:(id<DCMarkVisitor>)visitor {
    for (id<DCMark> dot in _children) {
        [dot acceptMarkVisitor:visitor];
    }
    
    [visitor visitStroke:self];
}

#pragma mark NSCopying method

- (id)copyWithZone:(NSZone *)zone {
    DCStroke *strokeCopy = [[[self class] allocWithZone:zone] init];
    
    // copy the color
    strokeCopy.color = [UIColor colorWithCGColor:[self.color CGColor]];
    
    // copy the size
    strokeCopy.size = self.size;
    
    // copy the children
    for (id<DCMark> child in _children) {
        id<DCMark> childCopy = [child copy];
        [strokeCopy addMark:child];
        [childCopy release];
    }
    
    return strokeCopy;
}

#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init])
    {
        self.color = [[coder decodeObjectForKey:@"StrokeColor"] retain];
        self.size = [coder decodeFloatForKey:@"StrokeSize"];
        _children = [[coder decodeObjectForKey:@"StrokeChildren"] retain];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.color forKey:@"StrokeColor"];
    [coder encodeFloat:self.size forKey:@"StrokeSize"];
    [coder encodeObject:_children forKey:@"StrokeChildren"];
}

#pragma mark enumerator methods

- (NSEnumerator *)enumerator {
    return [[[DCMarkEnumerator alloc] initWithMark:self] autorelease];
}

- (void)enumerateMarksUsingBlock:(void (^)(id<DCMark> item, BOOL *stop))block
{
    BOOL stop = NO;
    
    NSEnumerator *enumerator = [self enumerator];
    
    for (id<DCMark> mark in enumerator) {
        block (mark, &stop);
        if (stop) {
            break;
        }
    }
}

#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, self.location.x, self.location.y);
    
    for (id<DCMark> mark in _children) {
        [mark drawWithContext:context];
    }
    
    CGContextSetLineWidth(context, self.size);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context,[self.color CGColor]);
    CGContextStrokePath(context);
}

@end
