//
//  Authorize.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Authorize.h"
#import "NSArray+Util.h"
#import "NSString+Util.h"
#import "URLLoader.h"
#import "OAuthCore.h"

@implementation Authorize

@synthesize userId = userId_;
@synthesize password = password_;
@synthesize consumerKey = consumerKey_;
@synthesize consumerSecret = consumerSecret_;
@synthesize requestKey = requestKey_;
@synthesize requestSecret = requestSecret_;


#pragma mark -
#pragma mark Definitions

#define CONSUMER_KEY @"4hYBQ1JJ7m05xC5wcKtA"
#define CONSUMER_SECRET @"5QsyXcfJaE9B0KEe2QV9d7xjUT3NlbIcaXvuf9LIs0Y"

#define REQUEST_API @"https://api.twitter.com/oauth/request_token"
#define ACCESS_TOKEN_API @"https://api.twitter.com/oauth/access_token"
#define AUTHORIZE_API @"https://api.twitter.com/oauth/authorize"

#define REGEX_TOKEN @"^oauth_token="
#define REGEX_SECRET @"^oauth_token_secret="

#pragma mark -
#pragma mark Private Methods

- (NSString*)createFixValue:(NSString*)rawStr remove:(NSString*)pattern {
	NSError* error = nil;
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
	NSArray* matches = [regex matchesInString:rawStr options:NSMatchingCompleted range:NSMakeRange(0, rawStr.length)];
	if (![NSArray isEmpty:matches]) return [rawStr stringByReplacingOccurrencesOfString:pattern withString:@""];
	return nil;
}

- (void)createRequestKeys:(NSString*)rawStr {
	NSArray* rawKeys = [rawStr componentsSeparatedByString:@"&"];
	for (NSString* rawKey in rawKeys) {
		if ([NSString isEmpty:self.requestKey]) self.requestKey = [self createFixValue:rawKey remove:REGEX_TOKEN];
		if ([NSString isEmpty:self.requestSecret]) self.requestSecret = [self createFixValue:rawKey remove:REGEX_SECRET];
	}
}


#pragma mark -
#pragma mark Public_Methods

- (id)initWithUserInfo:(NSString*)userId password:(NSString*)password {
	if (self = [self init]) {
		self.userId = userId;
		self.password = password;
	}
	return self;
}

#define GET_METHOD @"GET"

- (void)createOAuthKeys {
	NSURL* url = [NSURL URLWithString:REQUEST_API];
	NSData* body = [[NSString stringWithString:@""] dataUsingEncoding:NSUTF8StringEncoding];
	NSString* method = GET_METHOD;
	NSString* header = OAuthorizationHeader(url, method, body, self.consumerKey, self.consumerSecret, self.requestKey, self.requestSecret, YES);
	URLLoader* urlLoader = [[[URLLoader alloc] init] autorelease];
	NSData* data = [urlLoader request:url method:method header:header headerField:@"Authorization" body:body];
	[self createRequestKeys:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]];
}


#pragma mark -
#pragma mark Inherit Methods

- (id)init {
	if (self = [super init]) {
		self.consumerKey = CONSUMER_KEY;
		self.consumerSecret = CONSUMER_SECRET;
		self.requestKey = nil;
		self.requestSecret = nil;
	}
	return self;
}

- (void)dealloc {
	self.userId = nil;
	self.password = nil;
	self.consumerKey = nil;
	self.consumerSecret = nil;
	self.requestKey = nil;
	self.requestSecret = nil;
	[super dealloc];
}

@end
