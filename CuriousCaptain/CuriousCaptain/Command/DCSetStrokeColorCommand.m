//
//  DCSetStrokeColorCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCSetStrokeColorCommand.h"
#import "DCCoordinatingCtrl.h"
#import "DCCanvasViewCtrl.h"

@implementation DCSetStrokeColorCommand

@synthesize delegate = _delegate;
@synthesize RGBValuesProvider = _RGBValuesProvider;
@synthesize postColorUpdateProvider = _postColorUpdateProvider;

- (void)dealloc {
    self.postColorUpdateProvider = nil;
    self.RGBValuesProvider = nil;
    self.delegate = nil;
    
    [super dealloc];
}

- (void)execute {
    do {
        CGFloat redValue = 0.0;
        CGFloat greenValue = 0.0;
        CGFloat blueValue = 0.0;
        
        [self.delegate command:self didRequestColorComponentsForRed:&redValue green:&greenValue blue:&blueValue];
        
        if (self.RGBValuesProvider != nil) {
            self.RGBValuesProvider(&redValue, &greenValue, &blueValue);
        }
        
        UIColor *color = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
        
        DCCoordinatingCtrl *coordinatingCtrl = [DCCoordinatingCtrl sharedInstance];
        DCCanvasViewCtrl *canvasViewCtrl = [coordinatingCtrl canvasViewController];
        canvasViewCtrl.strokeColor = color;
        
        [self.delegate command:self didFinishColorUpdateWithColor:color];
        
        if (self.postColorUpdateProvider != nil) {
            self.postColorUpdateProvider(color);
        }

    } while (NO);
}

@end
