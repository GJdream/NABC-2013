//
//  FirstBusPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FirstBusPage.h"

@interface FirstBusPage ()

@end



@implementation FirstBusPage

bool fieldsOn;

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.email becomeFirstResponder];
    }
    else if(textField.tag == 2){
        [self.phone becomeFirstResponder];
    }
    else if (textField.tag == 4){
        [self.suiteApt becomeFirstResponder];
    }
    else if (textField.tag == 5){
        [self.zip becomeFirstResponder];
    }
    else if (textField.tag == 6){
        [self.ssn becomeFirstResponder];
    }
    else if (textField.tag == 7){
        [self.businessAddress becomeFirstResponder];
    }
    else if (textField.tag == 8){
        [self.businessSuiteApt becomeFirstResponder];
    }
    else if (textField.tag == 9){
        [self.businessZip becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

@synthesize birthdayButton;
@synthesize currentPopoverSegue;
@synthesize pvc;
@synthesize birthday;
@synthesize sameAsBusAddress;

//comment
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
    
    NSLog(@"application dictionary: %@", self.application);
    
    self.last.delegate = self;
    self.email.delegate = self;
    self.phone.delegate = self;
    self.address.delegate = self;
    self.suiteApt.delegate = self;
    self.zip.delegate = self;
    self.ssn.delegate = self;
    self.businessAddress.delegate = self;
    self.businessSuiteApt.delegate = self;
    self.businessZip.delegate = self;
    
    
	// Do any additional setup after loading the view.
    
    [self toggleTextFields];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//birthday popover

- (void)birthdayViewControllerDidFinish:(BirthdayViewController *)controller
{
    [self.birthdayPopoverController dismissPopoverAnimated:YES];
    self.birthdayPopoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.birthdayPopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"birthPopBus"]) {
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
    }
    else if([[segue identifier] isEqualToString:@"SecondBusPageSegue"]) {
       
        [self.application setObject:self.first.text forKey:@"First Name"];
        [self.application setObject:self.last.text forKey:@"Last Name"];
        [self.application setObject:self.email.text forKey:@"Email Address"];
        [self.application setObject:self.phone.text forKey:@"Phone Number"];
        [self.application setObject:self.address.text forKey:@"Residential Address"];
        [self.application setObject:self.suiteApt.text forKey:@"Suite/Apartment"];
        [self.application setObject:self.zip.text forKey:@"Zip Code"];
        [self.application setObject:self.ssn.text forKey:@"SSN"];
        [self.application setObject:self.businessAddress.text forKey:@"Business Address"];
        [self.application setObject:self.businessSuiteApt.text forKey:@"Business Suite/Apartment"];
        [self.application setObject:self.businessZip.text forKey:@"Business Zip Code"];
        

        
        
        NSLog(@"application dictionary: %@", self.application);
        
        
        SecBusPage * secondBusPage = segue.destinationViewController;
        secondBusPage.application = self.application;
    }
    
}

- (void)dismissPop: (NSDate *)date {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    NSLog(@"%@",dateString);
    
    [birthdayButton setTitle:dateString forState:UIControlStateNormal];
}

- (IBAction)toggleBusFields:(id)sender {
    fieldsOn=!fieldsOn;
    [self toggleTextFields];
}

- (void)toggleTextFields{
    //Create text field color
    UIColor * grayedFieldColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.7912 alpha:.5];
    
    if(!fieldsOn){
        [self.businessAddress setEnabled:NO];
        self.businessAddress.backgroundColor = grayedFieldColor;
        [self.businessSuiteApt setEnabled:NO];
        self.businessSuiteApt.backgroundColor = grayedFieldColor;
        [self.businessZip setEnabled:NO];
        self.businessZip.backgroundColor = grayedFieldColor;
        
        //Change Button Image
        [self.sameAsBusAddress setImage:[UIImage imageNamed:@"checkboxSelected.png"] forState:UIControlStateNormal];
    }
    
    else{
        [self.businessAddress setEnabled:YES];
        self.businessAddress.backgroundColor = [UIColor whiteColor];
        [self.businessSuiteApt setEnabled:YES];
        self.businessSuiteApt.backgroundColor = [UIColor whiteColor];
        [self.businessZip setEnabled:YES];
        self.businessZip.backgroundColor = [UIColor whiteColor];
        
        //Change Button Image
        [self.sameAsBusAddress setImage:[UIImage imageNamed:@"checkboxUnselected.png"] forState:UIControlStateNormal];
    }
}
@end
