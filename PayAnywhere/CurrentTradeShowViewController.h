//
//  CurrentTradeShowViewController.h
//  PayAnywhere
//
//  Created by newuser on 11/26/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionViewController.h"
#import "Agent.h"
#import "MarketSource.h"

@interface CurrentTradeShowViewController : UITableViewController <SelectionDelegate>

@property (strong, nonatomic) NSArray *agents;
@property (strong, nonatomic) MarketSource *currentTradeshow;

@property (weak, nonatomic) IBOutlet UILabel *tradeshowLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentsLabel;

- (IBAction)startTradeshow:(id)sender;
@end
