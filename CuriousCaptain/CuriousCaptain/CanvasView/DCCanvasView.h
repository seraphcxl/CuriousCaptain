//
//  DCCanvasView.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCMark;

@interface DCCanvasView : UIView

@property (nonatomic, retain) id<DCMark> mark;

@end
