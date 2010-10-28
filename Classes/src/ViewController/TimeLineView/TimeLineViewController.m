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
@synthesize indicator = indicator_;
@synthesize label = label_;
@synthesize images = images_;

#pragma mark -
#pragma mark Private Methods

- (void)refleshTable {
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
	self.tweets = (NSArray*)[self.timeLine createData];
	[self createUserImage];
	self.loaded = YES;
	[[NSNotificationCenter defaultCenter] postNotificationName:TIMELINE_NOFIFY object:nil];
	[pool release];
}

- (void)fetchedTimeLine:(NSNotification*) notification {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self performSelectorOnMainThread:@selector(refleshTable) withObject:nil waitUntilDone:YES];
}

- (UIImage*)adjustImage:(UIImage*)image {
	CGRect rect = CGRectMake(0, 0, 80, 80);

	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
	
	[image drawInRect:rect];
	
	UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return shrinkedImage;
}

- (void)createTrigerHeader {
	CGRect rect = self.tableView.bounds;
	rect.origin.y -= 80;
	rect.size.height = 80;
	self.label = [[[UILabel alloc] initWithFrame:rect] autorelease];
	self.label.backgroundColor = [UIColor blackColor];
	self.label.textColor = [UIColor whiteColor];
	self.label.text = @"下げて更新！\nさあどうぞ！";
	self.label.numberOfLines = 0;
	self.label.lineBreakMode = UILineBreakModeWordWrap;
	self.label.textAlignment = UITextAlignmentCenter;
	self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.indicator startAnimating];
	[self.label addSubview:self.indicator];
	[self.tableView addSubview:self.label];
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
	self.timeLine = [[[TimeLine alloc] init] autorelease];
	self.timeLine.url = self.url;

	[self createTrigerHeader];

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
		[self refleshTable];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return ([self.tweets isEmpty]) ? 0 : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return ([self.tweets isEmpty]) ? 0 : [self.tweets count];
}

// Customize the appearance of table view cells.
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

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog(@"Move");
}


// Override to support conditional rearranging of the table view.
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
	self.indicator = nil;
	self.label = nil;
	self.images = nil;
    [super dealloc];
}


@end

