//
//  DCCustimizableCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCustimizableCommand.h"

@implementation DCCustimizableCommand

@synthesize userInfo = _userInfo;

- (void)dealloc {
    self.userInfo = nil;
    
    [super dealloc];
}

- (void)execute {
}

- (void)undo {
}

@end
