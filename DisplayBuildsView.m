//
//  DisplayBuildsView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayBuildsView.h"

#import "Build.h"

@interface DisplayBuildsView () 

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation DisplayBuildsView

@synthesize buildData = _buildData;
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];
  
  if (self)
  {
    [self setTableView:[[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [[self tableView] reloadData];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [self addSubview:[self tableView]];
  }
  
  return self;
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  
}

- (void)drawRect:(CGRect)rect;
{
  
}

- (void)refresh;
{
  [[self tableView] reloadData];
}

  
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
}
  
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [[self buildData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  NSLog(@"Build count %@", [[self buildData] count]);
  
  Build *build = [[self buildData] objectAtIndex:[indexPath row]];
  
  [[cell textLabel] setText:[build name]];
  [[cell textLabel] setTextColor:[UIColor redColor]];

  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  [spinner startAnimating];
  [spinner setHidden:NO];
  [cell setAccessoryView:spinner];
  
  return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return 1;
}


@end
