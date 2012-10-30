//
//  DCPaperCanvasViewGenerator.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCPaperCanvasViewGenerator.h"
#import "DCPaperCanvasView.h"

@implementation DCPaperCanvasViewGenerator

- (DCCanvasView *)canvasViewWithFrame:(CGRect)aFrame {
	return [[[DCPaperCanvasView alloc] initWithFrame:aFrame] autorelease];
}

@end
