//
//  DCThumbnailViewCtrl.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCScribbleThumbnailCell.h"
#import "DCScribbleManager.h"
#import "DCCommandBarButton.h"

@interface DCThumbnailViewCtrl : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UINavigationItem *titleItem;

@end
