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
@synthesize magenta;
@synthesize external_window;
@synthesize externalViewController;


#define GROW_ANIMATION_DURATION_SECONDS 0.15    // Determines how fast a piece size grows when it is moved.
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15  // Determines how fast a piece size shrinks when a piece stops moving.

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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidDisconnect:)name:UIScreenDidDisconnectNotification object:nil];
	
	NSArray  *my_screens;
	
	int screen_count;
	
	my_screens = [UIScreen screens];
	screen_count = [my_screens count] - 1;
	
	if (screen_count > 1) {
		external_window.screen = [my_screens objectAtIndex:screen_count];
	}
	
	
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

- (void)dealloc {
	[magenta release];
	
	[super dealloc];
}

- (void)logScreens {
	NSArray *my_screens;
	UIScreen *current_screen;
	NSMutableString *text;
	
	text = [[NSMutableString alloc] init];
	
	my_screens = [UIScreen screens];
	
	[text setString:(@"%@", text_log.text)];
	[text appendString: @"\n\nConnected Screens:\n\n"];
	
	NSEnumerator *enumerator = [my_screens objectEnumerator];
	
	while (current_screen = [enumerator nextObject]) {
		[text appendString:[NSString stringWithFormat:@"%@",current_screen]];
	}

	text_log.text = text;
	[text release];
}

// SCREEN CONNECTIONS
- (void)screenDidConnect:(NSNotification *)notification {
	UIScreen *new_screen;
	
	NSMutableString *text;
	text = [[NSMutableString alloc] init];
	
	new_screen = [notification object];
	
	//external_window.screen = new_screen;
	[self createExternalView: new_screen];
	
	[text setString: text_log.text];
	[text appendString: @"\n\nScreen Connected:\n\n"];
	[text appendString:[NSString stringWithFormat:@"%@",new_screen]];
	
	[text_log setText:text];
	
	[text release];
}

- (void)screenDidDisconnect:(NSNotification *)notification {
	NSMutableString *text;
	text = [[NSMutableString alloc] init];
	
	[text setString: [text_log text]];
	[text appendString: @"\n\nScreen Disconnected!"];
	
	[text_log setText:text];
	
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


// TOUCHES and ANIMATION
// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Enumerate through all the touch objects.
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchFirstTouchAtPoint:[touch locationInView:self.view] forEvent:nil];
		touchCount++;  
	}	
}


// Checks to see which view, or views, the point is in and then calls a method to perform the opening animation,
// which  makes the piece slightly larger, as if it is being picked up by the user.
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event
{
	if (CGRectContainsPoint([magenta frame], touchPoint)) {
		[self animateFirstTouchAtPoint:touchPoint forView:magenta];
	}
}

// Handles the continuation of a touch.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
	
	NSUInteger touchCount = 0;
	// Enumerates through all touch objects
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEvent:[touch view] toPosition:[touch locationInView:self.view]];
		touchCount++;
	}
}

// Checks to see which view, or views, the point is in and then sets the center of each moved view to the new postion.
// If views are directly on top of each other, they move together.
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position
{
	// Check to see which view, or views,  the point is in and then move to that position.
	if (CGRectContainsPoint([magenta frame], position)) {
		magenta.center = position;
		
		// Move the external's version, too.
	} 
}

// Handles the end of a touch event.
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
}

// Checks to see which view, or views,  the point is in and then calls a method to perform the closing animation,
// which is to return the piece to its original size, as if it is being put down by the user.
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position
{   
	// Check to see which view, or views,  the point is in and then animate to that position.
	if (CGRectContainsPoint([magenta frame], position)) {
		[self animateView:magenta toPosition: position];
	} 
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
}

// Scales up a view slightly which makes the piece slightly larger, as if it is being picked up by the user.
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView 
{
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
}

// Scales down the view and moves it to the new position. 
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
	// Set the center to the final postion
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}



@end
