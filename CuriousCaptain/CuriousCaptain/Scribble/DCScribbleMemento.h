//
//  DCScribbleMemento.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCScribbleMemento : NSObject

+ (DCScribbleMemento *)mementoWithData:(NSData *)data;
- (NSData *)data;

@end
