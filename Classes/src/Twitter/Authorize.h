//
//  Authorize.h
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Authorize : NSObject {
@private
	NSString* userId_;
	NSString* password_;
	NSString* consumerKey_;
	NSString* consumerSecret_;
	NSString* requestKey_;
	NSString* requestSecret_;
}

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* consumerKey;
@property (nonatomic, copy) NSString* consumerSecret;
@property (nonatomic, copy) NSString* requestKey;
@property (nonatomic, copy) NSString* requestSecret;

- (id)initWithUserInfo:(NSString*)userId password:(NSString*)password;
- (void)createOAuthKeys;

@end
