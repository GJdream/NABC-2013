//
//  FirstBusPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "birthdayViewController.h"

@interface FirstBusPage : UIViewController <BirthdayViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UIButton *birthdayButton;

@property (strong, nonatomic) UIPopoverController * birthdayPopoverController;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) BirthdayViewController *pvc;

@end
