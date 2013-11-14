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


@interface Database : NSObject

+ (id)sharedDB;
- (id)insertIndividualFormWithInfo:(NSDictionary *)info
                            andAgent:(Agent *)agent
                     andMarketSource:(MarketSource *)marketSource;

//- (id)insertBusinessFormWithInfo:(NSDictionary *)info;
- (id)insertAgentWithInfo:(NSDictionary *)info;
- (id)insertMarketSourceWithInfo:(NSDictionary *)info;

- (NSArray *)allIndividualForms;
- (NSArray *)allBusinessForms;
- (NSArray *)allAgents;
- (NSArray *)allMarketSources;

@end
