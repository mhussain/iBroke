//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BuildDetailController.h"
#import "Build.h"
#import "BuildDetailView.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "BuildDetail.h"

#import "LoadingView.h"

@interface BuildDetailController()

- (void)connectToAddress:(NSString *)url;

@end

@interface BuildDetailController()

@property (nonatomic, retain) NSMutableDictionary *allBuildData;

@end

@implementation BuildDetailController

@synthesize buildView = _buildView;
@synthesize allBuildData = _allBuildData;

- (id)initWithBuild:(Build *)build;
{
  self = [super initWithNibName:nil bundle:nil];

  if (self)
  {
    [[self navigationItem] setHidesBackButton:NO animated:YES];
    [self setTitle:[build name]];

    [self connectToAddress:[build url]];
  }
  return self;
}

-(void)loadView;
{
  // TODO some kind of throbber while we wait for network...

  _buildView = [[BuildDetailView alloc] initWithFrame:CGRectZero];
  [self setView:_buildView];
}


#pragma mark - ASIHTTPRequestDelegate

- (void)connectToAddress:(NSString *)url;
{
  NSString *address = [NSString stringWithFormat:@"%@api/json/", url];

  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:address]];
  [request setDelegate:self];
  [request setCachePolicy:ASIDoNotWriteToCacheCachePolicy];
  [request startAsynchronous];
}

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  NSLog(@"%@",[NSString stringWithFormat:@"Connecting to the server: %@", [request url]]);
  
  LoadingView *loadingView = [[LoadingView alloc] initWithFrame:[_buildView bounds] andMessage:@"Loading build info..."];
  [_buildView addSubview:loadingView];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
  UIView *loadingView = [_buildView viewWithTag:3.];
  [loadingView removeFromSuperview];
  
  SBJsonParser *parser = [[SBJsonParser alloc] init];
  NSDictionary *buildData = [parser objectWithString:[request responseString] error:nil];

  NSDictionary *last_completed_build = [buildData objectForKey:@"lastCompletedBuild"];
  if (last_completed_build)
  {
      [self setAllBuildData:buildData];
      [self connectToAddress:[last_completed_build objectForKey:@"url"]];
  }
  else
  {
      [[self allBuildData] setObject:buildData forKey:@"lastBuild"];
  }
    
  BuildDetail *detail = [BuildDetail instanceWithData:[self allBuildData]];
  [[self buildView] setBuildDetail:detail];
  [[self buildView] setNeedsLayout];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSLog(@"Error Fetching Data %@", [[request error] description]);
}

@end
