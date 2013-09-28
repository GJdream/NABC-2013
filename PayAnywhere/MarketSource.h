//
//  MarketSource.h
//  PayAnywhere
//
//  Created by newuser on 9/24/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Form;

@interface MarketSource : NSManagedObject

@property (nonatomic, retain) NSNumber * msid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *forms;
@end

@interface MarketSource (CoreDataGeneratedAccessors)

- (void)addFormsObject:(Form *)value;
- (void)removeFormsObject:(Form *)value;
- (void)addForms:(NSSet *)values;
- (void)removeForms:(NSSet *)values;

@end
