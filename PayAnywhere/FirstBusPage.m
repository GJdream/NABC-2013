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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.application = [[defaults objectForKey:@"formDictionary"]mutableCopy];
    
    self.last.delegate = self;
    self.first.delegate = self;
    self.email.delegate = self;
    self.phone.delegate = self;
    self.address.delegate = self;
    self.suiteApt.delegate = self;
    self.zip.delegate = self;
    self.ssn.delegate = self;
    self.dba.delegate = self;
    
    self.tabBarController.delegate = self;
    
    
    // WE NEED NEW DATA STORAGE!!!
    
    NSLog(@"Business on appear application dictionary: %@", self.application);
    
	// Do any additional setup after loading the view.
    
    //Fill text fields if possible
    self.last.text = [self.application objectForKey:@"lastName"];
    self.first.text = [self.application objectForKey:@"firstName"];
    self.email.text = [self.application objectForKey:@"email"];
    self.phone.text = [self.application objectForKey:@"phoneNumber"];
    self.address.text = [self.application objectForKey:@"address"];
    self.suiteApt.text = [self.application objectForKey:@"suiteApt"];
    self.zip.text = [self.application objectForKey:@"zipCode"];
    self.ssn.text = [self.application objectForKey:@"ssn"];
    self.dba.text = [self.application objectForKey:@"dba"];
    
    
    //Business1 only fields
    self.businessAddress.text = [self.application objectForKey:@"businessAddress"];
    self.businessSuiteApt.text = [self.application objectForKey:@"businessSuiteApartment"];
    self.businessZip.text = [self.application objectForKey:@"businessZipCode"];
    
    [self toggleTextFields];
}

-(void)viewWillAppear:(BOOL)animated
{
    MarketSource *activeTradeshow = [[Database sharedDB] getActiveTradeshow];
    Agent *activeAgent = [[Database sharedDB] getActiveAgent];
    if (activeTradeshow != nil) {
        self.activeTradeshowLabel.text = activeTradeshow.name;
    }
    else {
        self.activeTradeshowLabel.text = @"";
    }
    
    if (activeAgent != nil) {
        self.currentAgentLabel.text = [NSString stringWithFormat:@"%@ %@", activeAgent.firstName, activeAgent.lastName];
    }
    else {
        self.currentAgentLabel.text = @"";
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self fillBus1Dictionary];
}


- (void)viewDidLoad
{    
    [super viewDidLoad];
    
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
    else if([[segue identifier] isEqualToString:@"Bus1To2Segue"]) {
        [self.view endEditing:YES];
        [self fillBus1Dictionary];
    }
}

- (void)dismissPop: (NSDate *)date {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    NSLog(@"%@",dateString);
    [self.application setObject:dateString forKey:@"dob"];
    [birthdayButton setTitle:dateString forState:UIControlStateNormal];
}

- (IBAction)toggleBusFields:(id)sender {
    NSLog(@"toggling fields...");
    fieldsOn=!fieldsOn;
    [self toggleTextFields];
}

