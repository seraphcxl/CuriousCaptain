//
//  DCCustimizableCommand.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-29.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCustimizableCommand : NSObject

@property (nonatomic, retain) NSDictionary *userInfo;

- (void)execute;
- (void)undo;

@end
