//
//  TabBarController.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/01/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"


@implementation TabBarController

static NSArray* titles;
static NSArray* urls;
static NSArray* icons;

#pragma mark -
#pragma mark Private Methods

- (UINavigationController*)createTLNavigationController:(NSString*)title url:(NSString*)url icon:(NSString*)icon {
	TimeLineViewController* viewController = [[[TimeLineViewController alloc] init] autorelease];
	viewController.title = title;
	viewController.url = url;
	viewController.tabBarItem.image = [UIImage imageNamed:icon];
	UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	navigationController.navigationBar.barStyle = UIBarStyleBlack;
	return navigationController;
}

- (NSArray*)createViewControllers {
	NSMutableArray* viewControllers = [NSMutableArray array];
	NSInteger index = 0;
	for (NSString* title in titles) {
		[viewControllers addObject:[self createTLNavigationController:title url:[urls objectAtIndex:index] icon:[icons objectAtIndex:index]]];
		index++;
	}
	return viewControllers;
}

#pragma mark -
#pragma mark Inherit Methods


- (id)init {
	if (self = [super init]) {
		self.delegate = self;
		titles = [NSArray arrayWithObjects:PUBLIC_TIMELINE_TITLE, nil];
		urls = [NSArray arrayWithObjects:PUBLIC_TIMELINE_URL, nil];
		icons = [NSArray arrayWithObjects:PUBLIC_TIMELINE_ICON, nil];
		self.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
		self.viewControllers = [self createViewControllers];
	}
	return self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
	return YES;
}

- (void)tabBarController:(UITabBarController*)tabBarController willBeginCustomizingViewControllers:(NSArray*)viewControllers {
	UIView* subviews = [tabBarController.view.subviews objectAtIndex:1];
	UINavigationBar* navigationBar = [[subviews subviews] objectAtIndex:0];
	navigationBar.barStyle = UIBarStyleBlack;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}



@end
