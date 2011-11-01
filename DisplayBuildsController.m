//
//  DisplayBuildsController.m
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "DisplayBuildsController.h"

#import "ASIHTTPRequest.h"
#import "SBJson.h"

#import "SettingsController.h"

#import "AddressFormatter.h"
#import "BuildDashboard.h"
#import "MeaningfulErrors.h"

#import "DisplayBuildsView.h"
#import "BuildDetailController.h"
#import "Build.h"
#import "UIColor+Hex.h"
#import "NSArray+Blocks.h"
#import "UINavigationBar+Utilities.h"

#import "LoadingView.h"
#import "ConnectionFailedView.h"
#import "NotificationView.h"

#define kHiddenBuildsKey @"kHiddenBuildsKey"

@interface DisplayBuildsController ()

@property (nonatomic, retain) DisplayBuildsView *buildsView;

@property (nonatomic, retain) NSMutableArray *hiddenBuilds;
@property (nonatomic, retain) NSArray *filteredBuilds;
@property (nonatomic, retain) UIBarButtonItem *edit;
@property (nonatomic, retain) UIBarButtonItem *done;

@property (nonatomic) BOOL inFullTableEditMode;


-(NSArray*)builds;
- (UIColor *)colorForStatus:(Build *)build;
-(void)saveHiddenBuilds;
-(void)restoreHiddenBuilds;
- (void)handleNetworkEvent:(NSNotification *)notice;
-(void)editTableView;

@end

@implementation DisplayBuildsController

@synthesize reachability = _reachability;

@synthesize buildsView = _buildsView;
@synthesize address = _address;
@synthesize buildData = _buildData;
@synthesize inFullTableEditMode = _inFullTableEditMode;

@synthesize hiddenBuilds = _hiddenBuilds;
@synthesize filteredBuilds = _filteredBuilds;

@synthesize edit =_edit;
@synthesize done = _done;

- (id)initWithAddress:(NSString *)address;
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    
    UIImage *image = [UIImage imageNamed:@"Settings"];
    UIButton *settings = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 35., 35.)];
    [settings setImage:image forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [settings setShowsTouchWhenHighlighted:YES];

    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settings];
    [[self navigationItem] setRightBarButtonItem:settingsButton animated:YES];
        
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 35., 35.)];
    [editButton setImage:[UIImage imageNamed:@"Edit"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editTableView) forControlEvents:UIControlEventTouchUpInside];
    [editButton setShowsTouchWhenHighlighted:YES];
    _edit = [[UIBarButtonItem alloc] initWithCustomView:editButton];

    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 30., 30.)];
    [doneButton setImage:[UIImage imageNamed:@"Done"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(editTableView) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setShowsTouchWhenHighlighted:YES];
    
		_done = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    
    [[self navigationItem] setLeftBarButtonItem:_edit animated:YES];
    [[[self navigationItem] leftBarButtonItem] setStyle:UIBarButtonItemStyleBordered];
    [[[self navigationItem] leftBarButtonItem] setEnabled:NO];

    [self setTitle:@"Builds"];
    [self setAddress:address];
    [self connectToAddress];

    [self setHiddenBuilds:[NSMutableArray array]];

    _buildsView = [[DisplayBuildsView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_buildsView setDelegate:self];
    [_buildsView setDataSource:self];

    [self setView:_buildsView];
  }
  return self;
}

- (void)settings;
{
  [[self navigationController] pushViewController:[[SettingsController alloc] initWithNibName:nil bundle:nil] animated:YES];
}

- (void)editTableView;
{
  BOOL edit = ![self inFullTableEditMode];
  
  if (edit)
  {
    [[self navigationItem] setLeftBarButtonItem:_done animated:YES];
  }
  else
  {
    [[self navigationItem] setLeftBarButtonItem:_edit animated:YES];
  }
  [self setEditing:edit animated:YES];
}

