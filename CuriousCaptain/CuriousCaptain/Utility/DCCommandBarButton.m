//
//  DCCommandBarButton.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCommandBarButton.h"

@implementation DCCommandBarButton

@synthesize command = _command;

- (void)dealloc {
    self.command = nil;
    
    [super dealloc];
}

@end
