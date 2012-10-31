//
//  DCScribbleManager.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCScribble.h"
#import "DCScribbleThumbnailViewImageProxy.h"

@interface DCScribbleManager : NSObject

- (void)saveScribble:(DCScribble *)scribble thumbnail:(UIImage *)image;
- (NSInteger)numberOfScribbles;
- (DCScribble *)scribbleAtIndex:(NSInteger)index;
- (UIView *)scribbleThumbnailViewAtIndex:(NSInteger)index;

@end
