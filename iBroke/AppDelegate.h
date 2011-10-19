//
//  AppDelegate.h
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)displaySplash;
- (void)delayedHideSplash:(UIView *)splash;
- (void)hideSplash:(UIView *)splash;

@end
