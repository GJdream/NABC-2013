//
//  Application.h
//  PayAnywhere
//
//  Created by Nathan Shields on 3/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeShow.h"

@interface Application : NSObject

@property(strong, nonatomic) TradeShow * tradeshow;
@property(strong, nonatomic) NSMutableDictionary * applicationInfo;

@end
