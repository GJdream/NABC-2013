//
//  birthdayViewController.m
//  PayAnywhere
//
//  Created by WEILI GU on 3/16/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "birthdayViewController.h"

@interface BirthdayViewController ()

@end

@implementation BirthdayViewController

@synthesize delegate;
@synthesize birthdayPicker;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 216.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [delegate dismissPop:[self.birthdayPicker date]];
}

@end