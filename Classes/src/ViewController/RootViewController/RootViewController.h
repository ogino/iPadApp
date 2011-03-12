//
//  RootViewController.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/12/07.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"


@interface RootViewController : UIViewController {
@private
	TabBarController* tabBarController_;
}

@property (nonatomic, retain) TabBarController* tabBarController;

@end
