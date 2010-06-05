// Episode.m

#import "Episode.h"

@implementation Episode

@synthesize path = path_;
@synthesize date = date_;
@synthesize season = season_;
@synthesize episode = episode_;
@synthesize show = show_;
@synthesize name = name_;

- (void) dealloc
{
	[path_ release];
	[show_ release];
	[name_ release];
	[super dealloc];
}

@end