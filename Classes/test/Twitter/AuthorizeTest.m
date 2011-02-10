//
//  AuthorizeTest.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthorizeTest.h"
#import "URLLoader.h"


@implementation AuthorizeTest

- (void) createURLLoader {
	urlLoader = [OCMockObject mockForClass:[URLLoader class]];
	NSData* data = [@"oauth_token=TOKEN&oauth_token_secret=SECRET" dataUsingEncoding:NSUTF8StringEncoding];
	[[[urlLoader expect] andReturn:data]request:[OCMArg any] method:[OCMArg any] header:[OCMArg any] headerField:[OCMArg any] body:[OCMArg any]];
}

- (void)setUp {
	authorize = [[Authorize alloc] init];
	[self createURLLoader];
	authorize.urlLoader = urlLoader;

}

- (void)tearDown {
	[authorize release];
	urlLoader = nil;
}

- (void)testCreateOAuthRequestKeys {
	[authorize createOAuthRequestKeys];
	assertThat(authorize.requestKey, notNilValue());
	assertThat([NSNumber numberWithInt:authorize.requestKey.length], greaterThan([NSNumber numberWithInt:0]));
	assertThat(authorize.requestSecret, notNilValue());
	assertThat([NSNumber numberWithInt:authorize.requestSecret.length], greaterThan([NSNumber numberWithInt:0]));
	NSLog(@"authorize.requestKey = %@", authorize.requestKey);
	NSLog(@"authorize.requestSecret = %@", authorize.requestSecret);
}

- (void)testCreateOAuthAccessKeys {
	authorize.requestKey = @"REQUEST_KEY";
	authorize.requestSecret = @"REQUEST_SECRET";
	authorize.pinCode = @"123456";
	[authorize createOAuthAccessKeys];
	assertThat(authorize.accessKey, notNilValue());
	assertThat([NSNumber numberWithInt:authorize.accessKey.length], greaterThan([NSNumber numberWithInt:0]));
	assertThat(authorize.accessSecret, notNilValue());
	assertThat([NSNumber numberWithInt:authorize.accessSecret.length], greaterThan([NSNumber numberWithInt:0]));
	NSLog(@"authorize.accessKey = %@", authorize.accessKey);
	NSLog(@"authorize.accessSecret = %@", authorize.accessSecret);
}


@end
