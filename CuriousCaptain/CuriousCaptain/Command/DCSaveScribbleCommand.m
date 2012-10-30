//
//  DCSaveScribbleCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCSaveScribbleCommand.h"
#import "DCCoordinatingCtrl.h"
#import "DCScribbleManager.h"
#import "UIView+UIImage.h"

@implementation DCSaveScribbleCommand

- (void)execute {
    do {
        DCCoordinatingCtrl *coordinatingCtrl = [DCCoordinatingCtrl sharedInstance];
        DCCanvasViewCtrl *canvasViewCtrl = [coordinatingCtrl canvasViewCtrl];
        UIImage *canvasViewImage = [[canvasViewCtrl canvasView] image];
        Scribble *scribble = [canvasViewCtrl scribble];
        
        DCScribbleManager *scribbleMgr = [[[DCScribbleManager alloc] init] autorelease];
        [scribbleMgr saveScribble:scribble thumbnail:canvasViewImage];
        
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Your scribble is saved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alertView show];
        
    } while (NO);
}

@end
