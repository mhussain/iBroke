//
//  AppDelegate.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingsController.h"

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
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  _navigationController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
  [[[self navigationController] navigationBar] setBarStyle:UIBarStyleBlack];
  
	_mainPageController = [[SettingsController alloc] initWithNibName:nil bundle:nil];
  [[self navigationController] pushViewController:_mainPageController animated:YES];

  [[self window] setRootViewController:[self navigationController]];
  [self displaySplash];
  
  // Override point for customization after application launch.
  [[self window] setBackgroundColor:[UIColor clearColor]];
  [self.window makeKeyAndVisible];

  return YES;
}

- (void)displaySplash;
{
  UIImageView *splash = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [splash setTag:909];
  [splash setImage:[UIImage imageNamed:@"Default.png"]];
  
  [_window addSubview:splash];
  [_window bringSubviewToFront:splash];
  
	[self delayedHideSplash:splash];
}

- (void)delayedHideSplash:(UIView *)splash;
{
  [self performSelector:@selector(hideSplash:) withObject:splash afterDelay:3.];
}

- (void)hideSplash:(UIView *)splash;
{
  [UIView beginAnimations:@"hide splash" context:splash];
  
  [UIView setAnimationDuration:1.];
  [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[splash window] cache:YES];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(finishFading:)];
  
  [splash setAlpha:0.];
  
  [UIView commitAnimations];
}

//- (void)finishFading:(UIView *)splash;
//{
//  [UIView beginAnimations:nil context:splash];
//  [UIView setAnimationDuration:0.75];
//  
//  [[[self navigationController] view] setAlpha:1.0];
//  [UIView commitAnimations];
//}

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
