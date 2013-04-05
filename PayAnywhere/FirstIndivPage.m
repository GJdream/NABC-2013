//
//  FirstIndivPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FirstIndivPage.h"


@interface FirstIndivPage ()

@end



@implementation FirstIndivPage

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
    self.first.delegate = self;
    self.email.delegate = self;
    self.phone.delegate = self;
    self.address.delegate = self;
    self.suiteApt.delegate = self;
    self.zip.delegate = self;
    self.ssn.delegate = self;
    self.dba.delegate = self;
    
    
	// Do any additional setup after loading the view.
    
    //Fill text fields if possible
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
    if([self.application objectForKey:@"DBA"] != nullObj)
        self.dba.text = [self.application objectForKey:@"DBA"];
    
    //Set textbox image correctly
    NSNumber * trmsAcc = [NSNumber numberWithBool:FALSE];
    trmsAcc = [self.application valueForKey:@"Terms Accepted"];
    
    if(trmsAcc){
            [self.checkBox setImage:[UIImage imageNamed:@"checkboxSelected.png"] forState:UIControlStateNormal];
    }
    else{
            [self.checkBox setImage:[UIImage imageNamed:@"checkboxUnselected.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)create:(id)sender {
    //Create variable to track terms accepted
    NSNumber * trmsAcc = [NSNumber numberWithBool:FALSE];
    trmsAcc = [self.application valueForKey:@"Terms Accepted"];
    
    //Check if birthday has been set
    NSString *buttonName = [self.birth titleForState:UIControlStateNormal];
    NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];
    NSLog(@"birth title label: %@, %i", buttonName, [buttonName isEqualToString:@"Click to select"]);
    BOOL birthFilled = !([buttonName isEqualToString:@"Click to select"]);
    NSLog(@"birthFilled: %i", birthFilled);
    
    //Check for contents of all fields
    BOOL first = [self.first.text length];
    BOOL last = [self.first.text length];
    BOOL email = [self.email.text length];
    BOOL phone = [self.phone.text length];
    BOOL address = [self.address.text length];
    BOOL zip = [self.zip.text length];
    BOOL ssn = [self.ssn.text length];
    

    //Create the alert string
    if(!first){
        [alertMessageMutable appendString:@"First Name, "];
    }
    if(!last){
        [alertMessageMutable appendString:@"Last Name, "];
    }
    if(!email){
        [alertMessageMutable appendString:@"Email, "];
    }
    if(!phone){
        [alertMessageMutable appendString:@"Phone Number, "];
    }
    if(!address){
        [alertMessageMutable appendString:@"Address, "];
    }
    if(!zip){
        [alertMessageMutable appendString:@"Zip Code, "];
    }
    if(!ssn){
        [alertMessageMutable appendString:@"Birthday, "];
    }
    if(!birthFilled){
        [alertMessageMutable appendString:@"Last 4 Digits of SSN, "];
    }
    //Remove the comma from the end of the string
    if([alertMessageMutable length]){
        NSRange range = NSMakeRange([alertMessageMutable length]-2, 1);
        [alertMessageMutable deleteCharactersInRange: range];
    }
    if(!trmsAcc){
        [alertMessageMutable appendString:@"\n Terms and Conditions not Accepted"];
    }

    //Fill the dictionary with contents of the text fields
    [self fillDictionary];
    
    //If all the required fields are filled in, do the segue
    if(first && last && email && phone && address && zip && ssn && trmsAcc && birthFilled){
    [self performSegueWithIdentifier:@"FinishSegue" sender:nil];
    }
    //Otherwise, display the alert view with generated string
    else
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing:"
            message:alertMessageMutable
            delegate:nil
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [message show];
        
    }
    
}

- (IBAction)businessSegue:(id)sender {
    if(fromWhichBusPage == 1){
        [self performSegueWithIdentifier:@"IndivToBus1Segue" sender:nil];
    }
    else if (fromWhichBusPage == 2){
        [self performSegueWithIdentifier:@"IndivToBus2Segue" sender:nil];
    }

}

- (IBAction)toggleBox:(id)sender {
    [self toggleCheck];
}

- (IBAction)termsButon:(id)sender {
    if([[self.application objectForKey:@"Terms Accepted"] isEqualToString:@"False"]){
        
    }
}

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
        [self.dba becomeFirstResponder];
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

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if(self.zip.text)
  //      NSLog(@"%@", self.zip.text);
    
    [self fillDictionary];

    if ([segue.identifier isEqualToString:@"FinishSegue"]) {
        [self.application setObject:@"individual" forKey:@"Application Type"];
        
        NSLog(@"self: %@", self);

                
        FinishPage * finishPage = segue.destinationViewController;
        finishPage.application = self.application;
    }
    
    //birth pop seague
    if ([[segue identifier] isEqualToString:@"birthPopIndiv"]) {
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
    }
    
    //To business 1 segue
    if([[segue identifier] isEqualToString:@"IndivToBus1Segue"]){
        FirstBusPage * firstBusPage = segue.destinationViewController;
        firstBusPage.application = self.application;
    }
    
    //To business 2 segue
    if([[segue identifier] isEqualToString:@"IndivToBus2Segue"]){
        SecBusPage * secondBusPage = segue.destinationViewController;
        secondBusPage.application = self.application;
    }
}

// birth pop
@synthesize birth;
@synthesize currentPopoverSegue;
@synthesize pvc;
@synthesize birthday;


- (void)birthdayViewControllerIndivDidFinish:(BirthdayViewControllerIndiv *)controller
{
    [self.birthdayPopoverController dismissPopoverAnimated:YES];
    self.birthdayPopoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.birthdayPopoverController = nil;
}

- (IBAction)togglePopover:(id)sender
{
    if (self.birthdayPopoverController) {
        [self.birthdayPopoverController dismissPopoverAnimated:YES];
        self.birthdayPopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (void)dismissPop: (NSDate *)date {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    NSLog(@"%@",dateString);
    
    [birth setTitle:dateString forState:UIControlStateNormal];
}

-(void)fillDictionary{
    [self.application setObject:self.first.text forKey:@"First Name"];
    [self.application setObject:self.last.text forKey:@"Last Name"];
    [self.application setObject:self.email.text forKey:@"Email Address"];
    [self.application setObject:self.phone.text forKey:@"Phone Number"];
    [self.application setObject:self.address.text forKey:@"Residential Address"];
    [self.application setObject:self.suiteApt.text forKey:@"Suite/Apartment"];
    [self.application setObject:self.zip.text forKey:@"Zip Code"];
    [self.application setObject:self.ssn.text forKey:@"SSN"];
    [self.application setObject:self.dba.text forKey:@"DBA"];


    
    NSLog(@"self: %@", self);
}

-(void)toggleCheck{
    NSNumber * tru = [NSNumber numberWithBool:TRUE];

    
    if([self.application valueForKey:@"Terms Accepted"]){
        [self.application setValue:FALSE forKey:@"Terms Accepted"];
    }
    else{
        [self.application setValue:tru forKey:@"Terms Accepted"];
    }
        FunctionsClass * funcClass = [[FunctionsClass alloc] init];
    [funcClass toggleCheckbox:self.checkBox boolInt:[self.application valueForKey:@"Terms Accepted"]];
    
    NSLog(@"Terms accepted: %@", [self.application objectForKey:@"Terms Accepted"]);
}


@end
