//
//  FinishPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FinishPage.h"

@interface FinishPage ()

@end

@implementation FinishPage

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
    [super viewDidLoad];
       NSLog(@"application dictionary: %@", self.application);
    
    db = [[SignupAnywhereDB alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [db addNewTradeshow:testTradeshow];
    
    [self.application setObject:testTradeshow forKey:@"Tradeshow"];
    
    [db addNewApplication:self.application];
    
    //[self sendJSON];
    
    NSLog(@"%@ %@ application was submitted at the %@ in %@, %@",
          [self.application objectForKey:@"First Name"],
          [self.application objectForKey:@"Last Name"],
          testTradeshow.name, testTradeshow.city, testTradeshow.state);
    [self.navigationController popToRootViewControllerAnimated:FALSE];
    
    NSLog(@"Test Tradeshow...\n");
    [testTradeshow printApplicants];
    
    NSLog(@"Tradeshow in DB...\n");
    [[db.tradeshows objectForKey:testTradeshow.name] printApplicants];
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
@end

