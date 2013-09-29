//
//  AgentViewController.m
//  PayAnywhere
//
//  Created by WEILI GU on 9/28/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "AgentViewController.h"

@interface AgentViewController ()

@end

@implementation AgentViewController

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

- (void)viewDidAppear:(BOOL)animated {
    // When Admin is selected, pop up dialog for user to input password
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Enter Passcode"];
    [dialog setMessage:@" "];
    [dialog addButtonWithTitle:@"Cancel"];
    [dialog addButtonWithTitle:@"OK"];
    dialog.tag = 5;
    
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog setTransform: moveUp];
    [dialog show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Cancel"])
    {
        [self.tabBarController setSelectedIndex:0];
    }
    else if([title isEqualToString:@"OK"])
    {
        if (![[[alertView textFieldAtIndex:0] text] isEqualToString:@"1234"]) {
            [self.tabBarController setSelectedIndex:0];
        }
    }
}

@end
