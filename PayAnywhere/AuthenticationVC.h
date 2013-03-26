//
//  AuthenticationVC.h
//  PayAnywhere
//
//  Created by Jorge Viramontes on 3/20/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuthenticationVC;
@protocol AuthenticationDelegate <NSObject>

@required
-(void)authenticated;

@end

@interface AuthenticationVC : UIViewController

@property (strong, nonatomic) id<AuthenticationDelegate> delegate;

@property(strong, nonatomic) UIPopoverController * popover;
@property (strong, nonatomic) IBOutlet UITextField *passcode;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

- (IBAction)authenticate:(id)sender;

@end