#pragma mark - ShakeToReload
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;
{  
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
{
  if (event.type == UIEventSubtypeMotionShake) {
		[self connectToAddress];
  }
}

#pragma mark - ASyncRequest

- (void)connectToAddress;
{ 
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleNetworkEvent:)
                                               name:kReachabilityChangedNotification
                                             object:nil];
  
  _reachability = [Reachability reachabilityForInternetConnection];
  [_reachability startNotifier];
  
	NetworkStatus remoteHostStatus = [_reachability currentReachabilityStatus];
  if (remoteHostStatus == NotReachable)
  {
    NotificationView *noNetwork = [[NotificationView alloc] initWithFrame:CGRectZero
                                                               andMessage:@"Please check your network connection"
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
  }
  else
  {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self address]]];
    [request setDelegate:self];
    [request setCachePolicy:ASIDoNotWriteToCacheCachePolicy];
    [request startAsynchronous];
  }
}

- (void)handleNetworkEvent:(NSNotification *)notice;
{  
  NetworkStatus remoteHostStatus = [_reachability currentReachabilityStatus];  
  if(remoteHostStatus == NotReachable)
  {
    ConnectionFailedView *noNetwork = [[ConnectionFailedView alloc] initWithFrame:[[self buildsView] bounds] withMessage:@"Network not reachable"];
    [[self buildsView] addSubview:noNetwork];
    [[self buildsView] reloadData];
  }  
  else if (remoteHostStatus == kReachableViaWiFi)
  {
    NSLog(@"wifi");
  }  
  else if (remoteHostStatus == kReachableViaWWAN	)
  {
    NSLog(@"cell");
  }
} 

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  NSLog(@"%@",[NSString stringWithFormat:@"Connecting to the server: %@", [request url]]);

	LoadingView *loadingView = [[LoadingView alloc] initWithFrame:[[self buildsView] bounds] andMessage:@"Loading build dashboard..."];

  [[self buildsView] addSubview:loadingView];
  [[self editButtonItem] setEnabled:NO];
  [[self buildsView] setNeedsDisplay];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{

  UIView *loadingView = [[self buildsView] viewWithTag:3];
  [loadingView removeFromSuperview];
  
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[loadingView layer] addAnimation:animation forKey:@"layerAnimation"];
  
  SBJsonParser *parser = [[SBJsonParser alloc] init];
  NSDictionary *buildData = [parser objectWithString:[request responseString] error:nil];
  BuildDashboard *dashboard = [[BuildDashboard alloc] initWithBuildData:buildData];
  
  [self setBuildData:[dashboard builds]];
  [self restoreHiddenBuilds];
  
  [self setFilteredBuilds:nil];
  
  [[[self navigationItem] leftBarButtonItem] setEnabled:YES];
  [[self buildsView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
	NSString *message = [MeaningfulErrors messageForErrorCode:[[request error] code]];
  
  NSLog(@"Error Fetching Data %@",[error description]);

  UIView *loadingView = [[self buildsView] viewWithTag:3];
  [loadingView removeFromSuperview];
  
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[loadingView layer] addAnimation:animation forKey:@"layerAnimation"];
  [[[self navigationItem] leftBarButtonItem] setEnabled:NO];
  
	ConnectionFailedView *errorView = [[ConnectionFailedView alloc] initWithFrame:[[self buildsView] bounds] withMessage:message];
  [[self buildsView] addSubview:errorView];
  [[self buildsView] reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
{
  [super setEditing:editing animated:animated];
  [self setFilteredBuilds:nil];
  [[self buildsView] setEditing:editing animated:animated];
  
  double delayInSeconds = .4;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    if (editing)
    {
      [[self hiddenBuilds] each:^(id item) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:[[self builds] indexOfObject:item] inSection:0]];
      }];
      [[self buildsView] insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
      double delayInSeconds = .4;
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[self buildsView] reloadData];        
      });
    }
    else
    {
      [[self hiddenBuilds] each:^(id item) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:[[self buildData] indexOfObject:item] inSection:0]];
      }];
      [[self buildsView] deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
  });
  
  [self setInFullTableEditMode:editing];
}

- (NSArray *)filteredBuilds;
{
  if (!_filteredBuilds)
  {
    _filteredBuilds = [[self buildData] filter:^BOOL(id item) {
      Build *build = (Build*)item;
      return [[self hiddenBuilds] containsObject:build];
    }];
  }
  return _filteredBuilds;
}

