//
//  BankPageViewController.h
//  PayAnywhere
//
//  Created by Nathan Shields on 4/6/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankPageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *routingNumField;
@property (strong, nonatomic) IBOutlet UITextField *accountNumberField;

@property (strong, nonatomic) NSMutableDictionary * application;


- (IBAction)enterInfo:(id)sender;
- (IBAction)skipInfo:(id)sender;
@end
