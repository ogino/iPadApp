//
//  UIImage+Util.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Util.h"


@implementation UIImage (UIImage_Util)

- (UIImage*)shrinkImage:(CGRect)rect {
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
	
	[self drawInRect:rect];
	
	UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return shrinkedImage;
}

@end
