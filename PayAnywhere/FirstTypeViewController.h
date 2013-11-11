//
//  FirstTypeViewController.h
//  PayAnywhere
//
//  Created by Nathan Shields on 11/11/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstTypeViewController;

@protocol FirstTypeViewControllerDelegate <NSObject>

- (void)typePickerViewControllerDidFinish:(FirstTypeViewController *)controller;
- (void)dismissPopTypePicker: (NSString *)type;

@end

@interface FirstTypeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *firstTypePicker;
    NSMutableArray *typeArray;
}

@property (weak, nonatomic) id <FirstTypeViewControllerDelegate> delegate;
@property (nonatomic,retain) NSArray *typeArray;
@property (strong, nonatomic) IBOutlet UIPickerView *firstTypePicker;


@end