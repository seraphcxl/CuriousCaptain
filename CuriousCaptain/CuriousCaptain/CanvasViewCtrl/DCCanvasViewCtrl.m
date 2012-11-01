//
//  DCCanvasViewCtrl.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCanvasViewCtrl.h"
#import "DCDot.h"
#import "DCStroke.h"

@interface DCCanvasViewCtrl () {
    CGPoint _startPoint;
}

@end

@implementation DCCanvasViewCtrl

@synthesize canvasView = _canvasView;
@synthesize scribble = _scribble;
@synthesize strokeColor = _strokeColor;
@synthesize strokeSize = _strokeSize;

- (void)dealloc {
    self.canvasView = nil;
    self.scribble = nil;
    [super dealloc];
}

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
    // Do any additional setup after loading the view from its nib.
    do {
        // Get a default canvas view
        // with the factory method of
        // the CanvasViewGenerator
        DCCanvasViewGenerator *defaultGenerator = [[[DCCanvasViewGenerator alloc] init] autorelease];
        [self loadCanvasViewWithGenerator:defaultGenerator];
        
        // initialize a Scribble model
        DCScribble *scribble = [[[DCScribble alloc] init] autorelease];
        [self setScribble:scribble];
        
        // setup default stroke color and size
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        CGFloat redValue = [userDefaults floatForKey:@"red"];
        CGFloat greenValue = [userDefaults floatForKey:@"green"];
        CGFloat blueValue = [userDefaults floatForKey:@"blue"];
        CGFloat sizeValue = [userDefaults floatForKey:@"size"];
        
        self.strokeSize = sizeValue;
        self.strokeColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
    } while (NO);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hook up everything with a new Scribble instance
- (void)setScribble:(DCScribble *)aScribble {
    if (_scribble != aScribble) {
        [_scribble autorelease];
        _scribble = [aScribble retain];
        
        // add itself to the scribble as
        // an observer for any changes to
        // its internal state - mark
        [_scribble addObserver:self forKeyPath:@"mark" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    }
}

#pragma mark Stroke color and size accessor methods

- (void)setStrokeSize:(CGFloat)aSize {
    // enforce the smallest size
    // allowed
    if (aSize < 5.0) {
        _strokeSize = 5.0;
    } else {
        _strokeSize = aSize;
    }
}

#pragma mark Toolbar button hit method

- (IBAction)onBarButtonHit:(id)button {
    UIBarButtonItem *barButton = button;
    
    if ([barButton tag] == 4) {
        [self.undoManager undo];
    } else if ([barButton tag] == 5) {
        [self.undoManager redo];
    }
}

- (IBAction)onCustomBarButtonHit:(DCCommandBarButton *)barButton {
    [[barButton command] execute];
}

#pragma mark Loading a CanvasView from a CanvasViewGenerator

- (void)loadCanvasViewWithGenerator:(DCCanvasViewGenerator *)generator
{
    [self.canvasView removeFromSuperview];
    CGRect aFrame = CGRectMake(0, 0, 320, 460);
    DCCanvasView *aCanvasView = [generator canvasViewWithFrame:aFrame];
    self.canvasView = aCanvasView;
    NSInteger viewIndex = [[[self view] subviews] count] - 1;
    [[self view] insertSubview:self.canvasView atIndex:viewIndex];
}

#pragma mark Touch Event Handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _startPoint = [[touches anyObject] locationInView:self.canvasView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.canvasView];
    
    // add a new stroke to scribble
    // if this is indeed a drag from
    // a finger
    if (CGPointEqualToPoint(lastPoint, _startPoint)) {
        id<DCMark> newStroke = [[[DCStroke alloc] init] autorelease];
        [newStroke setColor:self.strokeColor];
        [newStroke setSize:self.strokeSize];
        
        //[scribble_ addMark:newStroke shouldAddToPreviousMark:NO];
        
        // retrieve a new NSInvocation for drawing and
        // set new arguments for the draw command
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&newStroke atIndex:2];
        
        // retrieve a new NSInvocation for undrawing and
        // set a new argument for the undraw command
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&newStroke atIndex:2];
        
        // execute the draw command with the undraw command
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    
    // add the current touch as another vertex to the
    // temp stroke
    CGPoint thisPoint = [[touches anyObject] locationInView:self.canvasView];
    DCVertex *vertex = [[[DCVertex alloc] initWithLocation:thisPoint] autorelease];
    
    // we don't need to undo every vertex
    // so we are keeping this
    [self.scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.canvasView];
    CGPoint thisPoint = [[touches anyObject] locationInView:self.canvasView];
    
    // if the touch never moves (stays at the same spot until lifted now)
    // just add a dot to an existing stroke composite
    // otherwise add it to the temp stroke as the last vertex
    if (CGPointEqualToPoint(lastPoint, thisPoint)) {
        DCDot *singleDot = [[[DCDot alloc] initWithLocation:thisPoint] autorelease];
        [singleDot setColor:self.strokeColor];
        [singleDot setSize:self.strokeSize];
        
        //[scribble_ addMark:singleDot shouldAddToPreviousMark:NO];
        
        // retrieve a new NSInvocation for drawing and
        // set new arguments for the draw command
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&singleDot atIndex:2];
        
        // retrieve a new NSInvocation for undrawing and
        // set a new argument for the undraw command
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&singleDot atIndex:2];
        
        // execute the draw command with the undraw command
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    
    // reset the start point here
    _startPoint = CGPointZero;
    
    // if this is the last point of stroke
    // don't bother to draw it as the user
    // won't tell the difference
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // reset the start point here
    _startPoint = CGPointZero;
}

#pragma mark Scribble observer method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isKindOfClass:[DCScribble class]] && [keyPath isEqualToString:@"mark"]) {
        id<DCMark> mark = [change objectForKey:NSKeyValueChangeNewKey];
        [self.canvasView setMark:mark];
        [self.canvasView setNeedsDisplay];
    }
}

#pragma mark Draw Scribble Invocation Generation Methods

- (NSInvocation *)drawScribbleInvocation {
    NSMethodSignature *executeMethodSignature = [self.scribble methodSignatureForSelector:@selector(addMark:shouldAddToPreviousMark:)];
    NSInvocation *drawInvocation = [NSInvocation invocationWithMethodSignature:executeMethodSignature];
    [drawInvocation setTarget:self.scribble];
    [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
    
    return drawInvocation;
}

- (NSInvocation *)undrawScribbleInvocation {
    NSMethodSignature *unexecuteMethodSignature = [self.scribble methodSignatureForSelector:@selector(removeMark:)];
    NSInvocation *undrawInvocation = [NSInvocation invocationWithMethodSignature:unexecuteMethodSignature];
    [undrawInvocation setTarget:self.scribble];
    [undrawInvocation setSelector:@selector(removeMark:)];
    
    return undrawInvocation;
}

#pragma mark Draw Scribble Command Methods

- (void) executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation {
    [invocation retainArguments];
    
    [[self.undoManager prepareWithInvocationTarget:self] unexecuteInvocation:undoInvocation withRedoInvocation:invocation];
    
    [invocation invoke];
}

- (void) unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation
{
    [[self.undoManager prepareWithInvocationTarget:self] executeInvocation:redoInvocation withUndoInvocation:invocation];
    
    [invocation invoke];
}

@end
