//
//  FirstIndivPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FirstIndivPage.h"


@interface FirstIndivPage (){
    CGFloat animatedDistance;
}

@end



@implementation FirstIndivPage

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;

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
    
    self.application = [[NSMutableDictionary alloc]init];
    
    self.last.delegate = self;
    self.first.delegate = self;
    self.email.delegate = self;
    self.phone.delegate = self;
    self.address.delegate = self;
    self.suiteApt.delegate = self;
    self.zip.delegate = self;
    self.ssn.delegate = self;
    self.dba.delegate = self;
    
    // WE NEED NEW DATA STORAGE!!!
    
    NSLog(@"Indiv on load application dictionary: %@", self.application);
    
	// Do any additional setup after loading the view.
    
    //Fill text fields if possible
    if([self.application objectForKey:@"lastName"])
        self.last.text = [self.application objectForKey:@"lastName"];
    if([self.application objectForKey:@"firstName"])
        self.first.text = [self.application objectForKey:@"firstName"];
    if([self.application objectForKey:@"email"])
        self.email.text = [self.application objectForKey:@"email"];
    if([self.application objectForKey:@"phoneNumber"])
        self.phone.text = [self.application objectForKey:@"phoneNumber"];
    if([self.application objectForKey:@"address"])
        self.address.text = [self.application objectForKey:@"address"];
    if([self.application objectForKey:@"suiteApt"])
        self.suiteApt.text = [self.application objectForKey:@"suiteApt"];
    if([self.application objectForKey:@"zipCode"])
        self.zip.text = [self.application objectForKey:@"zipCode"];
    if([self.application objectForKey:@"ssn"])
        self.ssn.text = [self.application objectForKey:@"ssn"];
    if([self.application objectForKey:@"dba"])
        self.dba.text = [self.application objectForKey:@"dba"];

    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"Tab clicked");
    [self fillDictionary];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

/*
    //Set textbox image correctly
    NSNumber * trmsAcc = [NSNumber numberWithBool:FALSE];
    trmsAcc = [self.application valueForKey:@"Terms Accepted"];
    
    if(trmsAcc){
            [self.checkBox setImage:[UIImage imageNamed:@"checkboxSelected.png"] forState:UIControlStateNormal];
    }
    else{
            [self.checkBox setImage:[UIImage imageNamed:@"checkboxUnselected.png"] forState:UIControlStateNormal];
    }
*/ 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)create:(id)sender {
    //Create variable to track terms accepted
    BOOL trmsAcc = [self.termsAcceptedSwitch isOn];
    
    //Check if birthday has been set
    NSString *buttonName = [self.birth titleForState:UIControlStateNormal];
    NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];
    BOOL birthFilled = !([buttonName isEqualToString:@"Click to select"]);
    
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
    
    
    //Fill the dictionary with contents of the text fields
    [self fillDictionary];
    
    //If all the required fields are filled in, do the segue
    if((first && last && email && phone && address && zip && ssn && trmsAcc && birthFilled) || TRUE){
    [self performSegueWithIdentifier:@"IndivToBankSegue" sender:nil];
    }
    //Otherwise, display the alert view with generated string
    else
    {
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
            [alertMessageMutable appendString:@"Last 4 Digits of SSN, "];
        }
        if(!birthFilled){
            [alertMessageMutable appendString:@"Birthday, "];
        }
        //Remove the comma from the end of the string
        if([alertMessageMutable length]){
            NSRange range = NSMakeRange([alertMessageMutable length]-2, 1);
            [alertMessageMutable deleteCharactersInRange: range];
        }
        if(!trmsAcc){
            [alertMessageMutable appendString:@"\n Terms and Conditions not Accepted"];
        }
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing:"
                                                          message:alertMessageMutable
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
    }
    
}

- (IBAction)Cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:FALSE];
}

- (IBAction)termsButon:(id)sender {
    if([[self.application objectForKey:@"termsAccepted"] isEqualToString:@"False"]){
        
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
    [self fillDictionary];

    if([segue.identifier isEqualToString:@"IndivToBankSegue"]){
        BankPageViewController * bankPage = segue.destinationViewController;
        bankPage.application = self.application;
        [self.application setObject:@"individual" forKey:@"applicationType"];
    }
    
    //birth pop seague
    if ([[segue identifier] isEqualToString:@"birthPopIndiv"]) {
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
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
    [self.application setObject:dateString forKey:@"dob"];
    [birth setTitle:dateString forState:UIControlStateNormal];
}

-(void)fillDictionary{
    [self.application setObject:self.first.text forKey:@"firstName"];
    [self.application setObject:self.last.text forKey:@"lastName"];
    [self.application setObject:self.email.text forKey:@"email"];
    [self.application setObject:self.phone.text forKey:@"phoneNumber"];
    [self.application setObject:self.address.text forKey:@"address"];
    [self.application setObject:self.suiteApt.text forKey:@"suiteApt"];
    [self.application setObject:self.zip.text forKey:@"zipCode"];
    [self.application setObject:self.ssn.text forKey:@"ssn"];
    [self.application setObject:self.dba.text forKey:@"dba"];
    
    NSLog(@"self: %@", self.application);
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
/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
*/

@end
