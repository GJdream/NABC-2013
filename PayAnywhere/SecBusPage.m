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
        [self performSegueWithIdentifier:@"FinishSegue" sender:nil];
}

- (IBAction)bus2ToIndiv:(id)sender {
    [self performSegueWithIdentifier:@"Bus2ToIndivSegue" sender:nil];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectedType"]) {
        currentPopoverSeague = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
    }
    
    if ([segue.identifier isEqualToString:@"FinishSegue"]) {
        [self.application setObject:@"business" forKey:@"Application Type"];
        
        NSLog(@"self: %@", self);
        
        FinishPage * finishPage = segue.destinationViewController;
        finishPage.application = self.application;
    }
    
    else if ([[segue identifier] isEqualToString:@"Bus2ToIndivSegue"]){
        [self fillBusinessDictionary];
        NSLog(@"application dictionary: %@", self.application);
        FirstIndivPage * firstIndivPage = segue.destinationViewController;
        firstIndivPage.application = self.application;
        firstIndivPage->fromWhichBusPage = 2;
    }
    
}

- (void)dismissPop:(NSString *)type {
    [typeButton setTitle:type forState:UIControlStateNormal];
    //[[currentPopoverSeague popoverController] dismissPopoverAnimated: YES];
}

-(void)fillBusinessDictionary{
    [self.application setObject:self.corpName.text forKey:@"Corporation Name"];
    [self.application setObject:self.dba.text forKey:@"DBA"];
    [self.application setObject:self.fedTaxId.text forKey:@"Federal Tax ID"];
}
@end
