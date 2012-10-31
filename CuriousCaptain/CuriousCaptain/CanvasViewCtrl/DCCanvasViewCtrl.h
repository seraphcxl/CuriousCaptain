//
//  DCCanvasViewCtrl.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCScribble.h"
#import "DCCanvasView.h"
#import "DCCanvasViewGenerator.h"
#import "DCCommandBarButton.h"
#import "NSMutableArray+Stack.h"

@interface DCCanvasViewCtrl : UIViewController

@property (nonatomic, retain) DCCanvasView *canvasView;
@property (nonatomic, retain) DCScribble *scribble;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

- (void)loadCanvasViewWithGenerator:(DCCanvasViewGenerator *)generator;

- (IBAction)onBarButtonHit:(id)button;
- (IBAction)onCustomBarButtonHit:(DCCommandBarButton *)barButton;

- (NSInvocation *)drawScribbleInvocation;
- (NSInvocation *)undrawScribbleInvocation;

- (void)executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation;
- (void)unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;

@end
