//
//  FormsTableViewController.h
//  PayAnywhere
//
//  Created by newuser on 11/21/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "FormCell.h"
#import "IndividualForm.h"
#import "BusinessForm.h"

@interface FormsTableViewController : UITableViewController

@property NSArray *individualForms;
@property NSArray *businessForms;

- (IBAction)deleteSentForms:(id)sender;

@end
