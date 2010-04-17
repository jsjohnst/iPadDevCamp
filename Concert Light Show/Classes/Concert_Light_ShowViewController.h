//
//  Concert_Light_ShowViewController.h
//  Concert Light Show
//
//  Created by Saul Mora on 4/16/10.
//  Copyright Magical Panda Software, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Concert_Light_ShowViewController : UIViewController {
	UITextView *text_log;
}

- (void) logScreens;
- (void)screenDidConnect:(NSNotification *)notification;

@property (nonatomic, retain) IBOutlet UITextView *text_log;

@end

