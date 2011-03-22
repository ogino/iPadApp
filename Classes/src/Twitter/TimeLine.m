//
//  TimeLine.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeLine.h"
#import "NSString+Util.h"


@implementation TimeLine

@synthesize url = url_;
@synthesize authorize = authorize_;
@synthesize tweets = tweets_;


#pragma mark -
#pragma mark Privte Methods

- (NSString*)createBodyData:(NSDictionary*)dictionary {
	NSMutableString* getStr = [NSMutableString string];
	for (NSString* key in [dictionary allKeys]) {
		if ([NSString isEmpty:getStr]) [getStr stringByAppendingFormat:@"%@=%@", key, [dictionary objectForKey:key]];
		else [getStr stringByAppendingFormat:@"&%@=%@", key, [dictionary objectForKey:key]];
	}
	return getStr;
}

#pragma mark -
#pragma mark Public Methods

- (id)init:(NSString*)url userId:(NSString*)userId password:(NSString*)password {
	if ([super init] != nil) {
		self.url = url;
		self.authorize = [[[Authorize alloc] initWithUserInfo:userId password:password] autorelease];
	}
	return self;
}

- (id)createData {
	assert(self.url != nil);
	URLLoader* urlLoader = [[[URLLoader alloc] init] autorelease];
	NSData* data = nil;
	if (self.authorize.accessKey) {
		NSData* body = [[NSString stringWithString:@""] dataUsingEncoding:NSUTF8StringEncoding];
		NSString* header = [self.authorize createAuthorizeHeader:[NSURL URLWithString:self.url] method:@"GET" body:body];
		data = [urlLoader request:[NSURL URLWithString:self.url]
						   header:header headerField:@"Authorization" get:@""];
	} else {
		data = [urlLoader request:[NSURL URLWithString:self.url] timeoutInterval:60];
	}
	NSString* json = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	return ([NSString isEmpty:json]) ? nil : [json JSONValue];
}

- (id)createDataWithGet:(NSDictionary*)getDic {
	assert(self.url != nil);
	URLLoader* urlLoader = [[[URLLoader alloc] init] autorelease];
	NSData* data = [urlLoader request:[NSURL URLWithString:self.url] get:[self createBodyData:getDic] timeoutInterval:60];
	NSString* json = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	return ([NSString isEmpty:json]) ? nil : [json JSONValue];
}

- (id)createDataWithPost:(NSDictionary*)postDic {
	assert(self.url != nil);
	return nil;
}

- (void)dealloc {
	self.url = nil;
	self.authorize = nil;
	self.tweets = nil;
	[super dealloc];
}

@end
