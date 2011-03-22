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
@synthesize pinCode = pinCode_;
@synthesize accessKey = accessKey_;
@synthesize accessSecret = accessSecret_;
@synthesize urlLoader = urlLoader_;


#pragma mark -
#pragma mark Definitions

#define CONSUMER_KEY @"IqDgaCswPLJL1CzUmJc6Ow"
#define CONSUMER_SECRET @"Gls4JQhMshp1FuI4ExqSbsUELulGWCoHiXI0fZVc8"

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
	if (![NSArray isEmpty:matches])  {
		return [regex stringByReplacingMatchesInString:rawStr options:NSMatchingCompleted range:NSMakeRange(0, rawStr.length) withTemplate:@""];
	}
	return nil;
}

- (void)createRequestKeys:(NSString*)rawStr {
	NSArray* rawKeys = [rawStr componentsSeparatedByString:@"&"];
	for (NSString* rawKey in rawKeys) {
		if ([NSString isEmpty:self.requestKey]) self.requestKey = [self createFixValue:rawKey remove:REGEX_TOKEN];
		if ([NSString isEmpty:self.requestSecret]) self.requestSecret = [self createFixValue:rawKey remove:REGEX_SECRET];
	}
}

- (void)createAccessKeys:(NSString*)rawStr {
	NSArray* rawKeys = [rawStr componentsSeparatedByString:@"&"];
	for (NSString* rawKey in rawKeys) {
		if ([NSString isEmpty:self.accessKey]) self.accessKey = [self createFixValue:rawKey remove:REGEX_TOKEN];
		if ([NSString isEmpty:self.accessSecret]) self.accessSecret = [self createFixValue:rawKey remove:REGEX_SECRET];
	}
}

#define GET_METHOD @"GET"

- (NSData*)createOAuthKeys:(NSURL*)url header:(NSString*)header {
	NSData* body = [[NSString stringWithString:@""] dataUsingEncoding:NSUTF8StringEncoding];
	NSString* method = GET_METHOD;
	return [self.urlLoader request:url method:method header:header headerField:@"Authorization" body:body];
}


#pragma mark -
#pragma mark Public_Methods

- (id)initWithUserInfo:(NSString*)userId password:(NSString*)password {
	if ((self = [self init])) {
		self.userId = userId;
		self.password = password;
	}
	return self;
}

- (void)createOAuthRequestKeys {
	NSURL* url = [NSURL URLWithString:REQUEST_API];
	NSData* body = [[NSString stringWithString:@""] dataUsingEncoding:NSUTF8StringEncoding];
	NSString* method = GET_METHOD;
	NSData* data = [self createOAuthKeys:url header:OAuthRequestHeader(url, method, body, self.consumerKey, self.consumerSecret)];
	[self createRequestKeys:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]];
}


- (void)createOAuthAccessKeys {
	NSURL* url = [NSURL URLWithString:ACCESS_TOKEN_API];
	NSData* body = [[NSString stringWithString:@""] dataUsingEncoding:NSUTF8StringEncoding];
	NSString* method = GET_METHOD;
	NSData* data = [self createOAuthKeys:url header:OAuthAccessHeader(url, method, body, self.consumerKey, self.consumerSecret, self.requestKey, self.requestSecret, self.pinCode)];
	[self createAccessKeys:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]];
}

- (NSString*)createAuthorizeHeader:(NSURL*)url method:(NSString*)method body:(NSData*)body {
	return OAuthorizationHeader(url, method, body, self.consumerKey, self.consumerSecret, self.accessKey, self.accessSecret);
}


#pragma mark -
#pragma mark Inherit Methods

#define OAUTH_KEY @""
#define OAUTH_SECRET @""

- (id)init {
	if ((self = [super init])) {
		self.consumerKey = CONSUMER_KEY;
		self.consumerSecret = CONSUMER_SECRET;
		self.requestKey = nil;
		self.requestSecret = nil;
		self.accessKey = OAUTH_KEY;
		self.accessSecret = OAUTH_SECRET;
		self.urlLoader = [[[URLLoader alloc] init] autorelease];
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
	self.pinCode = nil;
	self.accessKey = nil;
	self.accessSecret = nil;
	self.urlLoader = nil;
	[super dealloc];
}

@end
