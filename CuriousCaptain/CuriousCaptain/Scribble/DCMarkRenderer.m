//
//  DCMarkRenderer.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCMarkRenderer.h"

@interface DCMarkRenderer () {
    BOOL _shouldMoveContextToDot;
    CGContextRef _context;
}

@end

@implementation DCMarkRenderer

- (id) initWithCGContext:(CGContextRef)context {
    if (self = [super init])
    {
        _context = context;
        _shouldMoveContextToDot = YES;
    }
    
    return self;
}

- (void)visitMark:(id<DCMark>)mark {
    // default behavior
}

- (void)visitDot:(DCDot *)dot {
    CGFloat x = [dot location].x;
    CGFloat y = [dot location].y;
    CGFloat frameSize = [dot size];
    CGRect frame = CGRectMake(x - frameSize / 2.0, y - frameSize / 2.0 frameSize, frameSize);
    
    CGContextSetFillColorWithColor (_context, [[dot color] CGColor]);
    CGContextFillEllipseInRect(_context, frame);
}

- (void)visitVertex:(DCVertex *)vertex
{
    CGFloat x = [vertex location].x;
    CGFloat y = [vertex location].y;
    
    if (_shouldMoveContextToDot) {
        CGContextMoveToPoint(_context, x, y);
        _shouldMoveContextToDot = NO;
    } else {
        CGContextAddLineToPoint(_context, x, y);
    }
}

- (void)visitStroke:(DCStroke *)stroke {
    CGContextSetStrokeColorWithColor (_context, [[stroke color] CGColor]);
    CGContextSetLineWidth(_context, [stroke size]);
    CGContextSetLineCap(_context, kCGLineCapRound);
    CGContextStrokePath(_context);
    _shouldMoveContextToDot = YES;
}

@end
