//
//  MainPage.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.

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

#import "SettingsView.h"
#import "UserData.h"
#import <QuartzCore/QuartzCore.h>

#import "NSArray+Blocks.h"
#import "UIColor+Hex.h"
#import "NSString+Empty.h"
#import "UIView+Size.h"

#import "AboutView.h"

@interface CustomerController : UITableViewController

@property (nonatomic, retain) SettingsView *v;

@end

@implementation CustomerController

@synthesize v = _v;

- (id)initWithSettingsView:(SettingsView *)view;
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {
   	_v = view; 
  }
  
  return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  NSArray *previous_hostnames = [UserData previousHosts];
	[[[self v] server] setText:[previous_hostnames objectAtIndex:[indexPath row]]];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [[UserData previousHosts] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  if (nil == cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  
  [[cell imageView] setImage:[UIImage imageNamed:@"action"]];
  
  [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:16.]];
  [[cell textLabel] setTextColor:[UIColor colorWithHexString:@"00FF7F"]];
	[cell setBackgroundColor:[UIColor clearColor]]; 
	
  NSArray *previous_hostnames = [UserData previousHosts];
  
  [[cell textLabel] setText:[previous_hostnames objectAtIndex:[indexPath row]]];
  
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return 1;
}

@end

@interface SettingsView ()

@property (nonatomic, retain) UITableView *previousHosts;
@property (nonatomic, retain) CustomerController *c;

@end

@implementation SettingsView

@synthesize previousHosts = _previousHosts;
@synthesize c = _c;

@synthesize server = _server;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];

  if (self)
  {    
    UILabel *url_label = [[UILabel alloc] initWithFrame:CGRectMake(32., 7., 230., 30.)];
    [url_label setText:@"Connect to"];
    [url_label setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [url_label setBackgroundColor:[UIColor clearColor]];
    [url_label setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [self addSubview:url_label];
    
    
    _server = [[UITextField alloc] initWithFrame:CGRectMake(20., 34., 270., 40.)];
    [_server setKeyboardType:UIKeyboardTypeURL];
    [_server setTextAlignment:UITextAlignmentLeft];
    [_server setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_server setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_server setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_server setTag:1];
    [_server setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_server setBorderStyle:UITextBorderStyleLine];
    [_server setBackgroundColor:[UIColor whiteColor]];
    [_server setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_server setTextColor:[UIColor blackColor]];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 20., [[self server] height])];
    [[self server] setLeftView:paddingView];
    [[self server] setLeftViewMode:UITextFieldViewModeAlways];
    
    NSString *hostnameText = [UserData get:@"hostname"];

    if ([hostnameText isNotEmpty])
      [_server setText:hostnameText];
    else
      [_server setPlaceholder:@"http://server:port/suffix"];
    
    [self addSubview:_server];
   
    UILabel *previous_hosts_label = [[UILabel alloc] initWithFrame:CGRectMake(27., 163., 230., 35.)];
    [previous_hosts_label setText:@"Previous hosts"];
    [previous_hosts_label setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [previous_hosts_label setBackgroundColor:[UIColor clearColor]];
    [previous_hosts_label setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [self addSubview:previous_hosts_label];

    _c = [[CustomerController alloc] initWithSettingsView:self];
    _previousHosts = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		[_previousHosts setDelegate:_c];
    [_previousHosts setDataSource:_c];
    [_previousHosts setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_previousHosts setBackgroundColor:[UIColor clearColor]];
    [_previousHosts setAlpha:0.4];

    [self addSubview:_previousHosts];
    
  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
        
    [self layoutIfNeeded];
  }
  return self;
}


#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  [[self previousHosts] setFrame:CGRectMake(25., 195., 270., 190.)];
}

- (void)drawRect:(CGRect)rect;
{  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 1.);

  CGFloat startingYOffset = [[self server] y_coord] - 10.;
  
  CGContextMoveToPoint(context, 140., startingYOffset);
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextAddLineToPoint(context, 140., startingYOffset);
  CGContextAddLineToPoint(context, 300., startingYOffset);
  CGContextAddLineToPoint(context, 300., startingYOffset + [[self server] height] + 20.);
  CGContextAddLineToPoint(context, 10., startingYOffset + [[self server] height] + 20.);
  CGContextAddLineToPoint(context, 10., startingYOffset);
  CGContextAddLineToPoint(context, 25., startingYOffset);
  CGContextStrokePath(context);
    
  CGFloat previous_hosts_x =  150.;
  CGFloat previous_hosts_y =  180.;
  
  CGContextMoveToPoint(context, previous_hosts_x + 10. , previous_hosts_y);
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextAddLineToPoint(context, previous_hosts_x + 10., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x + 150., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x + 150., previous_hosts_y + 220.);
  CGContextAddLineToPoint(context, previous_hosts_x - 140., previous_hosts_y + 220.);
  CGContextAddLineToPoint(context, previous_hosts_x - 140., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x - 130, previous_hosts_y);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

@end
