//
//  MarketSourceCell.h
//  PayAnywhere
//
//  Created by newuser on 11/12/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketSourceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *numAgentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFormsLabel;

@end
