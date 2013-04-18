//
//  FirstPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthenticationVC.h"

#import "SignupAnywhereDB.h"
#import "TradeShow.h"
#import "TradeShowAgentHomeViewController.h"
/*
@class FirstPageViewController;

@protocol FirstPageViewControllerDelegate <NSObject>

- (void) firstPageViewControllerDidFinish: (FirstPageViewController *)controller;
- (void) dismissFirstPage;

@end
*/
@interface FirstPage : UIViewController<UIPopoverControllerDelegate, AuthenticationDelegate>
{
    BOOL authenticationSuccess;
}

//@property (weak, nonatomic) id <FirstPageViewControllerDelegate> delegate;

@property(strong, nonatomic) NSMutableDictionary * application;
@property(strong, nonatomic) UIPopoverController * popover;


- (IBAction)business:(id)sender;

- (IBAction)individual:(id)sender;

- (IBAction)settings:(id)sender;
@end
