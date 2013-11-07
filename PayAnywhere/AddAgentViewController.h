//
//  AddAgentViewController.h
//  PayAnywhere
//
//  Created by newuser on 11/5/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAgentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *pin;
@property (weak, nonatomic) IBOutlet UITextField *agentID;
- (IBAction)createAgent:(id)sender;

@end
