//
//  DisplayBuildsView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DisplayBuildsView.h"
#import "UIColor+Hex.h"
#import "Build.h"
#import "BuildDetailView.h"

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

- (void)refresh;
{
  [[self tableView] reloadData];
}

  
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  BuildDetailView *detailView = [[BuildDetailView alloc] initWithFrame:[self frame]];
  [detailView setBuild:[[self buildData] objectAtIndex:[indexPath row]]];
  [self addSubview:detailView];
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
    [[cell textLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.]];
  }
  
  Build *build = [[self buildData] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[build name]];
  
  if ([[build status] isEqualToString:@"red"])
  {
    [[cell textLabel] setTextColor:[UIColor redColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }
  else if ([[build status] isEqualToString:@"blue"])
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"458B00"]];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }
  else
  {
    [[cell textLabel] setTextColor:[UIColor blueColor]];
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
