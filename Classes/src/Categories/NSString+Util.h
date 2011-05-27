//
//  NSString+Util.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Util)

+ (BOOL)isEmpty:(NSString*)string;

+ (NSString*)urlEncode:(NSString*)source;

+ (NSString*)urlDecode:(NSString*)source;

+ (unsigned int)convertHexString:(NSString*)hex;

@end
