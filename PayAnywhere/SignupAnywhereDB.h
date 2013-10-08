//
//  SignupAnywhereDB.h
//  PayAnywhere
//
//  Created by Jorge Viramontes on 3/28/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Agent.h"
#import "Application.h"

@interface SignupAnywhereDB : NSObject
{
}

@property(strong, nonatomic) NSMutableDictionary * tradeshows;
@property(strong, nonatomic) NSMutableDictionary * agents;

-(void)addNewAgent: (Agent *)agent;
-(void)addNewTradeshow: (TradeShow *)tradeshow;
-(void)addNewApplication: (NSMutableDictionary *)application;

-(void)loadDB;
-(void)saveDB;

-(void)loadTradeshows;
-(void)loadAgents;
-(void)saveTradeshows;
-(void)saveAgents;

-(void)printTradeshows;
-(void)printAgents;

@end
