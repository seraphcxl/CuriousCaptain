//
//  DCCommandBarButton.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCustimizableCommand.h"

@interface DCCommandBarButton : UIBarButtonItem

@property (nonatomic, retain) IBOutlet DCCustimizableCommand *command;

@end
