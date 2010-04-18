//
//  Concert_Light_ShowAppDelegate.m
//  Concert Light Show
//
//  Created by Saul Mora on 4/16/10.
//  Copyright Magical Panda Software, LLC 2010. All rights reserved.
//

#import "Concert_Light_ShowAppDelegate.h"
#import "Concert_Light_ShowViewController.h"
#import "Concert_Light_ShowExternalViewController.h"

#import <UIKit/UIScreen.h>

@implementation Concert_Light_ShowAppDelegate

@synthesize window;
@synthesize viewController;

@synthesize external_window;
@synthesize externalViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  // runs before app is drawn on the screen
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidConnect:)name:UIScreenDidConnectNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidDisconnect:)name:UIScreenDidDisconnectNotification object:nil];

	NSArray  *my_screens;

	int screen_count;

	my_screens = [UIScreen screens];
	screen_count = [my_screens count] - 1;

	if (screen_count > 1) {
		external_window.screen = [my_screens objectAtIndex:screen_count];
	}

	// Testing: Create the view here
	[self createExternalView: nil];
	
	// Override point for customization after app launch    
	[window addSubview:viewController.view];
	[window makeKeyAndVisible];

	return YES;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

- (void)screenDidConnect:(NSNotification *)notification {
	UIScreen *new_screen;

	NSMutableString *text;
	text = [[NSMutableString alloc] init];

	new_screen = [notification object];
	
	//external_window.screen = new_screen;
	[self createExternalView: new_screen];

	[text setString: [viewController text_log].text];
	[text appendString: @"\n\nScreen Connected:\n\n"];
	[text appendString:[NSString stringWithFormat:@"%@",new_screen]];

	[viewController text_log].text = text;

	[text release];
}

- (void)screenDidDisconnect:(NSNotification *)notification {
	NSMutableString *text;
	text = [[NSMutableString alloc] init];

	[text setString: [viewController text_log].text];
	[text appendString: @"\n\nScreen Disconnected!"];

	[viewController text_log].text = text;

	external_window.screen = [UIScreen mainScreen];

	[text release];
}

- (void)createExternalView: (UIScreen*) screen
{
	UIWindow* externalWindow = [[UIWindow alloc] init];
	[externalWindow setScreen:screen];
	
	// Create the external view
	externalViewController = [Concert_Light_ShowExternalViewController alloc];
	
	[externalWindow addSubview: [externalViewController view]];
	[externalWindow makeKeyAndVisible];
}

@end
