//
//  BankPageViewController.h
//  PayAnywhere
//
//  Created by Nathan Shields on 9/28/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinishPage.h"
#import "BankPageViewController.h"

@interface BankPageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *accountNumberField;
@property (strong, nonatomic) IBOutlet UITextField *routingNumberField;


@property (strong, nonatomic) NSMutableDictionary * application;
- (IBAction)enterInfo:(id)sender;
- (IBAction)skipInfo:(id)sender;


@end
