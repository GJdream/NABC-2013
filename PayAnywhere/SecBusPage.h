//
//  SecBusPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecBusPage  : UIViewController <UIPopoverControllerDelegate, UITextFieldDelegate>
{
}

@property (strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UITextField *corpName;
@property (strong, nonatomic) IBOutlet UITextField *dba;
@property (strong, nonatomic) IBOutlet UITextField *fedTaxId;
@property (strong, nonatomic) IBOutlet UIButton *term;

- (IBAction)weAreA:(id)sender;
    
@end
