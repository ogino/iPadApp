//
//  TimeLine.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "URLLoader.h"


@interface TimeLine : NSObject {
@private
	NSString* url_;
	NSString* userId_;
	NSString* password_;
	NSDictionary* gets_;
	NSDictionary* posts_;
	NSDictionary* tweets_;
}

@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, retain) NSDictionary* gets;
@property (nonatomic, retain) NSDictionary* posts;
@property (nonatomic, retain) NSDictionary* tweets;

- (id) init:(NSString*) url userId:(NSString*) userId password:(NSString*) password;

- (id) createData;

- (id) createDataWithGet:(NSDictionary*) gets;

- (id) createDataWithPost:(NSDictionary*) posts;

@end
