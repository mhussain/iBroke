//
//  DisplayBuildsView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DisplayBuildsView.h"
#import "UIColor+Hex.h"
#import "Build.h"
#import "BuildDetailView.h"

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
  [[self tableView] setRowHeight:50.];
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
  
  if (nil == cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:18.]];
		[cell setBackgroundView :[[UIImageView alloc] init]];
		[cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row-middle.png"]]];
	}
  
  Build *build = [[self buildData] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[build name]];
  
  if ([[build status] isEqualToString:@"red"])
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"CC0033"]];
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];

  }
  else if ([[build status] isEqualToString:@"blue"])
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"458B00"]];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }
  else
  {
    [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"0066CC"]];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
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
