//
//  DCSaveScribbleCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCSaveScribbleCommand.h"

@implementation DCSaveScribbleCommand

- (void)execute {
    do {
        CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
        CanvasViewController *canvasViewController = [coordinatingController canvasViewController];
        UIImage *canvasViewImage = [[canvasViewController canvasView] image];
        Scribble *scribble = [canvasViewController scribble];
        
        ScribbleManager *scribbleManager = [[[ScribbleManager alloc] init] autorelease];
        [scribbleManager saveScribble:scribble thumbnail:canvasViewImage];
        
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Your scribble is saved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alertView show];
        
    } while (NO);
}

@end
