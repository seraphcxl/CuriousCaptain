//
//  DCOpenScribbleCommand.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCOpenScribbleCommand.h"

@implementation DCOpenScribbleCommand

@synthesize scribbleSource =_scribbleSource;

- (void)dealloc {
    self.scribbleSource = nil;
    
    [super dealloc];
}

- (id)initWithScribbleSource:(id)aScribbleSource {
    self = [super init];
    if (self) {
        self.scribbleSource = aScribbleSource;
    }
    return self;
}

- (void)execute {
    do {
        Scribble *scribble = [self.scribbleSource scribble];
        
        CoordinatingController *coordinator = [CoordinatingController sharedInstance];
        CanvasViewController *controller = [coordinator canvasViewController];
        [controller setScribble:scribble];
        
        [coordinator requestViewChangeByObject:self];
    } while (NO);
}

@end
