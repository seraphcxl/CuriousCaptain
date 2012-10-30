//
//  DCCoordinatingCtrl.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCCoordinatingCtrl.h"

static DCCoordinatingCtrl *sharedCoordinator = nil;

@interface DCCoordinatingCtrl ()

- (void)initialize;

@end

@implementation DCCoordinatingCtrl

@synthesize activeViewCtrl = _activeViewCtrl;
@synthesize canvasViewCtrl = _canvasViewCtrl;

- (void)initialize {
    _canvasViewCtrl = [[DCCanvasViewCtrl alloc] init];
    _activeViewCtrl = [self.canvasViewCtrl retain];
}

- (IBAction)requestViewChangeByObject:(id)object {
    if ([object isKindOfClass:[UIBarButtonItem class]]) {
        switch ([(UIBarButtonItem *)object tag]) {
            case kButtonType_OpenPaletteView:
            {
                // load a PaletteViewController
                DCPaletteViewCtrl *paletteViewCtrl = [[[DCPaletteViewCtrl alloc] init] autorelease];
                
                // transition to the PaletteViewController
                [self.canvasViewCtrl presentModalViewController:paletteViewCtrl
                                                         animated:YES];
                
                // set the activeViewController to
                // paletteViewController
                [_activeViewCtrl release];
                _activeViewCtrl = [paletteViewCtrl retain];
            }
                break;
            case kButtonType_OpenThumbnailView:
            {
                // load a ThumbnailViewController
                DCThumbnailViewCtrl *thumbnailViewCtrl = [[[DCThumbnailViewCtrl alloc] init] autorelease];
                
                
                // transition to the ThumbnailViewController
                [self.canvasViewCtrl presentModalViewController:thumbnailViewCtrl
                                                         animated:YES];
                
                // set the activeViewController to
                // ThumbnailViewController
                [_activeViewCtrl release];
                _activeViewCtrl = [thumbnailViewCtrl retain];
            }
                break;
            default:
                // just go back to the main canvasViewController
                // for the other types
            {
                // The Done command is shared on every
                // view controller except the CanvasViewController
                // When the Done button is hit, it should
                // take the user back to the first page in
                // conjunction with the design
                // other objects will follow the same path
                [self.canvasViewCtrl dismissModalViewControllerAnimated:YES];
                
                // set the activeViewController back to
                // canvasViewController
                [_activeViewCtrl release];
                _activeViewCtrl = [self.canvasViewCtrl retain];
            }
                break;
        }
    } else { // every thing else goes to the main canvasViewController
        [self.canvasViewCtrl dismissModalViewControllerAnimated:YES];
        
        // set the activeViewController back to 
        // canvasViewController
        [_activeViewCtrl release];
        _activeViewCtrl = [self.canvasViewCtrl retain];
    }
    
}

#pragma mark -
#pragma mark Singleton Implementation

+ (DCCoordinatingCtrl *)sharedInstance {
    if (sharedCoordinator == nil) {
        sharedCoordinator = [[super allocWithZone:NULL] init];
        [sharedCoordinator initialize];
    }
    return sharedCoordinator;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

- (oneway void)release {
    // do nothing
}

- (id)autorelease {
    return self;
}

@end
