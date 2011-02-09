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
@synthesize data = data_;

- (id)init {
	if (self = [super init]) {
		self.connection = [[[URLConnection alloc] init] autorelease];
	}
	return self;
}

- (id)initWithTimeoutInterval:(NSTimeInterval)timeoutInterval {
	if (self = [self init]) {
		self.connection.timeoutInterval = timeoutInterval;
	}
	return self;
}

- (NSURL*)createGETURL:(NSURL*)url get:(NSString*)get {
	NSString* urlStr = [url absoluteString];
	NSString* reqURLStr = [NSString stringWithFormat:@"%@?%@", urlStr, get];
	return [NSURL URLWithString:reqURLStr];
}

- (NSData*)sendRequest:(NSMutableURLRequest*)request {
	[request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
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

- (NSData*)request:(NSURL *)url method:(NSString*)method header:(NSString*)header headerField:(NSString*)headerField body:(NSData*)body {
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:method];
	[request setValue:header forHTTPHeaderField:headerField];
    [request setHTTPBody:body];
	return [self sendRequest:request];
}

- (NSData*)request:(NSURL*)url timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.connection.timeoutInterval = timeoutInterval;
	return [self request:url];
}

- (NSData*)request:(NSURL*)url get:(NSString*)get timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.connection.timeoutInterval = timeoutInterval;
	return [self request:url get:get];
}

- (NSData*)request:(NSURL *)url post:(NSString*)post timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.connection.timeoutInterval = timeoutInterval;
	return [self request:url post:post];
}

- (NSData*)request:(NSURL *)url method:(NSString*)method header:(NSString*)header headerField:(NSString*)headerField body:(NSData*)body timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.connection.timeoutInterval = timeoutInterval;
	return [self request:url method:method header:header headerField:headerField body:body];
}


- (void)dealloc {
	self.connection = nil;
	self.data = nil;
	[super dealloc];
}

@end
