//
//  Created by mike_rowe on 28/10/11.
//
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
#import "BuildDetailController.h"
#import "Build.h"
#import "BuildDetailView.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "BuildDetail.h"

#import "LoadingView.h"

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
    _buildView = [[BuildDetailView alloc] initWithFrame:CGRectZero];
    [self setView:_buildView];

    [self connectToAddress:build];
  }
  return self;
}

//-(void)loadView;
//{
//  _buildView = [[BuildDetailView alloc] initWithFrame:CGRectZero];
//  [self setView:_buildView];
//}


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
  NSLog(@"%@",[NSString stringWithFormat:@"Connecting to the server: %@", [request url]]);
  
  LoadingView *loadingView = [[LoadingView alloc] initWithFrame:[_buildView bounds] andMessage:@"Loading build info..."];
  [_buildView addSubview:loadingView];
  
  [[self editButtonItem] setEnabled:NO];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
  UIView *loadingView = [_buildView viewWithTag:3.];
  [loadingView removeFromSuperview];
  
  SBJsonParser *parser = [[SBJsonParser alloc] init];
  NSDictionary *buildData = [parser objectWithString:[request responseString] error:nil];

  BuildDetail *detail = [BuildDetail instanceWithData:buildData];
  [[self buildView] setBuildData:detail];
  
  [[self editButtonItem] setEnabled:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSLog(@"Error Fetching Data %@", [[request error] description]);
  [[self editButtonItem] setEnabled:NO];
}

@end
