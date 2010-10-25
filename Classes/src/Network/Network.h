//
//  Network.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Network : NSObject {

}

- (NSData*)request:(NSURL*) url;

- (NSData*)request:(NSURL*) url get:(NSString*) get;

- (NSData*)request:(NSURL *)url post:(NSString*) post;

@end
