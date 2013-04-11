//
//  SecBusPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "SecBusPage.h"

@interface SecBusPage ()

@end

@implementation SecBusPage

@synthesize typeButton;
@synthesize anotherTypeButton;
@synthesize monthlySalesButton;
@synthesize higestSalesButton;
@synthesize busTimeButton;
@synthesize currentPopoverSeague;
@synthesize pvc;
//@synthesize type;

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
    NSNull * nullObj = [NSNull null];
    
    self.corpName.delegate = self;
    self.dba.delegate = self;
    self.fedTaxId.delegate = self;
 
    NSLog(@"Application: %@", self.application);
	// Do any additional setup after loading the view.
    
    //Fill text fields if possible
    if([self.application objectForKey:@"Corporation Name"] != nullObj)
        self.corpName.text = [self.application objectForKey:@"Corporation Name"];
    if([self.application objectForKey:@"DBA"] != nullObj)
        self.dba.text = [self.application objectForKey:@"DBA"];
    if([self.application objectForKey:@"Federal Tax ID"] != nullObj)
        self.fedTaxId.text = [self.application objectForKey:@"Federal Tax ID"];
/*
    //Set textbox image correctly
    NSNumber * trmsAcc = [NSNumber numberWithBool:FALSE];
    trmsAcc = [self.application valueForKey:@"Terms Accepted"];
    
    NSLog(@"Terms accepted: %@", trmsAcc);
    
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

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.corpName becomeFirstResponder];
    }
    else if(textField.tag == 2){
        [self.dba becomeFirstResponder];
    }
    else if (textField.tag == 4){
        [self.fedTaxId becomeFirstResponder];
    }
    else if (textField.tag == 5){
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
    NSNumber * trms = [NSNumber numberWithBool:FALSE];
    trms = [self.application valueForKey:@"Terms Accepted"];

    //Check if dropdowns have been filled
    NSString *buttonName = [self.typeButton titleForState:UIControlStateNormal];
    BOOL weAreAFilled = !([buttonName isEqualToString:@"Select Type"]);
    
    buttonName = [self.anotherTypeButton titleForState:UIControlStateNormal];
    BOOL whoIsA = !([buttonName isEqualToString:@"Select Type"]);
    
    buttonName = [self.monthlySalesButton titleForState:UIControlStateNormal];
    BOOL monthlySalesFilled = !([buttonName isEqualToString:@"Select Range"]);
    
    buttonName = [self.higestSalesButton titleForState:UIControlStateNormal];
    BOOL highestSalesFilled = !([buttonName isEqualToString:@"Select Range"]);
    
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

- (IBAction)bus2ToIndiv:(id)sender {
    [self performSegueWithIdentifier:@"Bus2ToIndivSegue" sender:nil];
}

- (IBAction)toggleBox:(id)sender {
        [self toggleCheck];
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

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.typePopoverController = nil;
}

- (void)dismissPop:(NSString *)type {
    [typeButton setTitle:type forState:UIControlStateNormal];
    //[[currentPopoverSeague popoverController] dismissPopoverAnimated: YES];
}

//another type

- (void)anotherTypePickerViewControllerDidFinish:(AnotherTypePickerViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopAnotherType:(NSString *)type {
    [anotherTypeButton setTitle:type forState:UIControlStateNormal];
}

//monthly sales

- (void)monthlySalesViewControllerDidFinish:(MonthlySalesViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopMonthlySales:(NSString *)sales {
    [monthlySalesButton setTitle:sales forState:UIControlStateNormal];
}

//highest sales

- (void)highestSalesViewControllerDidFinish:(HighestSalesViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopHighestSales:(NSString *)sales {
    [higestSalesButton setTitle:sales forState:UIControlStateNormal];
}

//bus time

- (void)busTimeViewControllerDidFinish:(BusTimeViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)dismissPopBusTime:(NSString *)time {
    [busTimeButton setTitle:time forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectedType"] || [[segue identifier] isEqualToString:@"selectAnotherType"] || [[segue identifier] isEqualToString:@"selectMonthlySales"] || [[segue identifier] isEqualToString:@"selectHighestSales"] || [[segue identifier] isEqualToString:@"selectBusTime"]) {
        currentPopoverSeague = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
    }
    
    if ([segue.identifier isEqualToString:@"BusToBankSegue"]) {
        [self.application setObject:@"business" forKey:@"Application Type"];
        
        NSLog(@"self: %@", self);
        
        BankPageViewController * bankPage = segue.destinationViewController;
        bankPage.application = self.application;
        
        //FinishPage * finishPage = segue.destinationViewController;
        //finishPage.application = self.application;
    }
    
    else if ([[segue identifier] isEqualToString:@"Bus2ToIndivSegue"]){
        [self fillBusinessDictionary];
        NSLog(@"application dictionary: %@", self.application);
        FirstIndivPage * firstIndivPage = segue.destinationViewController;
        firstIndivPage.application = self.application;
        firstIndivPage->fromWhichBusPage = 2;
    }
    
}


-(void)fillBusinessDictionary{
    [self.application setObject:self.corpName.text forKey:@"Corporation Name"];
    [self.application setObject:self.dba.text forKey:@"DBA"];
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

 
@end
