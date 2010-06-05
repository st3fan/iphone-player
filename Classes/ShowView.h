// ShowView.h

#import <UIKit/UIKit.h>

@class Show;

@interface ShowView : UIView {
	Show* show_;
}

@property (nonatomic,retain) Show* show;

@end