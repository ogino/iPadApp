//
//  PublicTLViewController.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"
#import "TimeLine.h"


@interface PublicTLViewController : UITableViewController {
@private
	BOOL loaded_;
	TimeLine* timeLine_;
	NSArray* tweets_;
}

@property (nonatomic, assign) BOOL loaded;
@property (nonatomic, retain) TimeLine* timeLine;
@property (nonatomic, retain) NSArray* tweets;

@end
