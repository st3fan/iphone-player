//  MovieViewController.m

#import "MovieViewController.h"

@implementation MovieViewController

@synthesize url = url_;

- (NSTimeInterval) loadPlaybackTime
{
	NSTimeInterval playbackTime = 0;
	
	NSDictionary* bookmarks = [[NSUserDefaults standardUserDefaults] dictionaryForKey: @"Bookmarks"];
	if (bookmarks != nil) {
		NSNumber* playbackTimeNumber = [bookmarks objectForKey: [url_ absoluteString]];
		if (playbackTimeNumber != nil) {
			playbackTime = [playbackTimeNumber doubleValue];
		}
	}
		
	return playbackTime;
}

- (void) savePlaybackTime: (NSTimeInterval) playbackTime
{
	NSMutableDictionary* bookmarks = nil;

	NSDictionary* readOnlyBookmarks = [[NSUserDefaults standardUserDefaults] dictionaryForKey: @"Bookmarks"];
	if (readOnlyBookmarks == nil) {
		bookmarks = [NSMutableDictionary dictionary];
	} else {
		bookmarks = [NSMutableDictionary dictionaryWithDictionary: readOnlyBookmarks];
	}
		
	[bookmarks setObject: [NSNumber numberWithDouble: playbackTime] forKey: [url_ absoluteString]];
	
	[[NSUserDefaults standardUserDefaults] setObject: bookmarks forKey: @"Bookmarks"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void) viewDidAppear:(BOOL)animated
{
//	[[UIApplication sharedApplication] setStatusBarHidden: YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
//	[[UIApplication sharedApplication] setStatusBarHidden: NO];
}

- (void) viewDidLoad
{
	self.wantsFullScreenLayout = YES;
	self.view.frame = [[[[UIApplication sharedApplication] windows] objectAtIndex: 0] frame];
	self.view.backgroundColor = [UIColor blackColor];

	moviePlayerController_ = [[MPMoviePlayerController alloc] init];
	if (moviePlayerController_ != nil)
	{
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(moviePlayerPlaybackDidFinish:)
			name: MPMoviePlayerPlaybackDidFinishNotification object: moviePlayerController_];

		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(moviePlayerPlaybackDidExitFullscreen:)
			name: MPMoviePlayerDidExitFullscreenNotification object: moviePlayerController_];


		[self.view addSubview: moviePlayerController_.view];

		//moviePlayerController_.currentPlaybackTime = [self loadPlaybackTime];
		moviePlayerController_.controlStyle = MPMovieControlStyleFullscreen;
		moviePlayerController_.contentURL = url_;
		moviePlayerController_.repeatMode = MPMovieRepeatModeOne;
		moviePlayerController_.view.frame = self.view.bounds;
		moviePlayerController_.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		
		[moviePlayerController_ play];
	}
}

#pragma mark -

- (void) moviePlayerPlaybackDidExitFullscreen: (NSNotification*) notification
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	[self savePlaybackTime: moviePlayerController_.currentPlaybackTime];
	[moviePlayerController_ release];
	[self dismissModalViewControllerAnimated: NO];
}

- (void) moviePlayerPlaybackDidFinish: (NSNotification*) notification
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	[self savePlaybackTime: moviePlayerController_.currentPlaybackTime];
	[moviePlayerController_ release];
	[self dismissModalViewControllerAnimated: NO];
}

@end
