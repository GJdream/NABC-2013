//
//  Agent.m
//  PayAnywhere
//
//  Created by Nathan Shields on 3/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "Agent.h"

@implementation Agent

-(id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init])) {
        self.first = [decoder decodeObjectForKey:@"first"];
        self.last = [decoder decodeObjectForKey:@"last"];
        self.idnum = [decoder decodeObjectForKey:@"idnum"];
        self.pin = [decoder decodeObjectForKey:@"pin"];
        self.peopleRegistered = [decoder decodeObjectForKey:@"peopleRegistered"];
        self.loggedIn = [decoder decodeObjectForKey:@"loggedIn"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.first forKey:@"first"];
    [encoder encodeObject:self.last forKey:@"last"];
    [encoder encodeObject:self.idnum forKey:@"idnum"];
    [encoder encodeObject:self.pin forKey:@"pin"];
    [encoder encodeObject:self.peopleRegistered forKey:@"peopleRegistered"];
    [encoder encodeObject:self.loggedIn forKey:@"loggedIn"];
}


@end
