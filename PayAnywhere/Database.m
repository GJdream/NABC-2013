//
//  Database.m
//  PayAnywhere
//
//  Created by newuser on 9/24/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "Database.h"
#import "Agent.h"
#import "IndividualForm.h"
#import "BusinessForm.h"
#import "Form+ApplicationDictionary.h"
#import "MarketSource.h"

@implementation Database

static Database *sharedDB = nil;

//UIManagedDocument *document;
//NSURL *documentURL;

NSManagedObjectContext *context;
NSManagedObjectModel *model;
NSPersistentStoreCoordinator *coordinator;

- (id)init
{
    self = [super init];
    if (self){
        context = [self managedObjectContext];
    }
    return self;
}

+ (id)sharedDB
{
    if (sharedDB == nil) {
        sharedDB = [[Database alloc] init];
    }
 
    return sharedDB;
}

-(void)activateTradeshow:(TradeShow *)tradeshow
{
    activeTradeshow = tradeshow;
}

-(void)deactivateTradeshow
{
    activeTradeshow = nil;
}

-(TradeShow *)getActiveTradeshow
{
    if (activeTradeshow) {
        return activeTradeshow;
    }
    else {
        return nil;
    }
}

-(Agent *)getActiveAgent
{
    if (activeAgent) {
        return activeAgent;
    }
    else {
        return nil;
    }
}

- (id)insertIndividualFormWithInfo:(NSDictionary *)info
                            andAgent:(Agent *)agent
                     andMarketSource:(MarketSource *)marketSource
{
    
    IndividualForm *form = [NSEntityDescription insertNewObjectForEntityForName:@"IndividualForm" inManagedObjectContext:context];
    
    form.dba = [info objectForKey:@"dba"];
    form.email = [info objectForKey:@"email"];
    form.firstName = [info objectForKey:@"firstName"];
    form.lastName = [info objectForKey:@"lastName"];
    form.phoneNumber = [info objectForKey:@"phoneNumber"];
    form.ssn = [info objectForKey:@"ssn"];
    form.suiteApt = [info objectForKey:@"suiteApt"];
    form.zipCode = [info objectForKey:@"zipCode"];
    form.fid = [info objectForKey:@"fid"];
    form.dob = [info objectForKey:@"dob"];
    form.address = [info objectForKey:@"address"];
    
    //Get object pointers given ids from info dictionary
    form.aid = agent.aid;
    form.msid = marketSource.msid;
    form.whereFilled = marketSource;
    form.whoFilled = agent;
    
    NSError *error;
    if (![context save:&error])
        NSLog(@"Error saving: %@", [error localizedDescription]);
    else
        NSLog(@"Success Saving");
    
    return form;
}

- (id)insertBusinessFormWithInfo:(NSDictionary *)info
                        andAgent:(Agent *)agent
                 andMarketSource:(MarketSource *)marketSource
{
    BusinessForm *form = [NSEntityDescription
                          insertNewObjectForEntityForName:@"BusinessForm"
                          inManagedObjectContext:context];
    
    form.firstName = [info objectForKey:@"firstName"];
    form.lastName = [info objectForKey:@"lastName"];
    form.email = [info objectForKey:@"email"];
    form.phoneNumber = [info objectForKey:@"phoneNumber"];
    form.address = [info objectForKey:@"address"];
    form.suiteApt = [info objectForKey:@"suiteApt"];
    form.zipCode = [info objectForKey:@"zipCode"];
    form.ssn = [info objectForKey:@"ssn"];
    form.dob = [info objectForKey:@"dob"];
    form.dba = [info objectForKey:@"dba"];
    form.businessAddress = [info objectForKey:@"businessAddress"];
    form.businessSuiteApt = [info objectForKey:@"businessSuiteApt"];
    form.businessZipCode = [info objectForKey:@"businessZipCode"];
    form.fedTaxID = [info objectForKey:@"fedTaxID"];
    form.type = [info objectForKey:@"type"];
    form.yearsInBusiness = [info objectForKey:@"yearsInBusiness"];
    form.businessDescription = [info objectForKey:@"businessDescription"];
    form.highestSales = [info objectForKey:@"highestSales"];
    form.ccSales = [info objectForKey:@"ccSales"];
    form.corporationName = [info objectForKey:@"corporationName"];
    
    //Get object pointers given ids from info dictionary
    form.aid = agent.aid;
    form.msid = marketSource.msid;
    form.whereFilled = marketSource;
    form.whoFilled = agent;
    
    NSError *error;
    if (![context save:&error])
        NSLog(@"Error saving: %@", [error localizedDescription]);
    else
        NSLog(@"Success Saving");
    
    return form;
}

