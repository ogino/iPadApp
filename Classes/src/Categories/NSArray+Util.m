//
//  NSArray+Util.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Util.h"


@implementation NSArray (Util)

+ (BOOL)isEmpty:(NSArray*)array {
	if (array == nil) return YES;
	return (BOOL)(array.count == 0);
}

@end
