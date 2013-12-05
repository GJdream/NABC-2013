//
//  AppDelegate.m
//  PayAnywhere
//
//  Created by Jorge Viramontes on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "AppDelegate.h"

static NSString *URL = @"http://141.212.105.78:8080/symfony/individual/batch/";

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableArray * unsentForms = [[Database sharedDB] getUnsentIndividualFroms];
    
    NSLog(@"INDIVIDUAL FORMS didFinishLaunching: \n%@\n", unsentForms);

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unsentForms
                                                            options:0
                                                           error:&error];
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = NO;
    
    _session = [NSURLSession sessionWithConfiguration:configuration
                                             delegate:self delegateQueue:nil];
    
    NSURL *uploadURL = [NSURL URLWithString:URL];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:uploadURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    _uploadTask = [self.session uploadTaskWithRequest:request fromData:jsonData
                                completionHandler:
                    ^(NSData *data, NSURLResponse *response, NSError *error) {
                        NSLog(@"hi handler: \n%@\n", response);
                        int code = [(NSHTTPURLResponse*)response statusCode];
                        if (code == 201) {
                            [[Database sharedDB] updateAllIndividualFromsToReceived];
                        }
                  }];

    [_uploadTask resume];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