- (id)insertAgentWithInfo:(NSDictionary *)info
{
    Agent *agent = [NSEntityDescription insertNewObjectForEntityForName:@"Agent" inManagedObjectContext:context];
    agent.aid = [info objectForKey:@"aid"];
    agent.firstName = [info objectForKey:@"firstName"];
    agent.lastName = [info objectForKey:@"lastName"];
    agent.pin = [info objectForKey:@"pin"];

    NSError *error;
    if (![context save:&error])
        NSLog(@"Error saving: %@", [error localizedDescription]);
    else
        NSLog(@"Success Saving");
    
    return agent;
}

- (id)insertMarketSourceWithInfo:(NSDictionary *)info
{
    MarketSource *ms = [NSEntityDescription insertNewObjectForEntityForName:@"MarketSource" inManagedObjectContext:context];
    ms.msid = [info objectForKey:@"msid"];
    ms.city = [info objectForKey:@"city"];
    ms.state = [info objectForKey:@"state"];
    ms.name = [info objectForKey:@"name"];
    ms.date = [info objectForKey:@"date"];
    
    NSError *error;
    if (![context save:&error])
        NSLog(@"Error saving: %@", [error localizedDescription]);
    else
        NSLog(@"Success Saving");
    
    return ms;
}

- (NSArray *)allIndividualForms
{
    NSArray *individualForms = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"IndividualForm" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSError *error;
   
    individualForms = [context executeFetchRequest:fetchRequest error:&error];
    return individualForms;
}

- (NSArray *)allBusinessForms
{
    NSArray *businessForms = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"BusinessForm" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSError *error;
    
    businessForms = [context executeFetchRequest:fetchRequest error:&error];
    return businessForms;
}

- (NSArray *)allAgents
{
    NSArray *agentsArray = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Agent" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSError *error;
    
    agentsArray = [context executeFetchRequest:fetchRequest error:&error];
    return agentsArray;
}

- (NSArray *)allMarketSources
{
    NSArray *marketSourcesArray = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MarketSource" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSError *error;
    
    marketSourcesArray = [context executeFetchRequest:fetchRequest error:&error];
    return marketSourcesArray;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. Should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSMutableArray *)getUnsentIndividualFroms
{
    NSArray *individualForms = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"IndividualForm" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    individualForms = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *forms = [[NSMutableArray alloc] init];
    
    for (NSManagedObject *info in individualForms) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[info valueForKey:@"aid"]!=nil?[info valueForKey:@"aid"]:@"" forKey:@"aid"];
        [dict setObject:[info valueForKey:@"dba"]!=nil?[info valueForKey:@"dba"]:@"" forKey:@"dba"];
        [dict setObject:[info valueForKey:@"email"]!=nil?[info valueForKey:@"email"]:@"" forKey:@"email"];
        [dict setObject:[info valueForKey:@"firstName"]!=nil?[info valueForKey:@"firstName"]:@"" forKey:@"firstName"];
        [dict setObject:[info valueForKey:@"lastName"]!=nil?[info valueForKey:@"lastName"]:@"" forKey:@"lastName"];
        [dict setObject:[info valueForKey:@"phoneNumber"]!=nil?[info valueForKey:@"phoneNumber"]:@"" forKey:@"phoneNumber"];
        [dict setObject:[info valueForKey:@"ssn"]!=nil?[info valueForKey:@"ssn"]:@"" forKey:@"ssn"];
        [dict setObject:[info valueForKey:@"suiteApt"]!=nil?[info valueForKey:@"suiteApt"]:@"" forKey:@"suiteApt"];
        [dict setObject:[info valueForKey:@"zipCode"]!=nil?[info valueForKey:@"zipCode"]:@"" forKey:@"zipCode"];
        [dict setObject:[info valueForKey:@"fid"]!=nil?[info valueForKey:@"fid"]:@"" forKey:@"fid"];
        [dict setObject:[info valueForKey:@"msid"]!=nil?[info valueForKey:@"msid"]:@"" forKey:@"msid"];
        [dict setObject:[info valueForKey:@"dob"]!=nil?[info valueForKey:@"dob"]:@"" forKey:@"dob"];
        
        [forms addObject:dict];
    }

    return forms;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (context != nil) {
        return context;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:coordinator];
    }
    return context;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (model != nil) {
        return model;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PayAnywhereModel" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return model;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (coordinator != nil) {
        return coordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PayAnywhereModel.sqlite"];
    
    NSError *error = nil;
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return coordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
