//
//  AuthenticationVC.m
//  PayAnywhere
//
//  Created by Jorge Viramontes on 3/20/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "AuthenticationVC.h"
#import "SplitViewController.h"

@implementation AuthenticationVC

@synthesize delegate;

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
    self.contentSizeForViewInPopover = CGSizeMake(300, 200);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authenticate:(id)sender
{
    if ([self.passcode.text isEqualToString:@""])
    {
        self.textLabel.text = @"Incorrect passcode";
    }
    else
    {
        //[delegate dismissPopAuthentication];
        [delegate authenticationVCDidFinish:self];
    }
}

@end
