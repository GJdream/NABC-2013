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
    [super viewDidLoad];
    
    NSLog(@"application dictionary: %@", self.application);
    
    self.last.delegate = self;
    self.email.delegate = self;
    self.phone.delegate = self;
    self.address.delegate = self;
    self.suiteApt.delegate = self;
    self.zip.delegate = self;
    self.ssn.delegate = self;
    self.dba.delegate = self;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)create:(id)sender {
    [self performSegueWithIdentifier:@"FinishSegue" sender:nil];
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
    if ([segue.identifier isEqualToString:@"FinishSegue"]) {

        //Create a dictionary with the information from the text fields
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
        
        //Create JSON using self.application
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.application
                                                           options:0
                                                             error:&error];
            
        NSString *postLength = [NSString stringWithFormat:@"%d", [jsonData length]];
        
        //NSLog(@"jsonData: %@", jsonData);

        //Make the JSON request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        //URL for individual POST
        [request setURL:[NSURL URLWithString:@"http://141.212.105.78:8080/app.php/individual/"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        
        //Create and recieve the response from the server
        NSURLResponse *response;
        NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
        NSLog(@"Reply: %@", theReply);

                
        FinishPage * finishPage = segue.destinationViewController;
        finishPage.application = self.application;
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
    
    [birth setTitle:dateString forState:UIControlStateNormal];
}


@end
