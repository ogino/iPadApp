//
//  TimeLine.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeLine.h"


@implementation TimeLine

@synthesize url = url_;
@synthesize userId = userId_;
@synthesize password = password_;
@synthesize gets = gets_;
@synthesize posts = posts_;
@synthesize tweets = tweets_;

- (id)init:(NSString*)url userId:(NSString*)userId password:(NSString*)password {
	if ([super init] != nil) {
		self.url = url;
		self.userId = userId;
		self.password = password;
	}
	return self;
}

- (id)createData {
	assert(self.url != nil);
	URLLoader* urlLoader = [[[URLLoader alloc] init] autorelease];
	[urlLoader request:[NSURL URLWithString:self.url]];
	while (!urlLoader.done)
		[NSThread sleepForTimeInterval:0.5];
	NSData* data = urlLoader.data;
	NSString* json = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	return [json JSONValue];
}

- (id)createDataWithGet:(NSDictionary*) gets {
	assert(self.gets != nil);
	return nil;
}

- (id)createDataWithPost:(NSDictionary*) osts {
	assert(self.posts != nil);
	return nil;
}

- (void)dealloc {
	self.gets = nil;
	self.posts = nil;
	self.tweets = nil;
	[super dealloc];
}

@end
