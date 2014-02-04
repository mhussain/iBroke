//
//  AppDelegate.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2011 Mujtaba Hussain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

#import "AppDelegate.h"
#import "SettingsController.h"

#import "UINavigationController+Shadow.h"
#import "UINavigationBar+Utilities.h"

#import "UserData.h"
#import "DisplayBuildsController.h"

@interface AppDelegate ()

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) SettingsController *mainPageController;

@end

@implementation AppDelegate

@synthesize window = _window;

@synthesize navigationController = _navigationController;
@synthesize mainPageController = _mainPageController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

  [application setApplicationSupportsShakeToEdit:YES];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


  _navigationController = [[[UINavigationController alloc] initWithNibName:nil bundle:nil] autorelease];

  if ([[UINavigationBar class]respondsToSelector:@selector(appearance)]) {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
  }

  [[[self navigationController] navigationBar] setBarStyle:UIBarStyleBlack];

  NSString *host = [UserData get:@"hostname"];
  if (nil != host)
  {
    [[self navigationController] pushViewController:[[[DisplayBuildsController alloc]
                                                     initWithAddress:[NSString stringWithFormat:@"%@/api/json/", host]] autorelease]
                                           animated:YES];
  }
  else
  {
   	_mainPageController = [[[SettingsController alloc] initWithNibName:nil bundle:nil] autorelease];
    [[self navigationController] pushViewController:_mainPageController animated:YES];
  }

  [[self window] setRootViewController:[self navigationController]];
  [self displaySplash];

  // Override point for customization after application launch.
  [[self window] setBackgroundColor:[UIColor clearColor]];
  [self.window makeKeyAndVisible];

  return YES;
}

- (void)displaySplash;
{
  UIImageView *splash = [[[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  [splash setTag:909];
  [splash setImage:[UIImage imageNamed:@"Default"]];

  [_window addSubview:splash];
  [_window bringSubviewToFront:splash];

	[self delayedHideSplash:splash];
}

- (void)delayedHideSplash:(UIView *)splash;
{
  [self performSelector:@selector(hideSplash:) withObject:splash afterDelay:.5];
}

- (void)hideSplash:(UIView *)splash;
{
  [UIView beginAnimations:@"hide splash" context:splash];

  [UIView setAnimationDuration:.5];
  [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[splash window] cache:YES];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(finishFading:)];

  [splash setAlpha:0.];

  [UIView commitAnimations];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

@end
