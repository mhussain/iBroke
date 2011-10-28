//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import "BuildDetailController.h"
#import "Build.h"
#import "BuildDetailView.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "BuildDetail.h"

@interface BuildDetailController()

- (void)connectToAddress:(Build *)build;

@end

@implementation BuildDetailController

@synthesize buildView = _buildView;

- (id)initWithBuild:(Build *)build;
{
  self = [super initWithNibName:nil bundle:nil];

  if (self)
  {
    [[self navigationItem] setHidesBackButton:NO animated:YES];
    [self setTitle:[build name]];

    [self connectToAddress:build];
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

- (void)connectToAddress:(Build *)build;
{
  NSString *address = [NSString stringWithFormat:@"%@api/json/", [build url]];

  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:address]];
  [request setDelegate:self];
  [request setCachePolicy:ASIDoNotWriteToCacheCachePolicy];
  [request startAsynchronous];
}

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  NSLog([NSString stringWithFormat:@"Connecting to the server: %@", [request url]]);
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
  SBJsonParser *parser = [[SBJsonParser alloc] init];
  NSDictionary *buildData = [parser objectWithString:[request responseString] error:nil];

  BuildDetail *detail = [BuildDetail instanceWithData:buildData];
  [[self buildView] setBuildDetail:detail];
  [[self buildView] setNeedsLayout];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSLog(@"Error Fetching Data %@", [[request error] description]);
}

@end
