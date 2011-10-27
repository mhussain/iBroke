//
//  DisplayBuildsView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import "DisplayBuildsView.h"
#import "UIColor+Hex.h"
#import "Build.h"

@interface DisplayBuildsView () 

@property (nonatomic, retain) UITableView *tableView;

- (void)styleTableView;
@end

@implementation DisplayBuildsView

@synthesize buildData = _buildData;
@synthesize tableView = _tableView;
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];
  
  if (self)
  {
    [self setTableView:[[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [self styleTableView];
    [[self tableView] reloadData];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    [[self tableView] setBackgroundView:image];

    [self addSubview:[self tableView]];
  }
  
  return self;
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  [[self tableView] setFrame:[self bounds]];
}

- (void)drawRect:(CGRect)rect;
{
  
}

- (void)styleTableView;
{
  [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [[self tableView] setRowHeight:55.];
	[[self tableView] setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - REST

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
    [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:18.]];
		[cell setBackgroundView :[[UIImageView alloc] init]];
		[cell setSelectedBackgroundView:[[UIImageView alloc] init]];
	}
  
	UIImage *rowBackground;
	UIImage *selectionBackground;
	
  NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
  
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"topAndBottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage imageNamed:@"topRow.png"];
		selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"bottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"middleRow.png"];
		selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
//	if ((row % 3) == 0)
//	{
//		cell.image = [UIImage imageNamed:@"imageA.png"];
//	}
//	else if ((row % 3) == 1)
//	{
//		cell.image = [UIImage imageNamed:@"imageB.png"];
//	}
//	else
//	{
//		cell.image = [UIImage imageNamed:@"imageC.png"];
//	}
  
  Build *build = [[self buildData] objectAtIndex:[indexPath row]];
  
  [[cell textLabel] setText:[build name]];
  
  if ([[build status] isEqualToString:@"red"])
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"CC0033"]];
		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
    [cell setAccessoryView:[[UIImageView alloc] initWithImage:indicatorImage]];

  }
  else if ([[build status] isEqualToString:@"blue"])
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"458B00"]];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }
  else
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"0066CC"]];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    [spinner setHidden:NO];
    [cell setAccessoryView:spinner];
  }
  
  return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return 1;
}


@end
