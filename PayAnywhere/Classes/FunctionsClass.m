//
//  FunctionsClass.m
//  PayAnywhere
//
//  Created by Nathan Shields on 3/26/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FunctionsClass.h"

@implementation FunctionsClass

+(void)clearAllForms:(UIViewController *)controller {
    NSLog(@"Clear all forms called...");
    NSMutableDictionary * emptyDict = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emptyDict forKey:@"formDictionary"];
    [defaults synchronize];
    NSLog(@"Dictionary cleared...");
    
    for(UIViewController *viewController in controller.tabBarController.viewControllers)
    {
        if([viewController isKindOfClass:[UINavigationController class]])
            [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
    
    [controller.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"Views Popped...");
}

+(void)clearBaseForm:(UIViewController *)controller{
    NSLog(@"Clear all forms called...");
    NSMutableDictionary * emptyDict = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emptyDict forKey:@"formDictionary"];
    [defaults synchronize];
    NSLog(@"Dictionary cleared...");
    
    [controller viewDidAppear:YES];
    
}


@end

