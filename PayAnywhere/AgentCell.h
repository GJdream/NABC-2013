//
//  AgentCell.h
//  PayAnywhere
//
//  Created by newuser on 11/5/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *aid;

@property (weak, nonatomic) IBOutlet UILabel *formsFilled;

- (IBAction)changePIN:(id)sender;
@end
