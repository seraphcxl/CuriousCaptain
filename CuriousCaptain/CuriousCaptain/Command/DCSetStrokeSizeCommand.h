//
//  DCSetStrokeSizeCommand.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCustimizableCommand.h"

@class DCSetStrokeSizeCommand;

@protocol DCSetStrokeSizeCommandDelegate

- (void)command:(DCSetStrokeSizeCommand *)command didRequestForStrokeSize:(CGFloat *)size;

@end

@interface DCSetStrokeSizeCommand : DCCustimizableCommand

@property (nonatomic, assign) id<DCSetStrokeSizeCommandDelegate> delegate;

- (void)execute;

@end
