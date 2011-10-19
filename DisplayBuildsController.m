//
//  DisplayBuildsController.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayBuildsController.h"
#import "ConnectToJenkins.h"

#import "ASIHTTPRequest.h"
#import "SBJson.h"

#import "AddressFormatter.h"

@implementation DisplayBuildsController

@synthesize address = _address;

- (id)initWithAddress:(NSString *)address;
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {
    [self setTitle:@"SomeBuildName"];
    [self setAddress:address];
    [self connectToAddress];
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
  NSString *json_string = [request responseString];
  SBJsonParser *parser = [[SBJsonParser alloc] init];

  NSDictionary *object = [parser objectWithString:json_string error:nil];
  NSLog(@"-->%@", object);

  
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  NSLog(@"Error Fetching Data %@",[error description]);
}



#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

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
