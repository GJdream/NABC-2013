//
//  TypePickerViewController.m
//  PayAnywhere
//
//  Created by WEILI GU on 3/20/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "TypePickerViewController.h"

@interface TypePickerViewController ()

@end

@implementation TypePickerViewController

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
    [typeArray addObject:@"Sole Proprietor"];
    [typeArray addObject:@"Corporation"];
    [typeArray addObject:@"Partnership"];
    [typeArray addObject:@"Non-Profit"];
    [typeArray addObject:@"LLC"];
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