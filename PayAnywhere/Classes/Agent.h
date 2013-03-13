//
//  Agent.h
//  PayAnywhere
//
//  Created by Nathan Shields on 3/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agent : NSObject {
}
    @property(strong, nonatomic) NSString *first;
    @property(strong, nonatomic) NSString *last;
    @property(strong, nonatomic) NSString *idnum;
    @property(strong, nonatomic) NSString *pin;
    @property(nonatomic) NSInteger *numPplRegisted;
    @property(nonatomic) Boolean *logged;

@end
