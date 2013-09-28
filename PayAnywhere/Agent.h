//
//  Agent.h
//  PayAnywhere
//
//  Created by newuser on 9/24/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Form;

@interface Agent : NSManagedObject

@property (nonatomic, retain) NSNumber * aid;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * pin;
@property (nonatomic, retain) NSSet *forms;
@end

@interface Agent (CoreDataGeneratedAccessors)

- (void)addFormsObject:(Form *)value;
- (void)removeFormsObject:(Form *)value;
- (void)addForms:(NSSet *)values;
- (void)removeForms:(NSSet *)values;

@end
