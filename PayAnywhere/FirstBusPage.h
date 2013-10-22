//
//  FirstBusPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "SecBusPage.h"
#import "birthdayViewController.h"

@interface FirstBusPage : UIViewController <UITextFieldDelegate, BirthdayViewControllerDelegate, UIPopoverControllerDelegate>{
    @public
    NSInteger termsAccepted;
}

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UITextField *first;
@property (strong, nonatomic) IBOutlet UITextField *last;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *suiteApt;
@property (strong, nonatomic) IBOutlet UITextField *zip;
@property (strong, nonatomic) IBOutlet UITextField *ssn;
@property (strong, nonatomic) IBOutlet UITextField *dba;
@property (strong, nonatomic) IBOutlet UIButton *sameAsBusAddress;
@property (strong, nonatomic) IBOutlet UITextField *businessAddress;
@property (strong, nonatomic) IBOutlet UITextField *businessSuiteApt;
@property (strong, nonatomic) IBOutlet UITextField *businessZip;

- (IBAction)toggleBusFields:(id)sender;
- (IBAction)nextPage:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *birthdayButton;
@property (strong, nonatomic) IBOutlet UISwitch *busAddressSwitch;

@property (strong, nonatomic) UIPopoverController * birthdayPopoverController;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) BirthdayViewController *pvc;

@end
