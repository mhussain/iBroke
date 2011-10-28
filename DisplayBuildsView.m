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
#import "NSArray+Blocks.h"

@interface DisplayBuildsView () 

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *hiddenBuilds;
@property (nonatomic, retain) NSArray *filteredBuilds;

- (void)styleTableView;
@end

@implementation DisplayBuildsView

@synthesize buildData = _buildData;
@synthesize tableView = _tableView;
@synthesize imageView = _imageView;
@synthesize hiddenBuilds = _hiddenBuilds;
@synthesize filteredBuilds = _filteredBuilds;

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];
  
  if (self)
  {
    [self setHiddenBuilds:[NSMutableArray array]];
    
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
  return [[self tableView] isEditing] ? [self buildData] : [self filteredBuilds];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
  [[self tableView] setEditing:editing animated:animated];
  [self setFilteredBuilds:nil];
  [[self tableView] reloadData];
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
  [detailView setBuild:[[self builds] objectAtIndex:[indexPath row]]];
  [self addSubview:detailView];
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
  if ([[self hiddenBuilds] containsObject:build])
  {
    [[self hiddenBuilds] removeObject:build];
  }
  else
  {
    [[self hiddenBuilds] addObject:build];
  }
  [self setFilteredBuilds:nil];
  [[self tableView] reloadData];
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
