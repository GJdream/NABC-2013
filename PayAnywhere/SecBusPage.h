//
//  SecBusPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "TypePickerViewController.h"

@interface SecBusPage : UIViewController <TypePickerViewControllerDelegate, UIPopoverControllerDelegate>
{
}

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UITextField *corpName;
@property (strong, nonatomic) IBOutlet UITextField *dba;
@property (strong, nonatomic) IBOutlet UITextField *fedTaxId;
@property (strong, nonatomic) IBOutlet UIButton *term;

- (IBAction)weAreA:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *typeButton;

@property (strong, nonatomic) UIPopoverController *typePopoverController;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSeague;
@property (strong, nonatomic) TypePickerViewController *pvc;

@end
