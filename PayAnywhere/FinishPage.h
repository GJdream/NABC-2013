//
//  FinishPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

// awesome Comment

#import <UIKit/UIKit.h>
#import "FirstIndivPage.h"
#import "FirstPage.h"

#import "Application.h"
#import "SignupAnywhereDB.h"

#import "Database.h"

@interface FinishPage : UIViewController<UITextFieldDelegate, UITabBarControllerDelegate, UITabBarDelegate>
{
    SignupAnywhereDB * db;
}

@property (strong, nonatomic) NSMutableDictionary * application;
@property (strong, nonatomic) IBOutlet UIButton *radioButtonOne;
@property (strong, nonatomic) IBOutlet UIButton *radioButtonTwo;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet UITextField *suiteAptField;
@property (strong, nonatomic) IBOutlet UITextField *zipField;

- (IBAction)radioButtonOneClicked:(id)sender;
- (IBAction)radioButtonTwoClicked:(id)sender;
- (IBAction)create:(id)sender;
- (IBAction)changeAddress:(id)sender;
- (IBAction)finish:(id)sender;
- (IBAction)clearForms:(id)sender;

@end
