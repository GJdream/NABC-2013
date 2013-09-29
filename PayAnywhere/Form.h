//
//  Form.h
//  PayAnywhere
//
//  Created by newuser on 9/24/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, MarketSource;

@interface Form : NSManagedObject

@property (nonatomic, retain) NSNumber * fid;
@property (nonatomic, retain) NSNumber * aid;
@property (nonatomic, retain) NSNumber * msid;
@property (nonatomic, retain) NSString * appFirstName;
@property (nonatomic, retain) NSString * appLastName;
@property (nonatomic, retain) NSString * appEmail;
@property (nonatomic, retain) NSNumber * appIsIndividual;
@property (nonatomic, retain) NSString * appPhoneNumber;
@property (nonatomic, retain) NSString * appSSN;
@property (nonatomic, retain) NSString * appCity;
@property (nonatomic, retain) NSString * appState;
@property (nonatomic, retain) NSString * appSuiteApt;
@property (nonatomic, retain) NSNumber * appZipCode;
@property (nonatomic, retain) NSString * appBusAddress;
@property (nonatomic, retain) NSString * appBusYears;
@property (nonatomic, retain) NSString * appBusDescription;
@property (nonatomic, retain) NSString * appBusSuiteApt;
@property (nonatomic, retain) NSString * appBusType;
@property (nonatomic, retain) NSString * appBusZipCode;
@property (nonatomic, retain) NSString * appBusName;
@property (nonatomic, retain) NSString * appDBA;
@property (nonatomic, retain) NSString * appFedTaxID;
@property (nonatomic, retain) NSString * appBusHighestSales;
@property (nonatomic, retain) NSString * appBusCCSales;
@property (nonatomic, retain) Agent *whoFilled;
@property (nonatomic, retain) MarketSource *whereFilled;

@end
