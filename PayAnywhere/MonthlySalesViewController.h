//
//  MonthlySalesViewController.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/27/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthlySalesViewController;

@protocol MonthlySalesViewControllerDelegate <NSObject>

- (void)monthlySalesViewControllerDidFinish:(MonthlySalesViewController *)controller;
- (void)dismissPopMonthlySales: (NSString *)sales;

@end

@interface MonthlySalesViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *salesPicker;
    NSMutableArray *salesArray;
}

@property (weak, nonatomic) id <MonthlySalesViewControllerDelegate> delegate;
@property (nonatomic, retain) NSArray *salesArray;
@property (strong, nonatomic) IBOutlet UIPickerView *salesPicker;

@end
