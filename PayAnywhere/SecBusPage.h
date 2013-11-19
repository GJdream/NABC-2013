//
//  SecBusPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "TypePickerViewController.h"
#import "AnotherTypePickerViewController.h"
#import "FirstTypeViewController.h"
#import "MonthlySalesViewController.h"
#import "HighestSalesViewController.h"
#import "BusTimeViewController.h"
#import "FinishPage.h"
#import "BankPageViewController.h"
#import "FirstBusPage.h"

@interface SecBusPage : UIViewController <FirstTypeViewControllerDelegate, AnotherTypePickerViewControllerDelegate, MonthlySalesViewControllerDelegate, HighestSalesViewControllerDelegate, BusTimeViewControllerDelegate,UIPopoverControllerDelegate, UITextFieldDelegate, UITabBarControllerDelegate, UITabBarDelegate>
{

}

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UITextField *corpName;
@property (strong, nonatomic) IBOutlet UITextField *fedTaxId;
@property (strong, nonatomic) IBOutlet UIButton *term;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;
@property (strong, nonatomic) IBOutlet UISwitch *termsAcceptedSwitch;

- (IBAction)create:(id)sender;
- (IBAction)clearForms:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *typeButton;
@property (strong, nonatomic) IBOutlet UIButton *anotherTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *monthlySalesButton;
@property (strong, nonatomic) IBOutlet UIButton *higestSalesButton;
@property (strong, nonatomic) IBOutlet UIButton *busTimeButton;

@property (strong, nonatomic) UIPopoverController *typePopoverController;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSeague;
@property (strong, nonatomic) TypePickerViewController *pvc;

@end
