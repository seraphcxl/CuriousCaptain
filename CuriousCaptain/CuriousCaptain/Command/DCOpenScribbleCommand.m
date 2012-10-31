//
//  DCOpenScribbleCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCOpenScribbleCommand.h"
#import "DCCoordinatingCtrl.h"
#import "DCCanvasViewCtrl.h"

@implementation DCOpenScribbleCommand

@synthesize scribbleSrc =_scribbleSrc;

- (void)dealloc {
    self.scribbleSrc = nil;
    
    [super dealloc];
}

- (id)initWithScribbleSource:(id)aScribbleSource {
    self = [super init];
    if (self) {
        self.scribbleSrc = aScribbleSource;
    }
    return self;
}

- (void)execute {
    do {
        DCScribble *scribble = [self.scribbleSrc scribble];
        
        DCCoordinatingCtrl *coordinatorCtrl = [DCCoordinatingCtrl sharedInstance];
        DCCanvasViewCtrl *canvasViewCtrl = [coordinatorCtrl canvasViewCtrl];
        canvasViewCtrl.scribble = scribble;
        
        [coordinatorCtrl requestViewChangeByObject:self];
    } while (NO);
}

@end
