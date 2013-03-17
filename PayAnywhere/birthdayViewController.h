//
//  birthdayViewController.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/16/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BirthdayViewController;

@protocol BirthdayViewControllerDelegate <NSObject>
- (void)birthdayViewControllerDidFinish:(BirthdayViewController *)controller;
- (void)dismissPop: (NSDate *)date;
@end

@interface BirthdayViewController : UIViewController

@property (weak, nonatomic) id <BirthdayViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
- (IBAction)goBack:(id)sender;

@end