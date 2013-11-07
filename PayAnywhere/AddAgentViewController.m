//
//  AddAgentViewController.m
//  PayAnywhere
//
//  Created by newuser on 11/5/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "AddAgentViewController.h"
#import "Agent.h"
#import "Database.h"

@interface AddAgentViewController ()

@end

@implementation AddAgentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAgent:(id)sender {
    
    //Error Check Input
    if ([self.firstName.text isEqualToString:@""]
        || [self.lastName.text isEqualToString:@""]
        || ![[NSScanner scannerWithString:self.pin.text] scanInt:NULL]
        || ![[NSScanner scannerWithString:self.agentID.text] scanInt:NULL])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Fields"
                                                        message:@"Please fill out all the required fields"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    //Add to database
    else
    {
        NSDictionary *newAgentDict = [NSDictionary
                                      dictionaryWithObjects:
                                        @[self.firstName.text,
                                          self.lastName.text,
                                          [NSNumber numberWithInt:[self.pin.text intValue]],
                                          [NSNumber numberWithInt:[self.agentID.text intValue]]]
                                      forKeys:@[@"firstName", @"lastName", @"pin", @"aid"]];

        
        [[Database sharedDB] insertAgentWithInfo:newAgentDict];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
@end
