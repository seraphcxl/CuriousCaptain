//
//  DCDeleteScribbleCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCDeleteScribbleCommand.h"

@implementation DCDeleteScribbleCommand

- (void)execute {
    do {
        CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
        CanvasViewController *canvasViewController = [coordinatingController canvasViewController];
        
        Scribble *newScribble = [[[Scribble alloc] init] autorelease];
        [canvasViewController setScribble:newScribble];
    } while (NO);
}

@end
