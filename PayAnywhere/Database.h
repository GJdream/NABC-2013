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

#import "TradeShow.h"


@interface Database : NSObject
{
    TradeShow *activeTradeshow;
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

- (void)activateTradeshow:(TradeShow *)tradeshow;
- (void)deactivateTradeshow;

- (TradeShow *)getActiveTradeshow;
- (Agent *)getActiveAgent;

- (NSArray *)allIndividualForms;
- (NSArray *)allBusinessForms;
- (NSArray *)allAgents;
- (NSArray *)allMarketSources;
- (NSMutableArray *)getUnsentIndividualFroms;
- (void) updateAllIndividualFromsToReceived;

@end
