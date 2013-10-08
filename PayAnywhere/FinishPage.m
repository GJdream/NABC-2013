//
//  FinishPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FinishPage.h"

@interface FinishPage (){
    CGFloat animatedDistance;
}

@end

@implementation FinishPage

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;

@synthesize radioButtonOne;
@synthesize radioButtonTwo;

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
    UIColor * grayedFieldColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.7912 alpha:.5];
    
    
    [super viewDidLoad];
       NSLog(@"application dictionary: %@", self.application);
    if([[self.application valueForKey:@"Application Type"] isEqualToString:@"individual"])
    {
        self.addressField.text = [self.application valueForKey:@"Residential Address"];
        self.zipField.text = [self.application valueForKey:@"Zip Code"];
        self.suiteAptField.text = [self.application valueForKey:@"Suite/Apartment"];
    }
    
    else
    {
        self.addressField.text = [self.application valueForKey:@"Business Address"];
        self.zipField.text = [self.application valueForKey:@"Business Zip Code"];
        self.suiteAptField.text = [self.application valueForKey:@"Business Suite/Apartment"];
    }
    
    [self.addressField setEnabled:NO];
    self.addressField.backgroundColor = grayedFieldColor;
    [self.zipField setEnabled:NO];
    self.zipField.backgroundColor = grayedFieldColor;
    [self.suiteAptField setEnabled:NO];
    self.suiteAptField.backgroundColor = grayedFieldColor;
    
    db = [[SignupAnywhereDB alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.addressField becomeFirstResponder];
    }
    else if(textField.tag == 2){
        [self.suiteAptField becomeFirstResponder];
    }
    else if (textField.tag == 4){
        [self.zipField becomeFirstResponder];
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

- (IBAction)radioButtonOneClicked:(id)sender {
    [radioButtonOne setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateNormal];
    [radioButtonTwo setImage:[UIImage imageNamed:@"radio_uncheck.png"] forState:UIControlStateNormal];
}

- (IBAction)radioButtonTwoClicked:(id)sender {
    [radioButtonTwo setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateNormal];
    [radioButtonOne setImage:[UIImage imageNamed:@"radio_uncheck.png"] forState:UIControlStateNormal];
}

- (IBAction)create:(id)sender {
    TradeShow * testTradeshow = [[TradeShow alloc] init];
    testTradeshow.name = @"Test Tradeshow";
    testTradeshow.city = @"Ann Arbor";
    testTradeshow.state = @"Michigan";
    testTradeshow.date = [NSDate date];
    
    
    [self sendJSON];
    
    [db addNewTradeshow:testTradeshow];
    
    [self.application setObject:testTradeshow forKey:@"Tradeshow"];
    
    [db addNewApplication:self.application];
    
    NSLog(@"%@ %@ application was submitted at the %@ in %@, %@",
          [self.application objectForKey:@"First Name"],
          [self.application objectForKey:@"Last Name"],
          testTradeshow.name, testTradeshow.city, testTradeshow.state);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSLog(@"Test Tradeshow...\n");
    [testTradeshow printApplicants];
    
    NSLog(@"Tradeshow in DB...\n");
    [[db.tradeshows objectForKey:testTradeshow.name] printApplicants];
}

- (IBAction)changeAddress:(id)sender {
    [self.addressField setEnabled:YES];
    self.addressField.backgroundColor = [UIColor whiteColor];
    [self.zipField setEnabled:YES];
    self.zipField.backgroundColor = [UIColor whiteColor];
    [self.suiteAptField setEnabled:YES];
    self.suiteAptField.backgroundColor = [UIColor whiteColor];
}

- (IBAction)finish:(id)sender {
    [self sendJSON];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([segue.identifier isEqualToString:@"FinishToStartSegue"]) {
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
         
    }
     */
}

-(void)sendJSON{
    NSLog(@"self: %@", self);
    
    //Create JSON using self.application
    NSError *error;
    BOOL isTurnableToJSON = [NSJSONSerialization
                             isValidJSONObject: self.application];
    NSLog(@"Appliation can be an object: %hhd", isTurnableToJSON);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.application
                                                       options:0
                                                         error:&error];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsonData length]];
    
//    NSLog(@"jsonData: %@", jsonData);
    
    //Create URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

    [request setURL:[NSURL URLWithString:@"http://141.212.105.78:8080/app.php/individual/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    //Create response
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
//         NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//         NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
         NSLog(@"Request completed");

     }];
/*
    //Make the JSON request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];

    if(theConnection){
    //URL for individual POST
    if ([[self.application objectForKey:@"Application Type"] isEqual: @"individual"]) {
        [request setURL:[NSURL URLWithString:@"http://141.212.105.78:8080/app.php/individual/"]];
    } else {
        [request setURL:[NSURL URLWithString:@"http://141.212.105.78:8080/app.php/business/"]];
    }
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    //Create and recieve the response from the server
    NSHTTPURLResponse *response = nil;
   // NSError *error = nil;
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding] ;
    NSLog(@"Reply: %@", theReply);
    }
 
 */
    
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
    
        NSLog(@"heightFraction: %f", heightFraction);
    
    
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
    
        NSLog(@"distance: %f", animatedDistance);
    
    
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
