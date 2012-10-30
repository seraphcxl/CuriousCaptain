//
//  DCClothCanvasViewGenerator.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCClothCanvasViewGenerator.h"
#import "DCClothCanvasView.h"

@implementation DCClothCanvasViewGenerator

- (DCCanvasView *)canvasViewWithFrame:(CGRect)aFrame {
	return [[[DCClothCanvasView alloc] initWithFrame:aFrame] autorelease];
}

@end
