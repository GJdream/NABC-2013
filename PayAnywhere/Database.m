//
//  Database.m
//  PayAnywhere
//
//  Created by newuser on 9/24/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "Database.h"

@implementation Database

UIManagedDocument *document;
NSURL *documentURL;
NSManagedObjectContext *context;

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Initialized successfully");
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
    }
    return self;
}

- (void)documentIsReady
{
    if (document.documentState == UIDocumentStateNormal)
    {
        context = document.managedObjectContext;
    }
}

- (void)insertForm
{
    
    NSManagedObject *form = [NSEntityDescription insertNewObjectForEntityForName:@"Form"
                                                          inManagedObjectContext:context];
}

- (void)insertAgent
{
    
}

- (void)insertMarketSource
{
    
}


@end
