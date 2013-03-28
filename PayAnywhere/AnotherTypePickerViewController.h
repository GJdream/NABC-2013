//
//  AnotherTypePickerViewController.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/27/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnotherTypePickerViewController;

@protocol AnotherTypePickerViewControllerDelegate <NSObject>

- (void)anotherTypePickerViewControllerDidFinish:(AnotherTypePickerViewController *)controller;
- (void)dismissPopAnotherType: (NSString *)type;

@end

@interface AnotherTypePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *typePicker;
    NSMutableArray *typeArray;
}

@property (weak, nonatomic) id <AnotherTypePickerViewControllerDelegate> delegate;
@property (nonatomic, retain) NSArray *typeArray;
@property (strong, nonatomic) IBOutlet UIPickerView * typePicker;

@end