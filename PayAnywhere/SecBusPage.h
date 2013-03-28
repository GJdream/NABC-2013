//
//  SecBusPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "TypePickerViewController.h"
#import "AnotherTypePickerViewController.h"
#import "MonthlySalesViewController.h"
#import "HighestSalesViewController.h"
#import "BusTimeViewController.h"
#import "FinishPage.h"

@interface SecBusPage : UIViewController <TypePickerViewControllerDelegate, AnotherTypePickerViewControllerDelegate, MonthlySalesViewControllerDelegate, HighestSalesViewControllerDelegate, BusTimeViewControllerDelegate,UIPopoverControllerDelegate, UITextFieldDelegate>
{
}

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UITextField *corpName;
@property (strong, nonatomic) IBOutlet UITextField *dba;
@property (strong, nonatomic) IBOutlet UITextField *fedTaxId;
@property (strong, nonatomic) IBOutlet UIButton *term;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;

- (IBAction)create:(id)sender;
- (IBAction)bus2ToIndiv:(id)sender;
- (IBAction)toggleBox:(id)sender;

- (IBAction)weAreA:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *typeButton;
@property (strong, nonatomic) IBOutlet UIButton *anotherTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *monthlySalesButton;
@property (strong, nonatomic) IBOutlet UIButton *higestSalesButton;
@property (strong, nonatomic) IBOutlet UIButton *busTimeButton;

@property (strong, nonatomic) UIPopoverController *typePopoverController;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSeague;
@property (strong, nonatomic) TypePickerViewController *pvc;

@end
