//
//  AddMarketSourceViewController.h
//  PayAnywhere
//
//  Created by Nathan Shields on 11/7/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMarketSourceViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *msid;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UIDatePicker *date;

- (IBAction)createMarketSource:(id)sender;

@end
