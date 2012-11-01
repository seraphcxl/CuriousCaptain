//
//  DCScribbleThumbnailViewImageProxy.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCScribbleThumbnailViewImageProxy.h"

@interface DCScribbleThumbnailViewImageProxy () {
    UIImage *_realImage;
    BOOL _loadingThreadHasLaunched;
}

- (void)forwardImageLoadingThread;

@end

@implementation DCScribbleThumbnailViewImageProxy

@synthesize touchCommand = _touchCommand;
@synthesize image = _image;
@synthesize scribble = _scribble;
@dynamic imagePath;
@dynamic scribblePath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc {
    [_realImage release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (DCScribble *)scribble {
    if (_scribble == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *scribbleData = [fileManager contentsAtPath:self.scribblePath];
        DCScribbleMemento *scribbleMemento = [DCScribbleMemento mementoWithData:scribbleData];
        _scribble = [DCScribble scribbleWithMemento:scribbleMemento];
    }
    
    return _scribble;
}

// Clients can use this method directly
// to forward-load a real image
// if there is no need to show this object
// on a view.
- (UIImage *)image {
    if (_realImage== nil) {
        _realImage = [[UIImage alloc] initWithContentsOfFile:self.imagePath];
    }
    
    return _realImage;
}

// A forward call will be established
// in a sperate thread to get a real payload from
// a real image.
// Before a real pay load is returned,
// drawRect: will handle the background
// loading process and draw a placeholder frame.
// Once the real payload is loaded,
// it will redraw itself with the real one.
- (void)drawRect:(CGRect)rect {
    // if is no real image available
    // from realImageView_,
    // then just draw a blank frame
    // as a placeholder image
    if (_realImage == nil) {
        // Drawing code
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // draw a placeholder frame
        // with a 10-user-space-unit-long painted
        // segment and a 3-user-space-unit-long
        // unpainted segment of a dash line
        CGContextSetLineWidth(context, 10.0);
        const CGFloat dashLengths[2] = {10, 3};
        CGContextSetLineDash (context, 3, dashLengths, 2);
        CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
        CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
        CGContextAddRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        // launch a thread to load the real
        // payload if it hasn't done yet
        if (!_loadingThreadHasLaunched) {
            [self performSelectorInBackground:@selector(forwardImageLoadingThread) withObject:nil];
            _loadingThreadHasLaunched = YES;
        }
    } else { // otherwise pass the draw*: message along to realImage_ and let it draw the real image
        [_realImage drawInRect:rect];
    }
}

#pragma mark Touch event handlers

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.touchCommand execute];
}


#pragma mark -
#pragma mark A private method for loading a real image in a thread

- (void)forwardImageLoadingThread {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // forward the message to load
    // the real image payload
    [self image];
    
    // redraw itself with the newly loaded image
    [self performSelectorInBackground:@selector(setNeedsDisplay) withObject:nil];
    
    [pool drain];
}


@end
