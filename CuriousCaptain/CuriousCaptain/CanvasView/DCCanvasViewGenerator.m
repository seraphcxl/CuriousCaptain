//
//  DCCanvasViewGenerator.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCanvasViewGenerator.h"

@implementation DCCanvasViewGenerator

- (DCCanvasView *)canvasViewWithFrame:(CGRect)aFrame {
	return [[[DCCanvasView alloc] initWithFrame:aFrame] autorelease];
}

@end
