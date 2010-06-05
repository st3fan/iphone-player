// EpisodeTableViewCell.m

#import "EpisodeTableViewCell.h"

@implementation EpisodeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

#pragma mark -

- (void) layoutSubviews
{
	[super layoutSubviews];
}

- (void) prepareForReuse
{
	[super prepareForReuse];
}

@end