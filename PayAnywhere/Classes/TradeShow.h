//
//  TradeShow.h
//  PayAnywhere
//
//  Created by Nathan Shields on 3/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeShow : NSObject <NSCoding>
{
}

@property(strong, nonatomic) NSMutableArray * agents;
@property(strong, nonatomic) NSMutableArray * applications;
@property(strong, nonatomic) NSString       * name;
@property(strong, nonatomic) NSString       * city;
@property(strong, nonatomic) NSString       * state;
@property(strong, nonatomic) NSDate         * date;

-(void)printApplicants;

@end
