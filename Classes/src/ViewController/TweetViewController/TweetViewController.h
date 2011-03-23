//
//  TweetViewController.h
//  iPadApp
//
//  Created by 荻野 雅 on 11/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetViewController : UIViewController<UITextViewDelegate> {
@private
	UITextView* textView_;
}

@property (nonatomic, retain) IBOutlet UITextView* textView;

@end
