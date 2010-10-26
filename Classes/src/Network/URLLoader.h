//
//  URLLoader.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "AlertUtil.h"
#import "URLConnection.h"


@interface URLLoader : NSURLConnection {
@private
//	URLConnection* connection_;
	NSMutableData* data_;
	BOOL done_;
}

//@property (nonatomic, retain) URLConnection* connection;
@property (nonatomic, retain) NSMutableData* data;
@property (nonatomic, assign) BOOL done;

- (void)request:(NSURL*) url;

- (void)request:(NSURL*) url get:(NSString*) get;

- (void)request:(NSURL *)url post:(NSString*) post;

@end
