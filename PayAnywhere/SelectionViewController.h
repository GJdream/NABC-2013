//
//  SelectionViewController.h
//  PayAnywhere
//
//  Created by newuser on 11/26/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "TradeShow.h"
#import "Agent.h"

enum SelectionType {
    SelectionTypeAgents = 0,
    SelectionTypeTradeshow = 1,
    SelectionTypeTradeshowMode = 2
    };

@protocol SelectionDelegate <NSObject>

-(void)didSelectAgents:(NSArray *)selectedAgents;
-(void)didSelectTradeshow:(TradeShow *)tradeshow;
-(void)didStartCurrentTradeshow;
-(void)didStopCurrentTradeshow;

@end

@interface SelectionViewController : UITableViewController

@property id<SelectionDelegate> delegate;

@property (strong, nonatomic) NSArray *agentsArray;
@property (strong, nonatomic) NSArray *tradeshowsArray;

@property (strong, nonatomic) NSMutableArray *selectedAgents;
@property (strong, nonatomic) TradeShow *selectedTradeshow;

@property enum SelectionType selectionType;

- (IBAction)doneButton:(id)sender;

- (IBAction)cancelButton:(id)sender;

@end
