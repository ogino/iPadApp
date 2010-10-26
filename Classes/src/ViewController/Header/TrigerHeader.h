//
//  TrigerHeader.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrigerHeader : UIViewController {
@private
	UIActivityIndicatorView* indicator_;
	UIImageView* imageView_;
	UILabel* label_;
}

@property (nonatomic, retain) UIActivityIndicatorView* indicator;
@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UILabel* label;

@end
