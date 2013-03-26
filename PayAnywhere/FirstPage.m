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
    [super viewDidLoad];
	self.application = [[NSMutableDictionary alloc] init];
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


@end
