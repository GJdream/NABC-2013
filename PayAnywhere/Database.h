//
//  Database.h
//  PayAnywhere
//
//  Created by newuser on 9/24/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Agent.h"
#import "MarketSource.h"
#import "Constants.h"

@interface Database : NSObject
{
    MarketSource *activeTradeshow;
    Agent *activeAgent;
}

+ (id)sharedDB;
- (id)insertIndividualFormWithInfo:(NSDictionary *)info
                            andAgent:(Agent *)agent
                     andMarketSource:(MarketSource *)marketSource;

- (id)insertBusinessFormWithInfo:(NSDictionary *)info
                        andAgent:(Agent *)agent
                 andMarketSource:(MarketSource *)marketSource;

- (id)insertAgentWithInfo:(NSDictionary *)info;
- (id)insertMarketSourceWithInfo:(NSDictionary *)info;

- (void)activateTradeshow:(MarketSource *)tradeshow withAgent:(Agent *)agent;
- (void)deactivateTradeshow;

- (MarketSource *)getActiveTradeshow;
- (Agent *)getActiveAgent;

- (NSArray *)allIndividualForms;
- (NSArray *)allBusinessForms;
- (NSArray *)allAgents;
- (NSArray *)allMarketSources;
- (NSMutableArray *)getUnsentFroms: (NSString *)type;
- (void) updateAllFromsToReceived: (NSString *)type;

@end
