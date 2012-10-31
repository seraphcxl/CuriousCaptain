//
//  DCSetStrokeSizeCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCSetStrokeSizeCommand.h"
#import "DCCoordinatingCtrl.h"
#import "DCCanvasViewCtrl.h"

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
        
        DCCoordinatingCtrl *coordinatingCtrl = [DCCoordinatingCtrl sharedInstance];
        DCCanvasViewCtrl *canvasViewCtrl = [coordinatingCtrl canvasViewCtrl];
        
        canvasViewCtrl.strokeSize = strokeSize;
    } while (NO);
}

@end
