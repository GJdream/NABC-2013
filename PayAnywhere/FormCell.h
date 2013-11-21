//
//  FormCell.h
//  PayAnywhere
//
//  Created by newuser on 11/21/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *applicantName;

@property (weak, nonatomic) IBOutlet UILabel *agentName;

@property (weak, nonatomic) IBOutlet UILabel *dateFilled;

@property (weak, nonatomic) IBOutlet UILabel *marketSource;

@end