- (IBAction)nextPage:(id)sender {
    NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];
    
    //Check agent and market Source
    MarketSource *activeTradeshow = [[Database sharedDB] getActiveTradeshow];
    Agent *activeAgent = [[Database sharedDB] getActiveAgent];
    if(activeAgent == nil || activeTradeshow == nil){
        if(activeAgent == nil){
            [alertMessageMutable appendString:@"Active Agent, "];
        }
        if(activeTradeshow == nil){
            [alertMessageMutable appendString:@"Active Tradeshow, "];
        }
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Administrative Info Not Set:"
                                                          message:alertMessageMutable
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    
    //Check if birthday has been set
    NSString *buttonName = [self.birthdayButton titleForState:UIControlStateNormal];
    NSLog(@"birth title label: %@, %i", buttonName, [buttonName isEqualToString:@"Click to select"]);
    BOOL birthFilled = !([buttonName isEqualToString:@"Click to select"]);
    NSLog(@"birthFilled: %i", birthFilled);
    
    //Check for contents of all fields
    BOOL first = [self.first.text length];
    BOOL last = [self.last.text length];
    BOOL email;
    
    NSString *emailExp = [NSString stringWithFormat:@"@"];
    NSRegularExpression *emailRegex = [NSRegularExpression regularExpressionWithPattern:emailExp
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:nil];
    NSUInteger emailMatch = [emailRegex numberOfMatchesInString:self.email.text
                                                        options:0
                                                          range:NSMakeRange(0, [self.email.text length])];
    if (emailMatch == 1) {
        email = TRUE;
    }
    else{
        email = FALSE;
    }
    
    BOOL phone = [self.phone.text length];
    NSString *phoneExp = [NSString stringWithFormat:@"^[0-9]{3}-[0-9]{3}-[0-9]{4}$"];
    NSRegularExpression *phoneRegex = [NSRegularExpression regularExpressionWithPattern:phoneExp
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:nil];
    NSUInteger phoneMatch = [phoneRegex numberOfMatchesInString:self.phone.text
                                                        options:0
                                                          range:NSMakeRange(0, [self.phone.text length])];
    NSLog(@"phoneMatch: %i", phoneMatch);
    if (phoneMatch == 1 && [self.phone.text length] == 12) {
        phone = TRUE;
    }
    else{
        phone = FALSE;
    }
    
    BOOL address = [self.address.text length];
    BOOL zip;
    BOOL ssn;
    NSString *zipExp = [NSString stringWithFormat:@"^[0-9]{5}$"];
    NSRegularExpression *zipRegex = [NSRegularExpression regularExpressionWithPattern:zipExp
                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                error:nil];
    NSUInteger zipMatch = [zipRegex numberOfMatchesInString:self.zip.text
                                                    options:0
                                                      range:NSMakeRange(0, [self.zip.text length])];
    if (zipMatch == 1 && [self.zip.text length] == 5) {
        zip = TRUE;
    }
    else{
        zip = FALSE;
    }
    NSString *ssnExp = [NSString stringWithFormat:@"^[0-9]{4}$"];
    NSRegularExpression *ssnRegex = [NSRegularExpression regularExpressionWithPattern:ssnExp
                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                error:nil];
    NSUInteger ssnMatch = [ssnRegex numberOfMatchesInString:self.ssn.text
                                                    options:0
                                                      range:NSMakeRange(0, [self.ssn.text length])];
    if (ssnMatch == 1 && [self.ssn.text length] == 4) {
        ssn = TRUE;
    }
    else{
        ssn = FALSE;
    }
    
    BOOL busAddrIsSame = [self.busAddressSwitch isOn];
    BOOL busAddr = [self.businessAddress.text length];
    BOOL busZip = [self.businessZip.text length];
    
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
    if(!busAddrIsSame){
        if(!busAddr){
            [alertMessageMutable appendString:@"Business Address, "];
        }
        if(!busZip){
            [alertMessageMutable appendString:@"Business Zip, "];
        }
    }
    //Remove the comma from the end of the string
    if([alertMessageMutable length]){
        NSRange range = NSMakeRange([alertMessageMutable length]-2, 1);
        [alertMessageMutable deleteCharactersInRange: range];
    }
    
    //If the fields are not filled in, display the alert with generated string.
    if((first && last && email && phone && address && zip && ssn && birthFilled) || TRUE){
        [self performSegueWithIdentifier:@"Bus1To2Segue" sender:nil];
    }
    
    //Perform the segue
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing:"
                                                          message:alertMessageMutable
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
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

//Fill Dictionary
- (void)fillBus1Dictionary{
    
    [self.application setObject:self.first.text forKey:@"firstName"];
    [self.application setObject:self.last.text forKey:@"lastName"];
    [self.application setObject:self.email.text forKey:@"email"];
    [self.application setObject:self.phone.text forKey:@"phoneNumber"];
    [self.application setObject:self.address.text forKey:@"address"];
    [self.application setObject:self.suiteApt.text forKey:@"suiteApt"];
    [self.application setObject:self.zip.text forKey:@"zipCode"];
    [self.application setObject:self.ssn.text forKey:@"ssn"];
    
    if([self.busAddressSwitch isOn]){
        [self.application setObject:self.address.text forKey:@"businessAddress"];
        [self.application setObject:self.suiteApt.text forKey:@"businessSuiteApartment"];
        [self.application setObject:self.zip.text forKey:@"businessZipCode"];
    }
    else{
        [self.application setObject:self.businessAddress.text   forKey:@"businessAddress"];
        [self.application setObject:self.businessSuiteApt.text forKey:@"businessSuiteApartment"];
        [self.application setObject:self.businessZip.text forKey:@"businessZipCode"];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.application forKey:@"formDictionary"];
    [defaults synchronize];
}


//View scrolling code
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

- (IBAction)clearForms:(id)sender {
    [self.birthdayButton setTitle:(@"Click to select") forState:UIControlStateNormal];
    [FunctionsClass clearBaseForm:self];
}

@end
