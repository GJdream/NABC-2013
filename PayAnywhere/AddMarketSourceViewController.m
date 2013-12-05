//
//  AddMarketSourceViewController.m
//  PayAnywhere
//
//  Created by Nathan Shields on 11/7/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "AddMarketSourceViewController.h"

@interface AddMarketSourceViewController ()

@end

@implementation AddMarketSourceViewController

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

- (IBAction)createMarketSource:(id)sender {
    //Error Check Input
    if ([self.name.text isEqualToString:@""]
        || [self.city.text isEqualToString:@""]
        || [self.state.text isEqualToString:@""]
        || [self.msid.text isEqualToString:@""])
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
        NSDictionary *newMarketSourceDict = [NSDictionary
                                             dictionaryWithObjects:@[self.name.text, self.city.text, self.state.text,
                                                                     [NSNumber numberWithInt:[self.msid.text intValue]], self.date.date]
                                             forKeys:@[@"name", @"city", @"state", @"msid", @"date"]];
        
        [[Database sharedDB] insertMarketSourceWithInfo:newMarketSourceDict];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
