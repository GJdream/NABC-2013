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
#import "TradeShow.h"
#import "SignupAnywhereDB.h"

@interface FinishPage : UIViewController
{
    SignupAnywhereDB * db;
}

@property (strong, nonatomic) NSMutableDictionary * application;
@property (strong, nonatomic) IBOutlet UIButton *radioButtonOne;
@property (strong, nonatomic) IBOutlet UIButton *radioButtonTwo;

- (IBAction)radioButtonOneClicked:(id)sender;
- (IBAction)radioButtonTwoClicked:(id)sender;
- (IBAction)create:(id)sender;
- (IBAction)cancel:(id)sender;

@end
