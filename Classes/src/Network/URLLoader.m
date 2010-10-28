//
//  URLLoader.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLLoader.h"


@implementation URLLoader

@synthesize connection = connection_;
@synthesize timeoutInterval = timeoutInterval_;
@synthesize data = data_;
@synthesize done = done_;

- (id)init {
	if (self = [super init]) {
		self.connection = [[[URLConnection alloc] init] autorelease];
		self.done = NO;
	}
	return self;
}

- (id)initWithTimeoutInterval:(NSTimeInterval)timeoutInterval {
	if (self = [self init]) {
		self.timeoutInterval = timeoutInterval;
	}
	return self;
}

- (NSURL*)createGETURL:(NSURL*)url get:(NSString*)get {
	NSString* urlStr = [url absoluteString];
	NSString* encGET = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)get, NULL, CFSTR(";,/?:@&=+$#"), kCFStringEncodingUTF8);
	NSString* reqURLStr = [NSString stringWithFormat:@"%@?%@", urlStr, encGET];
	return [NSURL URLWithString:reqURLStr];
}

- (NSData*)sendRequest:(NSMutableURLRequest*)request {
	if (self.timeoutInterval > 0)
		[request setTimeoutInterval:self.timeoutInterval];
	[self.connection createConnection:request];
	while (!self.connection.done)
		[NSThread sleepForTimeInterval:0.5];
	return self.connection.data;
}

- (NSData*)request:(NSURL*)url {
	return [self sendRequest:[NSMutableURLRequest requestWithURL:url]];
}

- (NSData*)request:(NSURL*)url get:(NSString*)get {
	NSURL* requstURL = [self createGETURL:url get:get];
	return [self request:requstURL];
}

- (NSData*)request:(NSURL *)url post:(NSString*)post {
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
	return [self sendRequest:request];
}

- (NSData*)request:(NSURL*)url timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.timeoutInterval = timeoutInterval;
	return [self request:url];
}

- (NSData*)request:(NSURL*)url get:(NSString*)get timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.timeoutInterval = timeoutInterval;
	return [self request:url get:get];
}

- (NSData*)request:(NSURL *)url post:(NSString*)post timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.timeoutInterval = timeoutInterval;
	return [self request:url post:post];
}

- (void)dealloc {
	self.connection = nil;
	self.data = nil;
	[super dealloc];
}

@end
