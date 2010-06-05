//
//  CloneWarsViewController.m
//  CloneWars
//
//  Created by Stefan Arentz on 10-04-05.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import "CloneWarsViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation CloneWarsViewController

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

-(void) myMovieFinishedCallback: (NSNotification*) aNotification
{
    MPMoviePlayerController* theMovie = [aNotification object];
 
    [[NSNotificationCenter defaultCenter]
                    removeObserver: self
                              name: MPMoviePlayerPlaybackDidFinishNotification
                            object: theMovie];
 
    // Release the movie instance created in playMovieAtURL:
    [theMovie release];
}

- (void) viewDidAppear:(BOOL)animated
{
	NSString* path = [[NSBundle mainBundle] pathForResource: @"star.wars.the.clone.wars.s01e01" ofType: @"mov"];
	NSURL* theURL = [NSURL fileURLWithPath: path];

    MPMoviePlayerViewController* theMovie = [[[MPMoviePlayerViewController alloc] initWithContentURL: theURL] autorelease];
	if (theMovie != nil) {
		[self presentMoviePlayerViewControllerAnimated: theMovie];
	}
 
//    theMovie.scalingMode = MPMovieScalingModeAspectFill;
//	theMovie.controlStyle = MPMovieControlStyleDefault;
// 
//    // Register for the playback finished notification
//    [[NSNotificationCenter defaultCenter]
//                    addObserver: self
//                       selector: @selector(myMovieFinishedCallback:)
//                           name: MPMoviePlayerPlaybackDidFinishNotification
//                         object: theMovie];
// 
//    // Movie playback is asynchronous, so this method returns immediately.
//    [theMovie play];
}

@end
