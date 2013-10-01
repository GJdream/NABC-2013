//
//  FirstBusPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FirstBusPage.h"

@interface FirstBusPage (){
    CGFloat animatedDistance;
}

@end



@implementation FirstBusPage

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;

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
    
    //Perform the segue
    else if([[segue identifier] isEqualToString:@"Bus1To2Segue"]){
        [self fillBus1Dictionary];
        NSLog(@"application dictionary: %@", self.application);
        
        SecBusPage * secondBusPage;
        secondBusPage.application = self.application;
            [self.navigationController pushViewController:secondBusPage animated:YES];
    
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

- (IBAction)nextPage:(id)sender {
    //Check if birthday has been set
    NSString *buttonName = [self.birthdayButton titleForState:UIControlStateNormal];
    NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];
    NSLog(@"birth title label: %@, %i", buttonName, [buttonName isEqualToString:@"Click to select"]);
    BOOL birthFilled = !([buttonName isEqualToString:@"Click to select"]);
    NSLog(@"birthFilled: %i", birthFilled);
    
    //Check for contents of all fields
    BOOL first = [self.first.text length];
    BOOL last = [self.last.text length];
    BOOL email = [self.email.text length];
    BOOL phone = [self.phone.text length];
    BOOL address = [self.address.text length];
    BOOL zip = [self.zip.text length];
    BOOL ssn = [self.ssn.text length];
    
    
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
    if(!birthFilled){
        [alertMessageMutable appendString:@"Birthday, "];
    }
    if(!ssn){
        [alertMessageMutable appendString:@"Last 4 Digits of SSN, "];
    }
    //Remove the comma from the end of the string
    if([alertMessageMutable length]){
        NSRange range = NSMakeRange([alertMessageMutable length]-2, 1);
        [alertMessageMutable deleteCharactersInRange: range];
    }
    
    //If the fields are not filled in, display the alert with generated string.
    if(!(first && last && email && phone && address && zip && ssn && birthFilled)){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing:"
                                                          message:alertMessageMutable
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
    }
    
    
    //Perform the segue
    else{
        [self fillBus1Dictionary];
        NSLog(@"application dictionary: %@", self.application);
        
        SecBusPage * secondBusPage;
        secondBusPage.application = self.application;
        [self performSegueWithIdentifier:@"Bus1To2Segue" sender:nil];
    }
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



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.x + 0.5 * textFieldRect.size.width;
    CGFloat numerator =
    midline - viewRect.origin.x
    - MINIMUM_SCROLL_FRACTION * viewRect.size.width;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.width;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
@end
