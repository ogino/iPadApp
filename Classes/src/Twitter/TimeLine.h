//
//  TimeLine.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Authorize.h"
#import "Categories.h"
#import "JSON.h"
#import "URLLoader.h"


@interface TimeLine : NSObject {
@private
	NSString* url_;
	Authorize* authorize_;
	NSDictionary* tweets_;
}

@property (nonatomic, copy) NSString* url;
@property (nonatomic, retain) Authorize* authorize;
@property (nonatomic, retain) NSDictionary* tweets;

- (id)init:(NSString*)url userId:(NSString*)userId password:(NSString*)password;

- (id)createData;

- (id)createDataWithGet:(NSDictionary*)getDic;

- (id)createDataWithPost:(NSDictionary*)postDic;

@end
