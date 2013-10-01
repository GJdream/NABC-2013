//
//  BankPageViewController.m
//  PayAnywhere
//
//  Created by Nathan Shields on 9/28/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "BankPageViewController.h"

@interface BankPageViewController ()

@end

@implementation BankPageViewController

//NEED TO PASS DICTIONARY!!!

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
	// Do any additional setup after loading the view.
           NSLog(@"Bank page application dictionary: %@", self.application);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BankToFinishSegue"]){
    FinishPage * finishPage = segue.destinationViewController;
    finishPage.application = self.application;
    }
}


- (IBAction)enterInfo:(id)sender {
    BOOL accountNum = [self.accountNumberField.text length];
    BOOL routingNum = [self.routingNumberField.text length];
    NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];
    
    

    if(accountNum && routingNum){
        [self.application setValue:self.accountNumberField.text forKey:@"Bank Account Number"];
        [self.application setValue:self.routingNumberField.text forKey:@"ACH/Routing Number"];
        
        [self performSegueWithIdentifier:@"BankToFinishSegue" sender:nil];
    }
    
    else{
        if(!accountNum){
            [alertMessageMutable appendString:@"Routing Number, "];
        }
        if (!routingNum) {
            [alertMessageMutable appendString:@"Account Number, "];
        }
        if([alertMessageMutable length]){
            NSRange range = NSMakeRange([alertMessageMutable length]-2, 1);
            [alertMessageMutable deleteCharactersInRange: range];
        }
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing:"
                                                          message:alertMessageMutable
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
    }
 

}

- (IBAction)skipInfo:(id)sender {
    [self performSegueWithIdentifier:@"BankToFinishSegue" sender:nil];
}
@end
