//
//  Application.h
//  PayAnywhere
//
//  Created by Nathan Shields on 3/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject
    @property(strong, nonatomic) NSString *first;
    @property(strong, nonatomic) NSString *last;
    @property(strong, nonatomic) NSString *email;
    @property(strong, nonatomic) NSString *phoneNumber;
    @property(strong, nonatomic) NSString *birthday;
    @property(strong, nonatomic) NSString *Address;
    @property(strong, nonatomic) NSString *suiteOrAptNum;
    @property(strong, nonatomic) NSString *city;
    @property(strong, nonatomic) NSString *state;
    @property(strong, nonatomic) NSString *zipCode;
    @property(strong, nonatomic) NSString *fourDigitsSSN;
    @property(strong, nonatomic)NSString *DBA;
@end

@interface Individual : Application{
    
}

@end

@interface Business : Application
    @property(strong, nonatomic) NSString *businessType;
    @property(strong, nonatomic) NSString *businessDescription;
    @property(strong, nonatomic) NSString *corporationName;
    @property(strong, nonatomic) NSString *federalTaxID;
    @property(strong, nonatomic) NSString *businessAddress;
    @property(strong, nonatomic) NSString *businessSuiteOrAptNum;
    @property(strong, nonatomic) NSString *businessCity;
    @property(strong, nonatomic) NSString *businessState;
    @property(strong, nonatomic) NSString *businessZipCode;
    @property(strong, nonatomic) NSString *highestSalesAmount;
    @property(strong, nonatomic) NSString *totalMonthlyCCSales;
    @property(strong, nonatomic) NSString *beenInBusinessFor;

@end