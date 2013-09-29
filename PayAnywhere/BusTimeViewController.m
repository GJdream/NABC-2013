//
//  BusTimeViewController.m
//  PayAnywhere
//
//  Created by WEILI GU on 3/27/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "BusTimeViewController.h"

@interface BusTimeViewController ()

@end

@implementation BusTimeViewController

@synthesize timeArray;
@synthesize delegate;
@synthesize timePicker;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 216.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    timeArray = [[NSMutableArray alloc] init];
    [timeArray addObject:@"Less than 6 Months"];
    [timeArray addObject:@"1 Year"];
    [timeArray addObject:@"2 Years"];
    [timeArray addObject:@"3 Years"];
    [timeArray addObject:@"4 Years"];
    [timeArray addObject:@"5 Years"];
    [timeArray addObject:@"10 Years"];
    [timeArray addObject:@"20 Years"];
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
    return [timeArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.timeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [delegate dismissPopBusTime:[timeArray objectAtIndex:row]];
    
}

@end
