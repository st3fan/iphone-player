// ShowsViewController.h

#import <UIKit/UIKit.h>

@interface ShowsViewController : UIViewController {
  @private
	UIScrollView* scrollView_;
}

@property (nonatomic,assign) IBOutlet UIScrollView* scrollView;

@end