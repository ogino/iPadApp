//
//  TimeLineViewController.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"
#import "TimeLine.h"
#import "URLLoader.h"
#import "HeaderTrgger.h"


@interface TimeLineViewController : UITableViewController {
@private
	BOOL loaded_;
	TimeLine* timeLine_;
	NSString* url_;
	NSString* userId_;
	NSString* password_;
	NSArray* tweets_;
	HeaderTrgger* trigger_;
	NSMutableArray* images_;
// Field Only
	BOOL triggered;
}

@property (nonatomic, assign) BOOL loaded;
@property (nonatomic, retain) TimeLine* timeLine;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, retain) NSArray* tweets;
@property (nonatomic, retain) HeaderTrgger* trigger;
@property (nonatomic, retain) NSMutableArray* images;

@end
