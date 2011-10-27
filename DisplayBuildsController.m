//
//  DisplayBuildsController.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayBuildsController.h"

#import "ASIHTTPRequest.h"
#import "SBJson.h"

#import "AddressFormatter.h"
#import "BuildDashboard.h"
#import "DisplayBuildsView.h"

@interface DisplayBuildsController ()

@property (nonatomic, retain) DisplayBuildsView *buildsView;

@end

@implementation DisplayBuildsController

@synthesize address = _address;
@synthesize buildsView = _buildsView;

- (id)initWithAddress:(NSString *)address;
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {
    [self setTitle:@"Builds"];
    [self setAddress:address];
    [self connectToAddress];
    
    _buildsView = [[DisplayBuildsView alloc] initWithFrame:CGRectZero];
    [self setView:_buildsView];
  }
  return self;
}

- (void)connectToAddress;
{
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self address]]];
  [request setDelegate:self];
  [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  NSLog(@"Connecting to the server");
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
  SBJsonParser *parser = [[SBJsonParser alloc] init];

  NSDictionary *buildData = [parser objectWithString:[request responseString] error:nil];
  
  BuildDashboard *dashboard = [[BuildDashboard alloc] initWithBuildData:buildData];
  [[self buildsView] setBuildData:[dashboard builds]];
  [[self buildsView] refresh];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  NSLog(@"Error Fetching Data %@",[error description]);
}



#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
}


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
