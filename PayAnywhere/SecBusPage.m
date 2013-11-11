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
@synthesize type;

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
    
    self.corpName.delegate = self;
    self.fedTaxId.delegate = self;
    self.tabBarController.delegate = self;
    
    self.corpName.text = [self.application objectForKey:@"corpName"];
    self.fedTaxId.text = [self.application objectForKey:@"fedTaxId"];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.corpName.delegate = self;
    self.fedTaxId.delegate = self;
 
    NSLog(@"Second bus page Application: %@", self.application);
	// Do any additional setup after loading the view.
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

- (IBAction)weAreA:(id)sender {
    
}

//type

- (void)typePickerViewControllerDidFinish:(TypePickerViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPop:(NSString *)type {
    [self.application setObject:type forKey:@"Business Type"];
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
    [self.application setObject:type forKey:@"Business Area"];
    [anotherTypeButton setTitle:type forState:UIControlStateNormal];
}

//monthly sales

- (void)monthlySalesViewControllerDidFinish:(MonthlySalesViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopMonthlySales:(NSString *)sales {
    [self.application setObject:sales forKey:@"Monthly Sales"];
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
    [self.application setObject:sales forKey:@"Higest Sales"];
    [higestSalesButton setTitle:sales forState:UIControlStateNormal];
}

//bus time

- (void)busTimeViewControllerDidFinish:(BusTimeViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopBusTime:(NSString *)time {
    [self.application setObject:time forKey:@"Been in Business"];
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
    
    if ([segue.identifier isEqualToString:@"BusToBankSegue"]) {
        [self.application setObject:@"business" forKey:@"applicationType"];
        [self fillBusinessDictionary];
        
        NSLog(@"self: %@", self.application);
        
        BankPageViewController * bankPage = segue.destinationViewController;
        bankPage.application = self.application;
        
    }
    
}


-(void)fillBusinessDictionary{
    [self.application setObject:self.corpName.text forKey:@"Corporation Name"];
    [self.application setObject:self.fedTaxId.text forKey:@"Federal Tax ID"];
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
    //    heightFraction = 1 - heightFraction;
    //    NSLog(@"heightFraction: %f", heightFraction);
    
    /*Working stats:
     <0 = 0, >1 = 1,
     static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
     static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
     static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
     static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
     static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;
     no height = 1-height
     */
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    //    NSLog(@"heightFraction: %f", heightFraction);
    
    
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
    
    //    NSLog(@"distance: %f", animatedDistance);
    
    
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
