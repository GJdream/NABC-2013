//
//  FinishPage.h
//  PayAnywhere
//
//  Created by WEILI GU on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

// awesome Comment

#import <UIKit/UIKit.h>

@interface FinishPage : UIViewController
{
}

@property(strong, nonatomic) NSMutableDictionary * application;

@property (strong, nonatomic) IBOutlet UIButton *radioButtonOne;
- (IBAction)radioButtonOneClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *radioButtonTwo;
- (IBAction)radioButtonTwoClicked:(id)sender;


@end
