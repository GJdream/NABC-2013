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
    
    self.corpName.delegate = self;
    self.dba.delegate = self;
    self.fedTaxId.delegate = self;
 
    NSLog(@"Application: %@", self.application);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.corpName becomeFirstResponder];
    }
    else if(textField.tag == 2){
        [self.dba becomeFirstResponder];
    }
    else if (textField.tag == 4){
        [self.fedTaxId becomeFirstResponder];
    }
    else if (textField.tag == 5){
        [self.term becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
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

- (IBAction)weAreA:(id)sender {
    
}
@end
