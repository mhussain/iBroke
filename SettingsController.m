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

@interface SettingsController ()

@property (nonatomic, retain) SettingsView *settingsView;

@end

@implementation SettingsController

@synthesize settingsView = _settingsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {
    [self setTitle:@"Settings"];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Connect" style:UIBarButtonItemStyleBordered target:self action:@selector(connect)];
    [[self navigationItem] setRightBarButtonItem:done];
    [[self navigationItem] setHidesBackButton:YES];
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
  NSString *hostname = [[[self settingsView] url_text_1] text];

  if (![hostname isEqualToString:@""])
  {
  	[UserData save:hostname forKey:@"hostname"];
  }
  
  [[self navigationController] pushViewController:[[DisplayBuildsController alloc] 
                                  					initWithAddress:[NSString stringWithFormat:@"%@/api/json/", hostname]]
                                                   animated:YES];
}

#pragma mark - View lifecycle

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

@end
