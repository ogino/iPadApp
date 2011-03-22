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

#pragma mark -
#pragma mark Private Methods

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

- (NSMutableURLRequest*)createURLRequest:(NSURL*)url method:(NSString*)method header:(NSString*)header headerField:(NSString*)headerField body:(NSData*)body {
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	if (![NSString isEmpty:method]) [request setHTTPMethod:method];
	if (![NSString isEmpty:header] && ![NSString isEmpty:headerField]) [request setValue:header forHTTPHeaderField:headerField];
	if (![NSData isEmpty:body]) [request setHTTPBody:body];
	return request;
}

#pragma mark -
#pragma mark Public Methods

- (id)init {
	if ((self = [super init])) {
		self.connection = [[[URLConnection alloc] init] autorelease];
	}
	return self;
}

- (id)initWithTimeoutInterval:(NSTimeInterval)timeoutInterval {
	if ((self = [self init])) {
		self.connection.timeoutInterval = timeoutInterval;
	}
	return self;
}

- (NSData*)request:(NSURL*)url {
	return [self sendRequest:[NSMutableURLRequest requestWithURL:url]];
}

- (NSData*)request:(NSURL*)url get:(NSString*)get {
	return [self request:[self createGETURL:url get:get]];
}

- (NSData*)request:(NSURL*)url post:(NSString*)post {
	return [self sendRequest:[self createURLRequest:url method:@"POST" header:nil headerField:nil body:[post dataUsingEncoding:NSUTF8StringEncoding]]];
}

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField get:(NSString*)get {
	return [self sendRequest:[self createURLRequest:[self createGETURL:url get:get] method:@"GET" header:header headerField:headerField body:nil]];
}

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField post:(NSString*)post {
	return [self sendRequest:[self createURLRequest:url method:@"POST" header:header headerField:headerField body:[post dataUsingEncoding:NSUTF8StringEncoding]]];
}

- (NSData*)request:(NSURL*)url method:(NSString*)method header:(NSString*)header headerField:(NSString*)headerField body:(NSData*)body {
	return [self sendRequest:[self createURLRequest:url method:method header:header headerField:headerField body:body]];
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

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField get:(NSString*)get timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.connection.timeoutInterval = timeoutInterval;
	return [self request:url header:header headerField:headerField get:get];
}

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField post:(NSString*)post timeoutInterval:(NSTimeInterval)timeoutInterval {
	self.connection.timeoutInterval = timeoutInterval;
	return [self request:url header:header headerField:headerField post:post];
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
