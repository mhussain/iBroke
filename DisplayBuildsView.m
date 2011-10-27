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
  _imageView.image = [UIImage imageNamed:@"gradientBackground.png"];

//      imageView.image = [UIImage imageNamed:@"gradientBackground.png"];
//  UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
  
//  headerLabel.text = NSLocalizedString(@"Header for the table", @"");
//  headerLabel.textColor = [UIColor whiteColor];
//  headerLabel.shadowColor = [UIColor blackColor];
//  headerLabel.shadowOffset = CGSizeMake(0, 1);
//  headerLabel.font = [UIFont boldSystemFontOfSize:22];
//  headerLabel.backgroundColor = [UIColor clearColor];
//  [containerView addSubview:headerLabel]; 
  
//  [[self tableView] setTableHeaderView:containerView];
//  [[self tableView] reloadData];
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
  
//#if USE_CUSTOM_DRAWING
  const NSInteger TOP_LABEL_TAG = 1001;
  const NSInteger BOTTOM_LABEL_TAG = 1002;
  UILabel *topLabel;
  UILabel *bottomLabel;
//#endif
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil)
  {
//    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
//		const CGFloat LABEL_HEIGHT = 20;
//		UIImage *image = [UIImage imageNamed:@"imageA.png"];
    
//    UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
//		cell.accessoryView = [[UIImageView alloc] initWithImage:indicatorImage];

    
		//
		// Create the label for the top row of text
		//
//		topLabel =
//    [[UILabel alloc]
//      initWithFrame:
//      CGRectMake(
//                 image.size.width + 2.0 * cell.indentationWidth,
//                 0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT),
//                 tableView.bounds.size.width -
//                 image.size.width - 4.0 * cell.indentationWidth
//                 - indicatorImage.size.width,
//                 LABEL_HEIGHT)];
//		[cell.contentView addSubview:topLabel];
    
		//
		// Configure the properties for the text that are the same on every row
		//
//		topLabel.tag = TOP_LABEL_TAG;
//		topLabel.backgroundColor = [UIColor clearColor];
//		topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
//		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
//		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    
		//
		// Create the label for the top row of text
		//
//		bottomLabel = [[UILabel alloc]
//      initWithFrame:
//      CGRectMake(
//                 image.size.width + 2.0 * cell.indentationWidth,
//                 0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
//                 tableView.bounds.size.width -
//                 image.size.width - 4.0 * cell.indentationWidth
//                 - indicatorImage.size.width,
//                 LABEL_HEIGHT)];
//    
//		[cell.contentView addSubview:bottomLabel];
    
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    
		//
		// Create a background image view.
		//
		cell.backgroundView = [[UIImageView alloc] init];
		cell.selectedBackgroundView =[[UIImageView alloc] init];

	}
  
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
	
//	topLabel.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];
//	bottomLabel.text = [NSString stringWithFormat:@"Some other information.", [indexPath row]];
	
	//
	// Set the background and selected background images for the text.
	// Since we will round the corners at the top and bottom of sections, we
	// need to conditionally choose the images based on the row index and the
	// number of rows in the section.
	//
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
    [[cell textLabel] setTextColor:[UIColor redColor]];
		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
    [cell setAccessoryView:[[UIImageView alloc] initWithImage:indicatorImage]];

//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }
  else if ([[build status] isEqualToString:@"blue"])
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"458B00"]];
//    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }
  else
  {
    [[cell textLabel] setTextColor:[UIColor blueColor]];
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [spinner startAnimating];
//    [spinner setHidden:NO];
//    [cell setAccessoryView:spinner];
  }
  
  return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return 1;
}


@end
