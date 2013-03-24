//
//  AnotherTypePickerViewController.m
//  PayAnywhere
//
//  Created by WEILI GU on 3/20/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//


#import "AnotherTypePickerViewController.h"

@interface AnotherTypePickerViewController ()

@end

@implementation AnotherTypePickerViewController

@synthesize typeArray;
@synthesize delegate;
@synthesize typePicker;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 216.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    typeArray = [[NSMutableArray alloc] init];
    [typeArray addObject:@"Art Dealer and Gallery"];
    [typeArray addObject:@"Automotive Parts"];
    [typeArray addObject:@"Bakery"];
    [typeArray addObject:@"Barber/Beauty Salon"];
    [typeArray addObject:@"Books/Articles/Magazines"];
    [typeArray addObject:@"Catering"];
    [typeArray addObject:@"Charitable Organizations"];
    [typeArray addObject:@"Child Care Services"];
    [typeArray addObject:@"Cleaning Services"];
    [typeArray addObject:@"Clothing and Accessories"];
    [typeArray addObject:@"Dry Cleaning Services"];
    [typeArray addObject:@"Electrical Contractor"];
    [typeArray addObject:@"Florist"];
    [typeArray addObject:@"Heating and Cooling Services"];
    [typeArray addObject:@"Landscaping Services"];
    [typeArray addObject:@"Person to Person Sales"];
    [typeArray addObject:@"Photography"];
    [typeArray addObject:@"Retail Store"];
    [typeArray addObject:@"Restaurant"];
    [typeArray addObject:@"Taxi and Limousine Services"];
    [typeArray addObject:@"Other"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [typeArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.typeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [delegate dismissPop:[typeArray objectAtIndex:row]];
    
}
@end
