//
//  birthdayViewControllerIndiv.m
//  PayAnywhere
//
//  Created by WEILI GU on 3/17/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "birthdayViewControllerIndiv.h"

@interface BirthdayViewControllerIndiv ()

@end

@implementation BirthdayViewControllerIndiv

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
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[self.birthdayPicker date]
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    NSLog(@"%@",dateString);
    [delegate dismissPop:[self.birthdayPicker date]];
}

@end