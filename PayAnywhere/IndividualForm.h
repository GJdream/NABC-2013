//
//  IndividualForm.h
//  PayAnywhere
//
//  Created by newuser on 12/4/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, MarketSource;

@interface IndividualForm : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * aid;
@property (nonatomic, retain) NSString * dba;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * fid;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * msid;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSNumber * receivedByServer;
@property (nonatomic, retain) NSString * ssn;
@property (nonatomic, retain) NSString * suiteApt;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) MarketSource *whereFilled;
@property (nonatomic, retain) Agent *whoFilled;

@end
