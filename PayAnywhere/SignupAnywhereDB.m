//
//  SignupAnywhereDB.m
//  PayAnywhere
//
//  Created by Jorge Viramontes on 3/28/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "SignupAnywhereDB.h"

@implementation SignupAnywhereDB

@synthesize tradeshows = _tradeshows;
@synthesize agents = _agents;

-(id)init
{
    self = [super init];
    if (self) {
        self.tradeshows = [[NSMutableDictionary alloc] init];
        self.agents = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addNewAgent:(Agent *)agent
{
    [_agents setObject:agent forKey:agent.idnum];
    [self saveAgents];
}

-(void)addNewTradeshow:(TradeShow *)tradeshow
{
    [_tradeshows setObject:tradeshow forKey:tradeshow.name];
    [self saveTradeshows];
}

-(void)addNewApplication:(NSMutableDictionary *)application
{
    [self loadTradeshows];
    
    TradeShow * currentTradeshow = [application objectForKey:@"Tradeshow"];
    [currentTradeshow.applications addObject:application];
    
    [self saveTradeshows];
}

-(void)loadTradeshows
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSData * data = [[NSMutableData alloc] initWithData:(NSMutableData *)[ud objectForKey:@"Tradeshows"]];
    self.tradeshows = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
}

-(void)loadAgents
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSData * data = [[NSMutableData alloc] initWithData:(NSMutableData *)[ud objectForKey:@"Agents"]];
    self.agents = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
}

-(void)loadDB
{
    [self loadTradeshows];
    [self loadAgents];
}

-(void)saveTradeshows
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableData * data = (NSMutableData *)[NSKeyedArchiver archivedDataWithRootObject:self.tradeshows];
    [ud setObject:data forKey:@"Tradeshows"];
    
    if ([ud synchronize]) {
        NSLog(@"Tradeshow synchronization successful\n Tradeshows archived to database: \n%@\n", self.tradeshows);
    }
    else {
        NSLog(@"Failure synchronizing tradeshows");
    }
}

-(void)saveAgents
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSMutableData * data = (NSMutableData *)[NSKeyedArchiver archivedDataWithRootObject:self.agents];
    [ud setObject:data forKey:@"Agents"];
    
    if ([ud synchronize]) {
        NSLog(@"Agent synchronization successful\n Agents archived to database: \n%@\n", self.agents);
    }
    else {
        NSLog(@"Failure synchronizing agents");
    }
}

-(void)saveDB
{
    [self saveTradeshows];
    [self saveAgents];
}

-(void)printTradeshows
{
    for (NSString * key in [self.tradeshows allKeys]) {
        TradeShow * tradeshow = [self.tradeshows objectForKey:key];
        NSLog(@"Tradeshow: %@ in %@, %@ \n", tradeshow.name, tradeshow.city, tradeshow.state);
    }
}

-(void)printAgents
{
    for (Agent * agent in self.agents)
    {
        NSLog(@"Agent Name: %@ %@\n ID: %@\n", agent.first, agent.last, agent.idnum);
    }
}

@end
