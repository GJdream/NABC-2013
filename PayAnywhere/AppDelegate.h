//
//  AppDelegate.h
//  PayAnywhere
//
//  Created by Jorge Viramontes on 2/13/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionUploadTask *uploadTask;

@end