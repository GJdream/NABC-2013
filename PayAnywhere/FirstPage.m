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
    NSNull * nullObj = [NSNull null];
    
    [super viewDidLoad];
	self.application = [[NSMutableDictionary alloc] init];
    
    [self.application setObject:nullObj forKey:@"First Name"];
    [self.application setObject:nullObj forKey:@"Last Name"];
    [self.application setObject:nullObj forKey:@"Email Address"];
    [self.application setObject:nullObj forKey:@"Phone Number"];
    [self.application setObject:nullObj forKey:@"Residential Address"];
    [self.application setObject:nullObj forKey:@"Suite/Apartment"];
    [self.application setObject:nullObj forKey:@"City"];
    [self.application setObject:nullObj forKey:@"State"];
    [self.application setObject:nullObj forKey:@"Zip Code"];
    [self.application setObject:nullObj forKey:@"SSN"];
    [self.application setObject:nullObj forKey:@"DBA"];
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
    }
    else if ([segue.identifier isEqualToString:@"FirstBusinessSegue"])
    {
        [self.application setObject:@"business" forKey:@"Application Type"];
        FirstBusPage * busPage = segue.destinationViewController;
        busPage.application = self.application;
    }
  
}

- (IBAction)business:(id)sender {
    [self performSegueWithIdentifier:@"FirstIndividualSegue" sender:nil];
}

- (IBAction)individual:(id)sender {
    [self performSegueWithIdentifier:@"FirstBusinessSegue" sender:nil];

}


@end
