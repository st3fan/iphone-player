//  MovieViewController.h

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController : UIViewController {
  @private
	NSURL* url_;
  @private
    MPMoviePlayerController* moviePlayerController_;
}

@property (nonatomic,retain) NSURL* url;

@end