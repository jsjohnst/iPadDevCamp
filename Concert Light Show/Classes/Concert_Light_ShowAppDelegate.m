//
//  Concert_Light_ShowAppDelegate.m
//  Concert Light Show
//
//  Created by Saul Mora on 4/16/10.
//  Copyright Magical Panda Software, LLC 2010. All rights reserved.
//

#import "Concert_Light_ShowAppDelegate.h"
#import "Concert_Light_ShowViewController.h"

#import <UIKit/UIScreen.h>

@implementation Concert_Light_ShowAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  // runs before app is drawn on the screen

	NSArray  *my_screens;

	int screen_count;

	my_screens = [UIScreen screens];
	screen_count = [my_screens count] - 1;

	window.screen = [my_screens objectAtIndex:screen_count];

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

@end
