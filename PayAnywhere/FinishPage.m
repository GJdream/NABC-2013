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
        //[self performSegueWithIdentifier:@"FinishToStartSegue" sender:nil];
    [self sendJSON];
    [self.navigationController popToRootViewControllerAnimated:FALSE];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:FALSE];
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
@end

