//
//  TradeShow.m
//  PayAnywhere
//
//  Created by Nathan Shields on 3/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "TradeShow.h"

@implementation TradeShow

-(id)init
{
    if((self = [super init]))
    {
        self.agents = [[NSMutableArray alloc] init];
        self.applications = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
                
        
        
        self.name = [decoder decodeObjectForKey:@"name"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.applications = [decoder decodeObjectForKey:@"applications"];
        self.agents = [decoder decodeObjectForKey:@"agents"];
        
        if (self.applications == NULL)
        {
            self.applications = [[NSMutableArray alloc] init];
        }
        
        if (self.agents == nil)
        {
             self.agents = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)encoder
{
    //encode properties and other class variables
    
    // **** should this be self.productBarcode or _productBarcode?
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.state forKey:@"state"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.applications forKey:@"applications"];
    [encoder encodeObject:self.agents forKey:@"agents"];

}

-(void)printApplicants
{
    NSLog(@"Applications in %@: \n\n", self.name);
    
    for (NSDictionary *dict in self.applications)
    {
        for (NSString *key in [dict allKeys])
        {
            NSLog(@"%@  :  %@", key, [dict objectForKey:key] );
        }
    }
}

@end
