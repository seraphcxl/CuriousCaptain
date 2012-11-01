//
//  DCCanvasView.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCanvasView.h"
#import "DCMarkRenderer.h"

@implementation DCCanvasView

@synthesize mark = _mark;

- (void)setMark:(id<DCMark>)mark {
    [mark retain];
    [_mark release];
    _mark = mark;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc {
    self.mark = nil;
    
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // create a renderer visitor
    DCMarkRenderer *markRenderer = [[[DCMarkRenderer alloc] initWithCGContext:context] autorelease];
    
    // pass this renderer along the mark composite structure
    if (_mark != nil) {
        [_mark acceptMarkVisitor:markRenderer];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
