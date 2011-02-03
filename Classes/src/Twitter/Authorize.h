//
//  Authorize.h
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAConsumer.h"
#import "OAToken.h"


@interface Authorize : NSObject {
@private
	OAConsumer* consumer_;
	OAToken* token_;
	NSString* userId_;
	NSString* password_;
}

@property (nonatomic, retain) OAConsumer* consumer;
@property (nonatomic, retain) OAToken* token;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* password;

- (id)initWithUserInfo:(NSString*)userId password:(NSString*)password;
- (void)createOAuthKeys;

@end
