//
//  FirstIndivPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FinishPage.h"
#import "BankPageViewController.h"
#import "birthdayViewControllerIndiv.h"

@interface FirstIndivPage : UIViewController<UITextFieldDelegate, BirthdayViewControllerIndivDelegate, UIPopoverControllerDelegate, UITabBarDelegate, UITabBarControllerDelegate>
{
    @public
    NSInteger fromWhichBusPage;
    NSInteger termsAccepted;
}

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UITextField *first;
@property (strong, nonatomic) IBOutlet UITextField *last;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UIButton *birth;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *suiteApt;
@property (strong, nonatomic) IBOutlet UITextField *zip;
@property (strong, nonatomic) IBOutlet UITextField *ssn;
@property (strong, nonatomic) IBOutlet UITextField *dba;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *term;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;
@property (strong, nonatomic) IBOutlet UISwitch *termsAcceptedSwitch;

@property (weak, nonatomic) IBOutlet UILabel *activeTradeshowLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentAgentLabel;

- (IBAction)create:(id)sender;
- (IBAction)clearForm:(id)sender;

//birth pop
@property (strong, nonatomic) UIPopoverController * birthdayPopoverController;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) BirthdayViewControllerIndiv *pvc;

@end
