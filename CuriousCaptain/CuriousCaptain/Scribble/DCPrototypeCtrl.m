//
//  DCPrototypeCtrl.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCPrototypeCtrl.h"
#import "DCMark.h"
#import "DCCanvasView.h"

@interface DCPrototypeCtrl ()

@end

@implementation DCPrototypeCtrl

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    do {
        id<DCMark> selectedMark = nil;
        NSMutableArray *templateArray = [[[NSMutableArray alloc] initWithCapacity:1] autorelease];
        id<DCMark> patternTemplate = [selectedMark copy];
        
        // save the patternTemplate in
        // a data structure so it can be
        // used later
        [templateArray addObject:patternTemplate];
        
        DCCanvasView *canvasView = nil;
        id<DCMark> currentMark = nil;
        int patternIndex = -1;
        
        id<DCMark> patternClone = [templateArray objectAtIndex:patternIndex];
        [currentMark addMark:patternClone];
        canvasView.mark = currentMark;
        [canvasView setNeedsDisplay];
    } while (NO);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
