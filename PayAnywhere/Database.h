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

//Insert Functions
- (id)insertIndividualFormWithInfo:(NSDictionary *)info
                          andAgent:(Agent *)agent
                   andMarketSource:(MarketSource *)marketSource;

- (id)insertBusinessFormWithInfo:(NSDictionary *)info
                        andAgent:(Agent *)agent
                 andMarketSource:(MarketSource *)marketSource;

- (id)insertAgentWithInfo:(NSDictionary *)info;
- (id)insertMarketSourceWithInfo:(NSDictionary *)info;

//Activate/Deactive tradeshow
- (void)activateTradeshow:(MarketSource *)tradeshow withAgent:(Agent *)agent;
- (void)deactivateTradeshow;

//Active Getters
- (MarketSource *)getActiveTradeshow;
- (Agent *)getActiveAgent;

//Queries
-(NSString *)getFirstAndLastNameForAgentID:(NSNumber *)aid;
-(NSString *)getTradeshowNameForMSID:(NSNumber *)msid;
-(NSString *)getNumFormsForAgentID:(NSNumber *)aid AndMSID:(NSNumber *)msid;

- (NSArray *)allIndividualForms;
- (NSArray *)allBusinessForms;
- (NSArray *)allAgents;
- (NSArray *)allMarketSources;
- (NSMutableArray *)getUnsentFroms: (NSString *)type;
- (void) updateAllFromsToReceived: (NSString *)type;

//Delete sent forms
- (void)removeSentForms;

@end
