//
//  BusinessForm.h
//  PayAnywhere
//
//  Created by newuser on 10/1/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, MarketSource;

@interface BusinessForm : NSManagedObject

@property (nonatomic, retain) NSNumber * aid;
@property (nonatomic, retain) NSNumber * fid;
@property (nonatomic, retain) NSNumber * msid;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * suiteApt;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSString * ssn;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSString * dba;
@property (nonatomic, retain) NSString * businessAddress;
@property (nonatomic, retain) NSString * businessSuiteApt;
@property (nonatomic, retain) NSString * businessZipCode;
@property (nonatomic, retain) NSString * fedTaxID;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * yearsInBusiness;
@property (nonatomic, retain) NSString * businessDescription;
@property (nonatomic, retain) NSString * highestSales;
@property (nonatomic, retain) NSString * ccSales;
@property (nonatomic, retain) NSString * corporationName;
@property (nonatomic, retain) Agent *whoFilled;
@property (nonatomic, retain) MarketSource *whereFilled;

@end
