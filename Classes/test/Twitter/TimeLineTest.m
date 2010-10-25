//
//  TimeLineTest.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeLineTest.h"


@implementation TimeLineTest

- (void)setUp {
	timeLine = [[TimeLine alloc] init];
}

- (void) testCreateData {
	timeLine.url = @"http://api.twitter.com/1/statuses/public_timeline.json";
	id tweets = [timeLine createData];
	assertThat(tweets, isNot(nil));
	NSArray* array = (NSArray*)tweets;
	assertThat([NSNumber numberWithInt:[array count]], greaterThan([NSNumber numberWithInt:0]));
	assertThat([NSNumber numberWithInt:[array count]], lessThan([NSNumber numberWithInt:21]));
	assertThat([NSNumber numberWithInt:[array count]], equalTo([NSNumber numberWithInt:20]));
}

- (void) testCreateDataWithGet {
}

- (void) testCreateDataWithPost {
}

- (void)tearDown {
	[timeLine release];
}

@end
