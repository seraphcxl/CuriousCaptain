//
//  DCSetStrokeColorCommand.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCustimizableCommand.h"

typedef void (^RGBValuesProvider)(CGFloat *red, CGFloat *green, CGFloat *blue);
typedef void (^PostColorUpdateProvider)(UIColor *color);

@class DCSetStrokeColorCommand;

@protocol DCSetStrokeColorCommandDelegate

- (void)command:(DCSetStrokeColorCommand *) command didRequestColorComponentsForRed:(CGFloat *) red green:(CGFloat *) green blue:(CGFloat *) blue;

- (void)command:(DCSetStrokeColorCommand *) command didFinishColorUpdateWithColor:(UIColor *) color;

@end

@interface DCSetStrokeColorCommand : DCCustimizableCommand

@property (nonatomic, assign) id<DCSetStrokeColorCommandDelegate> delegate;
@property (nonatomic, copy) RGBValuesProvider RGBValuesProvider;
@property (nonatomic, copy) PostColorUpdateProvider postColorUpdateProvider;

- (void)execute;

@end
