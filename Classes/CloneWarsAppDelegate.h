// CloneWarsAppDelegate.h

#import <UIKit/UIKit.h>

@interface CloneWarsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController* viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *viewController;

@end