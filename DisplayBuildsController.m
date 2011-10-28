//
//  DisplayBuildsController.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayBuildsController.h"

#import "ASIHTTPRequest.h"
#import "SBJson.h"

#import "SettingsController.h"

#import "AddressFormatter.h"
#import "BuildDashboard.h"
#import "DisplayBuildsView.h"
#import "BuildDetailController.h"
#import "Build.h"
#import "UIColor+Hex.h"
#import "NSArray+Blocks.h"

@interface DisplayBuildsController ()

@property (nonatomic, retain) DisplayBuildsView *buildsView;

@property (nonatomic, retain) NSMutableArray *hiddenBuilds;
@property (nonatomic, retain) NSArray *filteredBuilds;

@property (nonatomic) BOOL inFullTableEditMode;

-(NSArray*)builds;
- (UIColor *)colorForStatus:(Build *)build;

@end

@implementation DisplayBuildsController

@synthesize buildsView = _buildsView;
@synthesize address = _address;
@synthesize buildData = _buildData;
@synthesize inFullTableEditMode = _inFullTableEditMode;

@synthesize hiddenBuilds = _hiddenBuilds;
@synthesize filteredBuilds = _filteredBuilds;

- (id)initWithAddress:(NSString *)address;
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(settings)];
    [[self navigationItem] setRightBarButtonItem:settings];
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];

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
  
  [self setBuildData:[dashboard builds]];
  [[self buildsView] reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  NSLog(@"Error Fetching Data %@",[error description]);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
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

-(NSArray*)filteredBuilds;
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

-(NSArray*)builds;
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
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
  }
  else if ([build isDisabled])
  {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
  }
  else if ([build isBuilding])
  {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    [spinner setHidden:NO];
    [cell setAccessoryView:spinner];
  }
  else // passing
  {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }

  return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return 1;
}

#pragma mark - Private methods

- (UIColor *)colorForStatus:(Build *)build;
{
  if ([build isFailed]) return [UIColor colorWithHexString:@"CC0033"];
  if ([build isBuilding]) return [UIColor colorWithHexString:@"0066CC"];
  if ([build isDisabled]) return [UIColor colorWithHexString:@"4A4A4A"];
  return [UIColor colorWithHexString:@"458B00"]; // green
}

@end
