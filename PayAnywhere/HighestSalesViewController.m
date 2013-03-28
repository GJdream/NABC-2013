//
//  HighestSalesViewController.m
//  PayAnywhere
//
//  Created by WEILI GU on 3/27/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "HighestSalesViewController.h"

@interface HighestSalesViewController ()

@end

@implementation HighestSalesViewController

@synthesize salesArray;
@synthesize delegate;
@synthesize salesPicker;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 216.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    salesArray = [[NSMutableArray alloc] init];
    [salesArray addObject:@"Less than $10"];
    [salesArray addObject:@"$10-$20"];
    [salesArray addObject:@"$20-$50"];
    [salesArray addObject:@"$50-$100"];
    [salesArray addObject:@"$100-$250"];
    [salesArray addObject:@"$250-$500"];
    [salesArray addObject:@"More than $500"];
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
    return [salesArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.salesArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [delegate dismissPopHighestSales:[salesArray objectAtIndex:row]];
    
}


@end
