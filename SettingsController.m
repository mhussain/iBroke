//
//  MainPageController.m
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

#import "SettingsController.h"

#import "DisplayBuildsController.h"
#import "SettingsView.h"

#import "AddressFormatter.h"
#import "UserData.h"

#import "AboutController.h"
#import "NetworkCheck.h"
#import "NotificationView.h"

#import "NSString+Empty.h"

@interface SettingsController ()

@property (nonatomic, retain) SettingsView *settingsView;
@property (nonatomic, retain) AboutController *aboutController;

@end

@implementation SettingsController

@synthesize settingsView = _settingsView;
@synthesize aboutController = _aboutController;

static NSString *kEmptyHostname = @"Please enter a hostname";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {
    [self setTitle:@"Settings"];
    
    UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 42., 42.)];
    [infoButton setImage:[UIImage imageNamed:@"about"] forState:UIControlStateNormal];
    [infoButton setUserInteractionEnabled:YES];
		[infoButton addTarget:self action:@selector(about) forControlEvents:UIControlEventTouchUpInside];
    [infoButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *about = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [[self navigationItem] setLeftBarButtonItem:about];
    
    UIButton *connect = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 34., 21.)];
    [connect setImage:[UIImage imageNamed:@"Connect"] forState:UIControlStateNormal];
    [connect addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    [connect setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *connectButton = [[UIBarButtonItem alloc] initWithCustomView:connect];
    [[self navigationItem] setRightBarButtonItem:connectButton animated:YES];
    
    [[self navigationItem] setRightBarButtonItem:connectButton animated:YES];
    [[self navigationItem] setHidesBackButton:YES];
    
    [self setAboutController:[[AboutController alloc] initWithNibName:nil bundle:nil]];
    
  }
  return self;
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
}

-(void)connect;
{
  NSString *hostname = [[[self settingsView] server] text];

  if (![NetworkCheck isNetworkAvailable])
  {
    NotificationView *noNetwork = [[NotificationView alloc] initWithFrame:CGRectZero
                                                               andMessage:[NetworkCheck error]
                                                                  andType:kErrorNotification];
    [noNetwork setNeedsLayout];
    [[self view] addSubview:noNetwork];
    
    [UIView animateWithDuration:3.0
       animations:^{
         [noNetwork setAlpha:0.0];
       }
       completion:^(BOOL finished) {
         [noNetwork removeFromSuperview];
       }
     ];
    return;
  }

  if (!hostname || [hostname isEmpty])
  {
    NotificationView *empty = [[NotificationView alloc] initWithFrame:CGRectZero andMessage:kEmptyHostname andType:kErrorNotification];
    [empty setNeedsLayout];
    [[self view] addSubview:empty];
    
    [UIView animateWithDuration:3.0
       animations: ^ {
         [empty setAlpha:0.0];
       }
       completion: ^ (BOOL completed) {
         [empty removeFromSuperview];
       }
     ];
  }
  else
  {
    [UserData save:hostname forKey:@"hostname"];
    [[self navigationController] pushViewController:[[DisplayBuildsController alloc] 
                                              initWithAddress:[NSString stringWithFormat:@"%@/api/json/", hostname]]
                                                     animated:YES];
  }
}

- (void)about;
{
  
  [UIView  beginAnimations:nil context:NULL];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationDuration:0.75];
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[[self navigationController] view] cache:NO];
  [UIView commitAnimations];
  
  [UIView beginAnimations:nil context:NULL];
  [[self navigationController] pushViewController:[self aboutController] animated:NO];
  [UIView commitAnimations];
}

#pragma mark - UIGesture

#pragma mark - View lifecycle

- (void)viewDidLoad;
{
}

- (void)loadView;
{
  [self setSettingsView:[[SettingsView alloc] initWithFrame:CGRectZero]];
  [[self settingsView] sizeToFit];
  
  [self setView:[self settingsView]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)canBecomeFirstResponder
{
  return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self resignFirstResponder];
  [super viewWillDisappear:animated];
}

@end
