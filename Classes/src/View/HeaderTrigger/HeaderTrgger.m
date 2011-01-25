//
//  HeaderTrgger.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/01/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HeaderTrgger.h"


@implementation HeaderTrgger

@synthesize label = label_;
@synthesize indicator = indicator_;

#define LABEL_WIDTH 160
#define LABEL_HEIGHT 80

- (void) createLabel {
	self.label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, LABEL_WIDTH, LABEL_HEIGHT)] autorelease];
	self.label.backgroundColor = [UIColor clearColor];
	self.label.textColor = [UIColor whiteColor];
	self.label.text = @"下げて更新！\nさあどうぞ！";
	self.label.numberOfLines = 0;
	self.label.lineBreakMode = UILineBreakModeWordWrap;
	self.label.textAlignment = UITextAlignmentCenter;
}

- (void) createIndicator {
	self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.indicator startAnimating];
}

#define HALF_WIDTH (self.frame.size.width / 2)
#define HALF_HEIGHT (self.frame.size.height / 2)

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self createLabel];
		[self createIndicator];
		self.label.center = CGPointMake(HALF_WIDTH, HALF_HEIGHT);
		self.indicator.center = CGPointMake(self.label.frame.origin.x - (self.indicator.frame.size.width / 2), self.label.center.y);
		[self addSubview:self.label];
		[self addSubview:self.indicator];
		self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	self.label = nil;
	self.indicator = nil;
    [super dealloc];
}


@end
