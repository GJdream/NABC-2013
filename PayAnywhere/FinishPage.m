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

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [radioButtonOne sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    self.addressField.delegate = self;
    self.zipField.delegate = self;
    self.suiteAptField.delegate = self;
    self.tabBarController.delegate = self;

    
    UIColor * grayedFieldColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.7912 alpha:.5];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.application = [[defaults objectForKey:@"formDictionary"]mutableCopy];
    
    NSLog(@"application dictionary: %@", self.application);
    if([[self.application valueForKey:FORM_TYPE] isEqualToString:@"individual"])
    {
        self.addressField.text = [self.application valueForKey:@"address"];
        self.zipField.text = [self.application valueForKey:@"zipCode"];
        self.suiteAptField.text = [self.application valueForKey:@"suiteApt"];
    }
    
    else
    {
        self.addressField.text = [self.application valueForKey:@"businessAddress"];
        self.zipField.text = [self.application valueForKey:@"businessZipCode"];
        self.suiteAptField.text = [self.application valueForKey:@"businessSuiteApt"];
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
  
    UIViewController * target = [[self.tabBarController viewControllers] objectAtIndex:1];
    [target.navigationController popToRootViewControllerAnimated: NO];
    NSString *className = NSStringFromClass([target class]);
    NSLog(@"First pop to root: %@", className);

    target = [[self.tabBarController viewControllers] objectAtIndex:0];
    [target.navigationController popToRootViewControllerAnimated: NO];
    
    className = NSStringFromClass([target class]);
    NSLog(@"Second pop to root: %@", className);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
    
    NSArray *individualForms = [[Database sharedDB] allIndividualForms];
    NSLog(@"INDIVIDUAL FORMS IN DB before insert: \n%@\n", individualForms);
    
    if([self.application objectForKey:@"zipCode"])
        self.zipField.text = [self.application objectForKey:@"zipCode"];
    if([self.application objectForKey:@"address"])
        self.addressField.text = [self.application objectForKey:@"address"];
    if([self.application objectForKey:@"suiteApt"])
        self.suiteAptField.text = [self.application objectForKey:@"suiteApt"];
    
    /* TEST DATA */
    NSMutableDictionary *testMarketSource = [[NSMutableDictionary alloc] init];
    [testMarketSource setObject:@"Chicago" forKey:@"city"];
    [testMarketSource setObject:@"IL" forKey:@"state"];
    [testMarketSource setObject:@"Test Trade Show" forKey:@"name"];
    [testMarketSource setObject:[NSDate date] forKey:@"date"];
    [testMarketSource setObject:[NSNumber numberWithInt:100] forKey:@"msid"];
    
    NSMutableDictionary *testAgent = [[NSMutableDictionary alloc] init];
    [testAgent setObject:[NSNumber numberWithInt:100] forKey:@"aid"];
    [testAgent setObject:[NSNumber numberWithInt:1234] forKey:@"pin"];
    [testAgent setObject:@"Joe" forKey:@"firstName"];
    [testAgent setObject:@"Agent" forKey:@"lastName"];
    
    MarketSource *marketSource = [[Database sharedDB] insertMarketSourceWithInfo:testMarketSource];
    Agent *agent = [[Database sharedDB] insertAgentWithInfo:testAgent];
    /**/
    
    if ([[self.application objectForKey:FORM_TYPE] isEqualToString:@"individual"]) {
        //store individual application
        [[Database sharedDB] insertIndividualFormWithInfo:self.application andAgent:agent andMarketSource:marketSource];
        
        NSArray *individualForms = [[Database sharedDB] allIndividualForms];
        NSLog(@"INDIVIDUAL FORMS IN DB after insert: \n%@\n", individualForms);
    }
    else {
        //store business application
        [[Database sharedDB] insertBusinessFormWithInfo:self.application andAgent:agent andMarketSource:marketSource];
    }

    [self sendJSON];
    NSMutableDictionary * emptyDict = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emptyDict forKey:@"formDictionary"];
    [defaults synchronize];
    
    for(UIViewController *viewController in self.tabBarController.viewControllers)
    {
        if([viewController isKindOfClass:[UINavigationController class]])
            [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clearForms:(id)sender {
    [FunctionsClass clearAllForms:self];
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
    //Create JSON using self.application
    NSError *error;
    BOOL isTurnableToJSON = [NSJSONSerialization
                             isValidJSONObject: self.application];
    NSLog(@"Appliation is valid JSON: %hhd", isTurnableToJSON);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.application
                                                       options:0
                                                         error:&error];
    

    
    
    
//    NSString *postLength = [NSString stringWithFormat:@"%d", [jsonData length]];
    
    //Create URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    /*
    NSError *e;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&e];
    NSLog(@"json file = %@", dict);
    */
    
    // Fix this so it uses macros and appends the "/individual"
    
    
    [request setURL:[NSURL URLWithString:@"http://141.212.105.78:8080/symfony/individual/"]];
 
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    //Create response
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
         NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
         NSLog(@"Request completed\n Reply: %@", theReply);

     }];
/*
    //Make the JSON request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];

    if(theConnection){
    //URL for individual POST
    if ([[self.application objectForKey:@"formType"] isEqual: @"individual"]) {
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
    
    [self.application removeAllObjects];
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.application forKey:@"formDictionary"];
    [defaults synchronize];
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
