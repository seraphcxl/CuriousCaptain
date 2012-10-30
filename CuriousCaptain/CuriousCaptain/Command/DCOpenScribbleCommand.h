//
//  DCOpenScribbleCommand.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCustimizableCommand.h"
#import "DCScribbleSrc.h"

@interface DCOpenScribbleCommand : DCCustimizableCommand

@property (nonatomic, retain) id<DCScribbleSrc> scribbleSrc;

- (id)initWithScribbleSource:(id<DCScribbleSrc>)aScribbleSource;
- (void)execute;

@end
