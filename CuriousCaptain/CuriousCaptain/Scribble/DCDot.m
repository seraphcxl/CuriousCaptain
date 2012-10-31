//
//  DCDot.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCDot.h"

@implementation DCDot

@synthesize color = _color;
@synthesize size = _size;

- (void)dealloc {
    self.color = nil;
    
    [super dealloc];
}

- (void)acceptMarkVisitor:(id<DCMarkVisitor>)visitor {
    [visitor visitDot:self];
}

#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone {
    DCDot *dotCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
    
    // copy the color
    dotCopy.color = [UIColor colorWithCGColor:[self.color CGColor]];
    
    // copy the size
    dotCopy.size = self.size;
    
    return dotCopy;
}

#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.color = [[coder decodeObjectForKey:@"DotColor"] retain];
        self.size = [coder decodeFloatForKey:@"DotSize"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.color forKey:@"DotColor"];
    [coder encodeFloat:self.size forKey:@"DotSize"];
}

#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGFloat frameSize = self.size;
    CGRect frame = CGRectMake(x - frameSize / 2.0, y - frameSize / 2.0, frameSize, frameSize);
    
    CGContextSetFillColorWithColor (context, [self.color CGColor]);
    CGContextFillEllipseInRect(context, frame);
}

@end
