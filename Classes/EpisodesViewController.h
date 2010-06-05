//  EpisodesViewController.h

#import <UIKit/UIKit.h>

@class Show;

@interface EpisodesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
  @private
	UILabel* showNameLabel_;
	UIImageView* showImageView_;
    UITableView* tableView_;
  @private
	Show* show_;
}

@property (nonatomic,assign) IBOutlet UILabel* showNameLabel;
@property (nonatomic,assign) IBOutlet UIImageView* showImageView;
@property (nonatomic,assign) IBOutlet UITableView* tableView;
@property (nonatomic,retain) Show* show;

@end