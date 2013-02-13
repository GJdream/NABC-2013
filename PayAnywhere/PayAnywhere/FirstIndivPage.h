//
//  FirstIndivPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstIndivPage : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *first;
@property (weak, nonatomic) IBOutlet UITextField *last;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIButton *birth;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *suitapt;
@property (weak, nonatomic) IBOutlet UITextField *zip;
@property (weak, nonatomic) IBOutlet UITextField *ssn;
@property (weak, nonatomic) IBOutlet UITextField *dba;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *term;
@property (weak, nonatomic) IBOutlet UIButton *create;


@end
