//
//  AgentCell.m
//  PayAnywhere
//
//  Created by newuser on 11/5/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "AgentCell.h"

@implementation AgentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changePIN:(id)sender {
}
@end
