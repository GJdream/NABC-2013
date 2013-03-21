//
//  SecBusPage.m
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "SecBusPage.h"

@interface SecBusPage ()

@end

@implementation SecBusPage

@synthesize typeButton;
@synthesize currentPopoverSeague;
@synthesize pvc;
//@synthesize type;

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

- (IBAction)weAreA:(id)sender {
    
}

//type

- (void)typePickerViewControllerDidFinish:(TypePickerViewController *)controller
{
    [self.typePopoverController dismissPopoverAnimated:YES];
    self.typePopoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.typePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectedType"]) {
        currentPopoverSeague = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
    }
}

- (void)dismissPop:(NSString *)type {
    [typeButton setTitle:type forState:UIControlStateNormal];
    //[[currentPopoverSeague popoverController] dismissPopoverAnimated: YES];
}
@end
