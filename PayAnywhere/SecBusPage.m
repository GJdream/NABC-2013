//
//  SecBusPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "SecBusPage.h"

@interface SecBusPage (){
    CGFloat animatedDistance;
}

@end

@implementation SecBusPage

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;

@synthesize typeButton;
@synthesize anotherTypeButton;
@synthesize monthlySalesButton;
@synthesize higestSalesButton;
@synthesize busTimeButton;
@synthesize currentPopoverSeague;
@synthesize pvc;

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
    
    if([[self.application valueForKey:@"termsAccepted"]  isEqual: @"1"]){
        NSLog(@"hi");
        [self.termsAcceptedSwitch setOn:TRUE];
    }
    else{
        [self.termsAcceptedSwitch setOn:FALSE];
    }
    
    self.corpName.delegate = self;
    self.fedTaxId.delegate = self;
    self.tabBarController.delegate = self;
    
    self.corpName.text = [self.application objectForKey:@"corpName"];
    self.fedTaxId.text = [self.application objectForKey:@"fedTaxId"];
    
    NSLog(@"Second bus page Application: %@", self.application);
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

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self fillBusinessDictionary];
}

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.corpName becomeFirstResponder];
    }
    else if (textField.tag == 2){
        [self.fedTaxId becomeFirstResponder];
    }
    else if (textField.tag == 3){
        [self.term becomeFirstResponder];
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

- (IBAction)create:(id)sender {
    //Check for required fields
    //Check if terms are accepted
    BOOL trms = [self.termsAcceptedSwitch isOn];

    //Check if dropdowns have been filled
    NSString *buttonName = [self.typeButton titleForState:UIControlStateNormal];
    BOOL weAreAFilled = !([buttonName isEqualToString:@"Select Type"]);
    
    buttonName = [self.anotherTypeButton titleForState:UIControlStateNormal];
    BOOL whoIsA = !([buttonName isEqualToString:@"Select Type"]);
    
    buttonName = [self.monthlySalesButton titleForState:UIControlStateNormal];
    BOOL monthlySalesFilled = !([buttonName isEqualToString:@"Select Range"]);
    
    buttonName = [self.higestSalesButton titleForState:UIControlStateNormal];
    BOOL highestSalesFilled = !([buttonName isEqualToString:@"Select Amount"]);
    
    //Programatically create string
    if(!(weAreAFilled && trms && whoIsA
       && monthlySalesFilled && highestSalesFilled)){
        //Create warning message
        NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];

        if(!weAreAFilled){
            [alertMessageMutable appendString:@"We are a, "];
        }
        if(!whoIsA){
            [alertMessageMutable appendString:@"Who is a, "];
        }
        if(!monthlySalesFilled){
            [alertMessageMutable appendString:@"Total Monthly CC sales, "];
        }
        if(!highestSalesFilled){
            [alertMessageMutable appendString:@"Highest Sales Amount, "];
        }
        
        if([alertMessageMutable length]){
            NSRange range = NSMakeRange([alertMessageMutable length]-2, 1);
            [alertMessageMutable deleteCharactersInRange:range];
        }
        
        if(!trms){
            [alertMessageMutable appendString:@"\n Terms and Conditions not Accepted"];
        }
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing:"
                    message:alertMessageMutable
                    delegate:nil
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil];
        [message show];
    }
    else{
        [self performSegueWithIdentifier:@"BusToBankSegue" sender:nil];
    }
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:FALSE];
}

//type
- (void)typePickerViewControllerDidFinish:(FirstTypeViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    NSLog(@"First type view controller finished");
    self.typePopoverController = nil;
}

- (void)dismissPopTypePicker:(NSString *)type {
    [self.application setObject:type forKey:@"type"];
    [typeButton setTitle:type forState:UIControlStateNormal];
    NSLog((@"type dismissed"));

}

//another type
- (void)anotherTypePickerViewControllerDidFinish:(AnotherTypePickerViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopAnotherType:(NSString *)type {
    [self.application setObject:type forKey:@"businessDescription"];
    [anotherTypeButton setTitle:type forState:UIControlStateNormal];
}

//monthly sales
- (void)monthlySalesViewControllerDidFinish:(MonthlySalesViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    NSLog(@"Monthly Sales view controller finished");
    self.typePopoverController = nil;
}

- (void)dismissPopMonthlySales:(NSString *)sales {
    [self.application setObject:sales forKey:@"ccSales"];
    [monthlySalesButton setTitle:sales forState:UIControlStateNormal];
    NSLog(@"monthlySales dismissed: %@", sales);
}

//highest sales
- (void)highestSalesViewControllerDidFinish:(HighestSalesViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopHighestSales:(NSString *)sales {
    [self.application setObject:sales forKey:@"higestSales"];
    [higestSalesButton setTitle:sales forState:UIControlStateNormal];
}

//bus time
- (void)busTimeViewControllerDidFinish:(BusTimeViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopBusTime:(NSString *)time {
    [self.application setObject:time forKey:@"yearsInBusiness"];
    [busTimeButton setTitle:time forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectedType"] || [[segue identifier] isEqualToString:@"selectAnotherType"] || [[segue identifier] isEqualToString:@"selectMonthlySales"] || [[segue identifier] isEqualToString:@"selectHighestSales"] || [[segue identifier] isEqualToString:@"selectBusTime"]) {
        currentPopoverSeague = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
         NSLog(@"setDelegate: %@", self);
        [pvc setDelegate:self];
    }
    else{
        [self fillBusinessDictionary];
    }
    
    if ([segue.identifier isEqualToString:@"BusToBankSegue"]) {
        [self.application setObject:@"business" forKey:@"applicationType"];
        NSLog(@"self: %@", self.application);
        
//        BankPageViewController * bankPage = segue.destinationViewController;
//        bankPage.application = self.application;
    }
}


-(void)fillBusinessDictionary{
    BOOL trmsAcc = [self.termsAcceptedSwitch isOn];
    if(trmsAcc){
        [self.application setValue:@"1" forKey:@"termsAccepted"];
    }
    else{
        [self.application setValue:@"0" forKey:@"termsAccepted"];
    }
    
    [self.application setObject:self.corpName.text forKey:@"corpName"];
    [self.application setObject:self.fedTaxId.text forKey:@"fedTaxID"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.application forKey:@"formDictionary"];
    [defaults synchronize];
}

-(void)toggleCheck{
//    NSNumber * tru = [NSNumber numberWithBool:TRUE];
    if([self.application valueForKey:@"termsAccepted"]){
        [self.application setValue:@"0" forKey:@"termsAccepted"];
        NSLog(@"Setting to 0");
//        [self.termsAcceptedSwitch setOn:FALSE];
    }
    else{
        [self.application setValue:@"1" forKey:@"termsAccepted"];
        NSLog(@"Setting to 0");
//        [self.termsAcceptedSwitch setOn:TRUE];

    }
//    FunctionsClass * funcClass = [[FunctionsClass alloc] init];
//    [funcClass toggleCheckbox:self.checkBox boolInt:[self.application valueForKey:@"termsAccepted"]];
    
    NSLog(@"Terms accepted: %@", [self.application objectForKey:@"termsAccepted"]);
}

//View Scrolling code
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
