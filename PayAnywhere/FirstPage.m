//
//  FirstPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FirstPage.h"
#import "FirstBusPage.h"
#import "FirstIndivPage.h"

@interface FirstPage ()

@end

@implementation FirstPage

//@synthesize popover;
//@synthesize delegate;

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
	self.application = [NSMutableDictionary dictionary];
    
    [self.application setObject:nullObj forKey:@"firstName"];
    [self.application setObject:nullObj forKey:@"lastName"];
    [self.application setObject:nullObj forKey:@"email"];
    [self.application setObject:nullObj forKey:@"phoneNumber"];
    [self.application setObject:nullObj forKey:@"address"];
    [self.application setObject:nullObj forKey:@"suiteApt"];
    [self.application setObject:nullObj forKey:@"city"];
    [self.application setObject:nullObj forKey:@"state"];
    [self.application setObject:nullObj forKey:@"zipCode"];
    [self.application setObject:nullObj forKey:@"ssn"];
    [self.application setObject:nullObj forKey:@"dba"];
    [self.application setObject:nullObj forKey:@"Business Type"];
    [self.application setObject:nullObj forKey:@"Business Description"];
    [self.application setObject:nullObj forKey:@"Corporation Name"];
    [self.application setObject:nullObj forKey:@"Federal Tax ID"];
    [self.application setObject:nullObj forKey:@"Business Address"];
    [self.application setObject:nullObj forKey:@"Business Suite/Apartment"];
    [self.application setObject:nullObj forKey:@"Business Zip Code"];
    [self.application setObject:nullObj forKey:@"Highest Sales Amount"];
    [self.application setObject:nullObj forKey:@"Total Monthly CC Sales"];
    [self.application setObject:nullObj forKey:@"Been In Business For"];
    
    SignupAnywhereDB * db = [[SignupAnywhereDB alloc] init];
    [db loadTradeshows];
    
    TradeShow * ts = [[TradeShow alloc] init];
    ts = [db.tradeshows objectForKey:@"TS1"];
    [ts printApplicants];
    
    /*
    TradeShow * ts1 = [[TradeShow alloc] init];
    TradeShow * ts2 = [[TradeShow alloc] init];
    NSMutableDictionary * app1 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * app2 = [[NSMutableDictionary alloc] init];
    
    ts1.name = @"TS1";
    ts1.city = @"Chicago";
    ts1.state =@"Illinois";
    ts2.name = @"TS2";
    ts2.city = @"Las Vegas";
    ts2.state = @"Nevada";
    
    [app1 setObject:@"Jorge" forKey:@"First Name"];
    [app1 setObject:@"Viramontes" forKey:@"Last Name"];
    [app1 setObject:@"jmontes@umich.edu" forKey:@"Email Address"];
    [app1 setObject:@"7733161708" forKey:@"Phone Number"];
    [app1 setObject:ts1 forKey:@"Tradeshow"];
    
    [app2 setObject:@"Nathan" forKey:@"First Name"];
    [app2 setObject:@"Shields" forKey:@"Last Name"];
    [app2 setObject:@"nshields@umich.edu" forKey:@"Email Address"];
    [app2 setObject:@"7733734545" forKey:@"Phone Number"];
    [app2 setObject:ts1 forKey:@"Tradeshow"];
    
    [ts1.applications addObject:app1];
    [ts1 printApplicants];
    [ts1.applications addObject:app2];
    [ts1 printApplicants];
    
    [db addNewTradeshow:ts1];
    [db printTradeshows];
    [db addNewApplication:app1];
    ts1 = [db.tradeshows objectForKey:@"TS1"];
    [ts1 printApplicants];
*/
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FirstIndividualSegue"])
    {
        [self.application setObject:@"individual" forKey:@"Application Type"];
        FirstIndivPage * indivPage = segue.destinationViewController;
        indivPage.application = self.application;
        indivPage->fromWhichBusPage = 1;
//        indivPage->termsAccepted = 0;
    }
    else if ([segue.identifier isEqualToString:@"FirstBusinessSegue"])
    {
        [self.application setObject:@"business" forKey:@"Application Type"];
        FirstBusPage * busPage = segue.destinationViewController;
        busPage.application = self.application;
//        busPage->termsAccepted = 0;
    }
  
}


- (IBAction)business:(id)sender {
    [self performSegueWithIdentifier:@"FirstIndividualSegue" sender:nil];
}

- (IBAction)individual:(id)sender {
    [self performSegueWithIdentifier:@"FirstBusinessSegue" sender:nil];

}

/*
- (IBAction)settings:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];

    AuthenticationVC * authentication = (AuthenticationVC *)[sb instantiateViewControllerWithIdentifier:@"AuthenticationVC"];
    
    self.popover = [[UIPopoverController alloc]
                                     initWithContentViewController:authentication];
    self.popover.delegate = self;
    
    authentication.popover = self.popover;
    authentication.delegate = self;
    
    [self.popover presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)authenticated
{
    [self.popover dismissPopoverAnimated:YES];
    [self.navigationController.splitViewController performSegueWithIdentifier:@"AgentDetailSegue" sender:nil];
}

- (void) authenticationVCDidFinish:(AuthenticationVC *)controller
{
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
*/
- (void)dismissPopAuthentication
{
    //[delegate dismissFirstPage];
    //TradeShowAgentHomeViewController * master = [[self.splitViewController viewControllers] objectAtIndex:0];
    
    //master.tradeShowMode = NO;
    //[self.application setObject:type forKey:@"Business Area"];
    //[anotherTypeButton setTitle:type forState:UIControlStateNormal];
}


@end
