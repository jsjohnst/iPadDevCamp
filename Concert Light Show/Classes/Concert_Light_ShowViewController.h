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
	UIImageView *magenta;
}

- (void)logScreens;

@property (nonatomic, retain) IBOutlet UITextView *text_log;
@property (nonatomic, retain) IBOutlet UIImageView *magenta;

@end

