//
//  DCDot.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCVertex.h"
#import "DCVertex.h"

@protocol DCMarkVisitor;

@interface DCDot : DCVertex

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;

// for the Visitor pattern
- (void)acceptMarkVisitor:(id<DCMarkVisitor>)visitor;

// for the Prototype pattern
- (id)copyWithZone:(NSZone *)zone;

// for the Memento pattern
- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

@end
