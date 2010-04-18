//
//  Concert_Light_ShowViewController.h
//  Concert Light Show
//
//  Created by Saul Mora on 4/16/10.
//  Copyright Magical Panda Software, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Concert_Light_ShowExternalViewController.h"

@interface Concert_Light_ShowViewController : UIViewController {
	UITextView *text_log;
	UIImageView *magenta;
	CGPoint startTouchPosition;

	UIWindow *external_window;
	Concert_Light_ShowExternalViewController *externalViewController;
}

- (void)logScreens;

@property (nonatomic, retain) IBOutlet UITextView *text_log;
@property (nonatomic, retain) IBOutlet UIImageView *magenta;

@property (nonatomic, retain) IBOutlet UIWindow *external_window;
@property (nonatomic, retain) IBOutlet Concert_Light_ShowExternalViewController *externalViewController;


- (void)screenDidConnect:(NSNotification *)notification;
- (void)screenDidDisconnect:(NSNotification *)notification;
- (void)createExternalView:(UIScreen *)screen;

-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView;
-(void)animateView:(UIView *)theView toPosition:(CGPoint) thePosition;
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event;
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position;


@end

