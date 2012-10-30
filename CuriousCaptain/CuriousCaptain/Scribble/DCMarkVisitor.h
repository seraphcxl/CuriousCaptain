//
//  DCMarkVisitor.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DCMark;
@class DCDot, DCVertex, DCStroke;

@protocol DCMarkVisitor <NSObject>

- (void)visitMark:(id<DCMark>)mark;
- (void)visitDot:(DCDot *)dot;
- (void)visitVertex:(DCVertex *)vertex;
- (void)visitStroke:(DCStroke *)stroke;

@end
