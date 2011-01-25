//
//  TimeLineViewController.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeLineViewController.h"


@implementation TimeLineViewController

@synthesize loaded = loaded_;
@synthesize timeLine = timeLine_;
@synthesize url = url_;
@synthesize userId = userId_;
@synthesize password = password_;
@synthesize tweets = tweets_;
@synthesize trigger = trigger_;
@synthesize images = images_;

#pragma mark -
#pragma mark Private Methods

- (void)createTrigerHeader {
	CGRect rect = self.tableView.bounds;
	rect.origin.y -= 80;
	rect.size.height = 80;
	self.trigger = [[HeaderTrgger alloc] initWithFrame:rect];
	[self.tableView addSubview:self.trigger];
}

- (void)refreshTable {
	[self.tableView reloadData];
}

- (UIImage*)createImage:(NSString*)urlStr {
	NSURL* url = [NSURL URLWithString:urlStr];
	URLLoader* urlLoader = [[[URLLoader alloc] init] autorelease];
	NSData* data = [urlLoader request:url];
	UIImage* image = [UIImage imageWithData:data];
	return [image shrinkImage:CGRectMake(0, 0, 80, 80)];
}

- (void)createUserImage {
	for (NSMutableDictionary* tweet in self.tweets) {
		NSMutableDictionary* user = [tweet objectForKey:@"user"];
		UIImage* image = [self createImage:(NSString*)[user objectForKey:@"profile_image_url"]];
		[self.images addObject:image];
	}
}

- (void)requestTimeLine {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[self createTrigerHeader];
	self.tweets = (NSArray*)[self.timeLine createData];
	[self createUserImage];
	self.loaded = YES;
	[[NSNotificationCenter defaultCenter] postNotificationName:TIMELINE_NOFIFY object:nil];
	[pool release];
}

- (void)fetchedTimeLine:(NSNotification*) notification {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self performSelectorOnMainThread:@selector(refreshTable) withObject:nil waitUntilDone:YES];
}

- (UIImage*)adjustImage:(UIImage*)image {
	CGRect rect = CGRectMake(0, 0, 80, 80);

	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);

	[image drawInRect:rect];

	UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	return shrinkedImage;
}


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.images = [NSMutableArray array];
	self.loaded = NO;
	self.timeLine = [[[TimeLine alloc] init:self.url userId:self.userId password:self.password] autorelease];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedTimeLine:) name:TIMELINE_NOFIFY object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	if (!self.loaded)
		[self performSelectorInBackground:@selector(requestTimeLine) withObject:nil];
	else
		[self refreshTable];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ([self.tweets isEmpty]) ? 0 : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([self.tweets isEmpty]) ? 0 : [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
	if (![self.tweets isEmpty]) {
		NSDictionary* tweet = [self.tweets objectAtIndex:indexPath.row];
		cell.detailTextLabel.text = (NSString*)[tweet objectForKey:@"text"];
		cell.detailTextLabel.numberOfLines = 0;
		cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		NSDictionary* user = [tweet objectForKey:@"user"];
		cell.imageView.image = [self.images objectAtIndex:indexPath.row];
		cell.textLabel.text = (NSString*)[user objectForKey:@"name"];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
	}
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog(@"Move");
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark -
#pragma mark Table view controller data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}


- (void)dealloc {
	self.timeLine = nil;
	self.tweets = nil;
	self.trigger = nil;
	self.images = nil;
    [super dealloc];
}


@end

