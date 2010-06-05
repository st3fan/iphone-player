// Show.m

#import "Show.h"

@implementation Show

@synthesize identifier = identifier_;
@synthesize name = name_;
@synthesize smallImageName = smallImageName_;
@synthesize largeImageName = largeImageName_;
@synthesize episodes = episodes_;

- (id) init
{
	if ((self = [super init]) != nil) {
		episodes_ = [NSMutableArray new];
	}
	return self;
}

- (void) dealloc
{
	[identifier_ release];
	[name_ release];
	[smallImageName_ release];
	[largeImageName_ release];
	[episodes_ release];
	[super dealloc];
}

@end