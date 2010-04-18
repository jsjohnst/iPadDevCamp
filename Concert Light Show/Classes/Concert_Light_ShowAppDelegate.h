//
//  Concert_Light_ShowAppDelegate.h
//  Concert Light Show
//
//  Created by Saul Mora on 4/16/10.
//  Copyright Magical Panda Software, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Concert_Light_ShowViewController;
@class Concert_Light_ShowExternalViewController;

@interface Concert_Light_ShowAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	Concert_Light_ShowViewController *viewController;

	UIWindow *external_window;
	Concert_Light_ShowExternalViewController *externalViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIWindow *external_window;

@property (nonatomic, retain) IBOutlet Concert_Light_ShowViewController *viewController;
@property (nonatomic, retain) IBOutlet Concert_Light_ShowExternalViewController *externalViewController;

- (void)screenDidConnect:(NSNotification *)notification;
- (void)screenDidDisconnect:(NSNotification *)notification;

@end

