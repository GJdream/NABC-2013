//
//  TypePickerViewController.h
//  PayAnywhere
//
//  Created by WEILI GU on 3/20/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TypePickerViewController;

@protocol TypePickerViewControllerDelegate <NSObject>

- (void)typePickerViewControllerDidFinish:(TypePickerViewController *)controller;
- (void)dismissPop: (NSString *)type;

@end

@interface TypePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    IBOutlet UIPickerView *typePicker;
    NSMutableArray *typeArray;
}

@property (weak, nonatomic) id <TypePickerViewControllerDelegate> delegate;
@property (nonatomic,retain) NSArray *typeArray;
@property (strong, nonatomic) IBOutlet UIPickerView *typePicker;


@end
