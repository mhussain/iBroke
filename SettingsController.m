//
//  MainPageController.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsController.h"
#import "SettingsView.h"

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
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Connect" style:UIBarButtonItemStyleDone target:self action:@selector(connect)];
    [[self navigationItem] setRightBarButtonItem:done];
  }
  return self;
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

-(void)connect;
{
  NSString *hostname = [[[self settingsView] hostnameText] text];
  NSString *portNumber = [[[self settingsView] portText] text];
  NSString *suffix = [[[self settingsView] suffixText] text];
  
  NSLog(@"%@ %@ %@",hostname, portNumber, suffix);
  
}

#pragma mark - View lifecycle

- (void)loadView;
{
  [self setSettingsView:[[SettingsView alloc] initWithFrame:CGRectZero]];
  [[self settingsView] sizeToFit];
  
  [self setView:[self settingsView]];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
