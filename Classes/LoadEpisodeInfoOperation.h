// LoadEpisodeInfoOperation.h

#import <Foundation/Foundation.h>

@class Episode;

@interface LoadEpisodeInfoOperation : NSOperation {
  @private
	Episode* episode_;
  @private
	NSURLConnection* connection_;
	NSMutableData* data_;
	NSInteger statusCode_;
	BOOL executing_;
	BOOL finished_;
}

- (id) initWithEpisode: (Episode*) episode;

@end