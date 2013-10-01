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
    if (self) {
        NSLog(@"Initialized successfully");
        /*
        document = [[UIManagedDocument alloc] initWithFileURL:documentURL];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:[documentURL path]])
        {
            [document openWithCompletionHandler:^(BOOL success) {
               if(success)
               {
                   NSLog(@"Opened document successfully");
                   [self documentIsReady];
               }
            }];
        }
        else
        {
            [document saveToURL:documentURL
               forSaveOperation:UIDocumentSaveForCreating
              completionHandler:^(BOOL success) {
                  if(success)
                  {
                      NSLog(@"Saved document");
                      [self documentIsReady];
                  }
              }];
        }
         */
        context = [self managedObjectContext];
        
        
    }
    return self;
}

+ (void)sharedDB
{
    if (sharedDB == nil) {
        sharedDB = [[Database alloc] init];
    }
}

/*
- (void)documentIsReady
{
    if (document.documentState == UIDocumentStateNormal)
    {
        context = document.managedObjectContext;
    }
}*/

- (void)insertIndividualFormWithInfo:(NSDictionary *)info
{
    
    IndividualForm *form = [NSEntityDescription insertNewObjectForEntityForName:@"Form" inManagedObjectContext:context];
    form.aid = [info objectForKey:@"aid"];
    form.dba = [info objectForKey:@"dba"];
    form.email = [info objectForKey:@"email"];
    form.firstName = [info objectForKey:@"firstName"];
    form.lastName = [info objectForKey:@"lastName"];
    form.phoneNumber = [info objectForKey:@"phoneNumber"];
    form.ssn = [info objectForKey:@"ssn"];
    form.suiteApt = [info objectForKey:@"suiteApt"];
    form.zipCode = [info objectForKey:@"zipCode"];
    form.fid = [info objectForKey:@"fid"];
    form.msid = [info objectForKey:@"msid"];
    form.dob = [info objectForKey:@"dob"];
    form.address = [info objectForKey:@"address"];
    
    //Get object pointers given ids from info dictionary
    //form.whereFilled = ;
    //form.whoFilled = ;
    /*
    NSError *error;
    if (![context save:&error])
        NSLog(@"Error saving: %@", [error localizedDescription]);
    else
        NSLog(@"Success Saving");
     */
}

- (void)insertBusinessFormWithInfo:(NSDictionary *)info
{
    
}

- (void)insertAgentWithInfo:(NSDictionary *)info
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
}

- (void)insertMarketSourceWithInfo:(NSDictionary *)info
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
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
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
