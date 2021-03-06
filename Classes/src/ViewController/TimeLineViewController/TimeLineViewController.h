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


@interface TimeLineViewController : UITableViewController<UIPopoverControllerDelegate> {
@private
	BOOL loaded_;
	BOOL triggered_;
	TimeLine* timeLine_;
	NSString* url_;
	NSString* userId_;
	NSString* password_;
	NSArray* tweets_;
	HeaderTrgger* trigger_;
	NSMutableArray* images_;
	UIPopoverController* popOverController_;
// Field Only
	
	NSMutableArray* tweetBuff;
}

@property (nonatomic, assign) BOOL loaded;
@property (nonatomic, assign) BOOL triggered;
@property (nonatomic, retain) TimeLine* timeLine;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, retain) NSArray* tweets;
@property (nonatomic, retain) HeaderTrgger* trigger;
@property (nonatomic, retain) NSMutableArray* images;
@property (nonatomic, retain) UIPopoverController* popOverController;

@end
