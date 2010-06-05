//  ShowView.m

#import "Show.h"
#import "ShowView.h"

@implementation ShowView

@synthesize show = show_;

- (id) initWithFrame: (CGRect) frame
{
    if ((self = [super initWithFrame:frame])) {
    }
	
    return self;
}

- (void)dealloc
{
	[show_ release];
    [super dealloc];
}

#pragma mark -

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];

	UIImageView* imageView = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 227, 227)] autorelease];
	if (imageView != nil)
	{
		imageView.image = [UIImage imageNamed: show_.largeImageName];
		[self addSubview: imageView];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
}

@end