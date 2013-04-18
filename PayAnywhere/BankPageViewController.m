//
//  BankPageViewController.m
//  PayAnywhere
//
//  Created by Nathan Shields on 4/6/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "BankPageViewController.h"
#import "FinishPage.h"

@interface BankPageViewController ()

@end

@implementation BankPageViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterInfo:(id)sender {
    BOOL accountNum = [self.accountNumberField.text length];
    BOOL routingNum = [self.routingNumField.text length];
    NSMutableString * alertMessageMutable = [[NSMutableString alloc] init];

    

    if(accountNum && routingNum){
        [self.application setValue:self.accountNumberField.text forKey:@"Bank Account Number"];
        [self.application setValue:self.routingNumField.text forKey:@"ACH/Routing Number"];
    
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


//SEGUES
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"performing bankToFinsh\n");
    if ([segue.identifier isEqualToString:@"BankToFinishSegue"]) {
        
        FinishPage * finPage = segue.destinationViewController;
        finPage.application = self.application;
    }
    
    
    
}

@end
