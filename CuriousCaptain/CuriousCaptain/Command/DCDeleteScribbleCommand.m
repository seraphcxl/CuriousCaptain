//
//  DCDeleteScribbleCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCDeleteScribbleCommand.h"
#import "DCCoordinatingCtrl.h"
#import "DCCanvasViewCtrl.h"

@implementation DCDeleteScribbleCommand

- (void)execute {
    do {
        DCCoordinatingCtrl *coordinatingCtrl = [DCCoordinatingCtrl sharedInstance];
        DCCanvasViewCtrl *canvasViewCtrl = [coordinatingCtrl canvasViewCtrl];
        
        DCScribble *newScribble = [[[DCScribble alloc] init] autorelease];
        canvasViewCtrl.scribble = newScribble;
    } while (NO);
}

@end
