//
//  HighestSalesViewController.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/27/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HighestSalesViewController;

@protocol HighestSalesViewControllerDelegate <NSObject>

- (void) highestSalesViewControllerDidFinish:(HighestSalesViewController *)controller;
- (void) dismissPopHighestSales: (NSString *)sales;

@end

@interface HighestSalesViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *salesPicker;
    NSMutableArray *salesArray;
}

@property (weak, nonatomic) id <HighestSalesViewControllerDelegate> delegate;
@property (nonatomic, retain) NSArray *salesArray;
@property (strong, nonatomic) IBOutlet UIPickerView *salesPicker;

@end
