//
//  Concert_Light_ShowViewController.m
//  Concert Light Show
//
//  Created by Saul Mora on 4/16/10.
//  Copyright Magical Panda Software, LLC 2010. All rights reserved.
//

#import "Concert_Light_ShowViewController.h"

@implementation Concert_Light_ShowViewController
@synthesize text_log;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidConnect:)name:UIScreenDidConnectNotification object:nil];
	[super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self logScreens];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)screenDidConnect:(NSNotification *)notification {
	NSArray  *my_screens;
	UIScreen *new_screen;

	NSMutableString *text;
	int screen_count;

	my_screens = [UIScreen screens];

	screen_count = [my_screens count] - 1;
	new_screen   = [my_screens objectAtIndex:screen_count];

	[text setString: text_log.text];
	[text appendString: @"\nScreen Connected"];
	[text appendString:[NSString stringWithFormat:@"%@",new_screen]];

	text_log.text = text;

	[[self view] window].screen = new_screen;
}

- (void)dealloc {
    [super dealloc];
}

- (void)logScreens {
	NSArray *my_screens;
	UIScreen *current_screen;
	NSMutableString *text;
	
	text = [[NSMutableString alloc] init];
	
	my_screens = [UIScreen screens];
	
	[text setString:(@"%@", text_log.text)];
	[text appendString: @"Connected Screens:\n"];
	
	text_log.text = text;
	
	NSEnumerator *enumerator = [my_screens objectEnumerator];
	
	while (current_screen = [enumerator nextObject]) {
		[text setString: text_log.text];
		[text appendString:[NSString stringWithFormat:@"%@",current_screen]];
    text_log.text = text;
	}
	
}

@end
