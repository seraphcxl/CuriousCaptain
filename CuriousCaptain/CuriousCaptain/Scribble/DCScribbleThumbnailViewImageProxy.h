//
//  DCScribbleThumbnailViewImageProxy.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCScribbleThumbnailView.h"
#import "DCCustimizableCommand.h"

@interface DCScribbleThumbnailViewImageProxy : DCScribbleThumbnailView

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) DCScribble *scribble;
@property (nonatomic, retain) DCCustimizableCommand *touchCommand;

@end
