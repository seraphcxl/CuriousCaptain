//
//  DCCoordinatingCtrl.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCanvasViewCtrl.h"
#import "DCThumbnailViewCtrl.h"
#import "DCPaletteViewCtrl.h"

typedef enum
{
    kButtonType_Done,
    kButtonType_OpenPaletteView,
    kButtonType_OpenThumbnailView,
} ButtonType;

@interface DCCoordinatingCtrl : NSObject

@property (nonatomic, readonly) UIViewController *activeViewCtrl;
@property (nonatomic, readonly) DCCanvasViewCtrl *canvasViewCtrl;

+ (DCCoordinatingCtrl *)sharedInstance;

- (IBAction)requestViewChangeByObject:(id)object;

@end
