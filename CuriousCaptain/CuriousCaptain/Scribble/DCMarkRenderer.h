//
//  DCMarkRenderer.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCMarkVisitor.h"
#import "DCDot.h"
#import "DCVertex.h"
#import "DCStroke.h"

@interface DCMarkRenderer : NSObject <DCMarkVisitor> {
    
}

- (id)initWithCGContext:(CGContextRef)context;

- (void)visitMark:(id<DCMark>)mark;
- (void)visitDot:(DCDot *)dot;
- (void)visitVertex:(DCVertex *)vertex;
- (void)visitStroke:(DCStroke *)stroke;

@end
