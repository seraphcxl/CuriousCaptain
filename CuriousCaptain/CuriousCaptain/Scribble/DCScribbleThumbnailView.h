//
//  DCScribbleThumbnailView.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCScribble.h"
#import "DCScribbleSrc.h"

@interface DCScribbleThumbnailView : UIView <DCScribbleSrc>

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) DCScribble *scribble;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *scribblePath;

@end
