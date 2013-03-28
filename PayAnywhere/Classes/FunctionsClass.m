//
//  FunctionsClass.m
//  PayAnywhere
//
//  Created by Nathan Shields on 3/26/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FunctionsClass.h"

@implementation FunctionsClass

-(void)toggleCheckbox:(UIButton*) box boolInt:(NSNumber*)shouldBeChecked{
    if(shouldBeChecked){
            [box setImage:[UIImage imageNamed:@"checkboxSelected.png"] forState:UIControlStateNormal];
    }
    else{
            [box setImage:[UIImage imageNamed:@"checkboxUnselected.png"] forState:UIControlStateNormal];
    }
        
    
    
}

@end

