//
//  DCOpenScribbleCommand.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCustimizableCommand.h"

@interface DCOpenScribbleCommand : DCCustimizableCommand

@property (nonatomic, retain) id <ScribbleSource> scribbleSource;

- (id)initWithScribbleSource:(id <ScribbleSource>) aScribbleSource;
- (void)execute;

@end
