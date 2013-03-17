//
//  birthdayViewControllerIndiv.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/17/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BirthdayViewControllerIndiv;

@protocol BirthdayViewControllerIndivDelegate <NSObject>
- (void)birthdayViewControllerIndivDidFinish:(BirthdayViewControllerIndiv *)controller;
- (void)dismissPop: (NSDate *)date;
@end


@interface BirthdayViewControllerIndiv : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
- (IBAction)goBack:(id)sender;

@property (weak, nonatomic) id <BirthdayViewControllerIndivDelegate> delegate;

@end