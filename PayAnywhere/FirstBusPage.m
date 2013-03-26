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
    NSNull * nullObj = [NSNull null];

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
    
    //Fill in text fields if possible
    if([self.application objectForKey:@"Last Name"] != nullObj)
        self.last.text = [self.application objectForKey:@"Last Name"];
    if([self.application objectForKey:@"First Name"] != nullObj)
        self.first.text = [self.application objectForKey:@"First Name"];
    if([self.application objectForKey:@"Email Address"] != nullObj)
        self.email.text = [self.application objectForKey:@"Email Address"];
    if([self.application objectForKey:@"Phone Number"] != nullObj)
        self.phone.text = [self.application objectForKey:@"Phone Number"];
    if([self.application objectForKey:@"Residential Address"] != nullObj)
        self.address.text = [self.application objectForKey:@"Residential Address"];
    if([self.application objectForKey:@"Suite/Apartment"] != nullObj)
        self.suiteApt.text = [self.application objectForKey:@"Suite/Apartment"];
    if([self.application objectForKey:@"Zip Code"] != nullObj)
        self.zip.text = [self.application objectForKey:@"Zip Code"];
    if([self.application objectForKey:@"SSN"] != nullObj)
        self.ssn.text = [self.application objectForKey:@"SSN"];
    
    //Business1 only fields
    if([self.application objectForKey:@"Business Address"] != nullObj)
        self.businessAddress.text = [self.application objectForKey:@"Business Address"];
    if([self.application objectForKey:@"Business Suite/Apartment"] != nullObj)
        self.businessSuiteApt.text = [self.application objectForKey:@"Business Suite/Apartment"];
    if([self.application objectForKey:@"Business Zip Code"] != nullObj)
        self.businessZip.text = [self.application objectForKey:@"Business Zip Code"];

    
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
       
        [self fillBus1Dictionary];
        NSLog(@"application dictionary: %@", self.application);
        
        
        SecBusPage * secondBusPage = segue.destinationViewController;
        secondBusPage.application = self.application;
    }
    else if ([[segue identifier] isEqualToString:@"Bus1ToIndivSegue"]){
        [self fillBus1Dictionary];
        NSLog(@"application dictionary: %@", self.application);
        FirstIndivPage * firstIndivPage = segue.destinationViewController;
        firstIndivPage.application = self.application;
        firstIndivPage->fromWhichBusPage = 1;
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
- (IBAction)fromBus1ToIndiv:(id)sender {
    [self performSegueWithIdentifier:@"Bus1ToIndivSegue" sender:nil];
}

//Fill Dictionary
- (void)fillBus1Dictionary{
    
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
    
}
@end