- (NSArray *)builds;
{
  return [self inFullTableEditMode] ? [self buildData] : [self filteredBuilds];
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  Build *build = [[self buildData] objectAtIndex:[indexPath row]];
  if ([build isFailed])
  {
    BuildDetailController *detailViewController = [[BuildDetailController alloc] initWithBuild:build];
    
    [[self navigationController] pushViewController:detailViewController animated:YES];
  }

  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
{
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
return [[self hiddenBuilds] containsObject:[[self builds] objectAtIndex:[indexPath row]]] ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @"Hide";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  Build *build = [[self builds] objectAtIndex:[indexPath row]];
  
  if (![self inFullTableEditMode])
  {
    [[self hiddenBuilds] addObject:build];
    [self saveHiddenBuilds];
    [self setFilteredBuilds:nil];
    [[self buildsView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return;
  }
  
  if ([[self hiddenBuilds] containsObject:build])
  {
    [[self hiddenBuilds] removeObject:build];
  }
  else
  {
    [[self hiddenBuilds] addObject:build];
  }
  [self saveHiddenBuilds];
  [self setFilteredBuilds:nil];
  [[self buildsView] reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [[self builds] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

  static NSString *CellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if (nil == cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:18.]];
		[cell setBackgroundView :[[UIImageView alloc] init]];
		[cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row-middle.png"]]];
	}

  Build *build = [[self builds] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[build name]];

  [[cell textLabel] setTextColor:[self colorForStatus:build]];

  if ([build isFailed])
  {
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    UIImageView *disclosure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure"]];
    [disclosure setFrame:CGRectMake(0., 0., 15., 15.)];
    [cell setAccessoryView:disclosure];
  }
  else if ([build isDisabled])
  {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [[cell detailTextLabel] setText:@"Disabled"];
    [[cell detailTextLabel] setFont:[UIFont fontWithName:@"Verdana" size:10.]];
    [[cell detailTextLabel] setTextColor:[self colorForStatus:build]];
  }
  else if ([build isBuilding])
  {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    [spinner setHidden:NO];
    [cell setAccessoryView:spinner];
  }
  else if([build isAborted])
  {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [[cell detailTextLabel] setText:@"Aborted"];
    [[cell detailTextLabel] setFont:[UIFont fontWithName:@"Verdana" size:10.]];
    [[cell detailTextLabel] setTextColor:[self colorForStatus:build]];
  }
  else // passing
  {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [[cell detailTextLabel] setText:@""];
  }
  
  return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return 1;
}

#pragma - Persistence

-(void)saveHiddenBuilds;
{
  NSArray *buildIds = [[self hiddenBuilds] map:^id<NSObject>(id<NSObject> item) {
    Build *build = (Build*)item;
    return [NSString stringWithFormat:@"%@::%@", [build url], [build name]];
  }];
                       
  [[NSUserDefaults standardUserDefaults] setObject:buildIds forKey:kHiddenBuildsKey];
}

-(void)restoreHiddenBuilds;
{
  NSArray *buildIds = [[NSUserDefaults standardUserDefaults] objectForKey:kHiddenBuildsKey];
  
  [self setHiddenBuilds:[NSMutableArray arrayWithArray:[[self buildData] pick:^BOOL(id item) {
    Build *build = (Build*)item;
    return [buildIds containsObject:[NSString stringWithFormat:@"%@::%@", [build url], [build name]]];
  }]]];
}

#pragma mark - Private methods

- (UIColor *)colorForStatus:(Build *)build;
{
  if ([build isFailed]) return [UIColor colorWithHexString:@"CC0033"];
  if ([build isBuilding]) return [UIColor colorWithHexString:@"0066CC"];
  if ([build isDisabled]) return [UIColor colorWithHexString:@"B5B5B5"];
  if ([build isAborted]) return [UIColor colorWithHexString:@"42526C"];
  return [UIColor colorWithHexString:@"458B00"]; // green
}

-(BOOL)canBecomeFirstResponder {
  return YES;
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self resignFirstResponder];
  [super viewWillDisappear:animated];
}

@end
