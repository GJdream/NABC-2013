//
//  BusTimeViewController.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/27/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusTimeViewController;

@protocol BusTimeViewControllerDelegate <NSObject>

- (void) busTimeViewControllerDidFinish: (BusTimeViewController *) controller;
- (void) dismissPopBusTime: (NSString *)time;

@end

@interface BusTimeViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource> {
    IBOutlet UIPickerView *timePicker;
    NSMutableArray *timeArray;
}

@property (weak, nonatomic) id <BusTimeViewControllerDelegate> delegate;
@property (nonatomic, retain) NSArray *timeArray;
@property (strong, nonatomic) IBOutlet UIPickerView *timePicker;

@end
