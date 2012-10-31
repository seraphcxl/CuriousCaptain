//
//  DCScribbleThumbnailCell.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCScribbleThumbnailView.h"

@interface DCScribbleThumbnailCell : UITableViewCell

+ (NSInteger)numberOfPlaceHolders;
- (void)addThumbnailView:(UIView *)thumbnailView atIndex:(NSInteger)index;

@end
