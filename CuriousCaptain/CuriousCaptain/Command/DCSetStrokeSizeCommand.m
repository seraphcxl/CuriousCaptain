//
//  DCSetStrokeSizeCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCSetStrokeSizeCommand.h"

@implementation DCSetStrokeSizeCommand

@synthesize delegate =_delegate;

- (void)dealloc {
    self.delegate = nil;
    
    [super dealloc];
}

- (void)execute {
    do {
        CGFloat strokeSize = 1;
        [self.delegate command:self didRequestForStrokeSize:&strokeSize];
        
        CoordinatingController *coordinator = [CoordinatingController sharedInstance];
        CanvasViewController *controller = [coordinator canvasViewController];
        
        [controller setStrokeSize:strokeSize];
    } while (NO);
}

@end
