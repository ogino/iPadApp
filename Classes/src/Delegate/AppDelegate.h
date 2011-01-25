//
//  AppDelegate.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "RootViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window_;
	RootViewController* rootViewController_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) RootViewController* rootViewController;

@end

