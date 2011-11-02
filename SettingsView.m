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

@interface SettingsView ()

@property (nonatomic, retain) UIView *previous_hosts;
@property (nonatomic, retain) AboutView *about;
@end

@implementation SettingsView

@synthesize previous_hosts = _previous_hosts;
@synthesize about = _about;

@synthesize server = _server;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];

  if (self)
  {    
    UILabel *url_label = [[UILabel alloc] initWithFrame:CGRectMake(32., 10., 230., 30.)];
    [url_label setText:@"Connect to"];
    [url_label setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [url_label setBackgroundColor:[UIColor clearColor]];
    [url_label setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [self addSubview:url_label];
    
    _server = [[UITextField alloc] initWithFrame:CGRectMake(20., 35., 270., 40.)];
    [_server setKeyboardType:UIKeyboardTypeURL];
    [_server setTextAlignment:UITextAlignmentCenter];
    [_server setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_server setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_server setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_server setTag:1];
    [_server setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_server setBorderStyle:UITextBorderStyleLine];
    [_server setBackgroundColor:[UIColor whiteColor]];
    [_server setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_server setTextColor:[UIColor blackColor]];
    
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

    _previous_hosts = [[UIView alloc] initWithFrame:CGRectZero];
    [_previous_hosts setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_previous_hosts];
    
    NSArray *previous_hostnames = [UserData previousHosts];
    if (nil != previous_hostnames)
    {
      [previous_hostnames each:^ (id hostname) {
      	UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setText:hostname];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [label setUserInteractionEnabled:YES];
        [label setTag:2];

        [label setFont:[UIFont fontWithName:@"Verdana" size:15.]];
        [label setBackgroundColor:[UIColor clearColor]];

        [[label layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [[label layer] setBorderWidth:1.0];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previousHostTapped:)];
        [label addGestureRecognizer:tap];
        
        [_previous_hosts addSubview:label];
      }];
    }

  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
        
    [self layoutIfNeeded];
  }
  return self;
}

#pragma mark - GestureRecogniser
- (void)previousHostTapped:(UIGestureRecognizer *)gestureRecogniser;
{
  UILabel *label = (UILabel *)[gestureRecogniser view];
	[_server setText:[label text]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
  UITouch *touch = [touches anyObject];

  if ([[touch view] tag] == 2)
	  [[touch view] setBackgroundColor:[UIColor colorWithHexString:@"008080"]];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
  UITouch *touch = [touches anyObject];

  if ([[touch view] tag] == 2)
	  [[touch view] setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  [[self about] setFrame:CGRectMake(10., [self bounds].size.height - 20., [self bounds].size.width - 20., 20.)];
  
  [[self previous_hosts] setFrame:CGRectMake([self bounds].origin.x + 20., [self bounds].origin.y + 200., [self bounds].size.width - 60., 105.)];
  
  CGRect previous_hosts_rect = [[self previous_hosts] bounds];
  
  __block CGFloat padding = 0.;
  
  [[[self previous_hosts] subviews] each:^(id label) {    
    [label setFrame:CGRectMake(previous_hosts_rect.origin.x + 10., previous_hosts_rect.origin.y + padding, 250., 40.)];
    padding += 45.;
  }];
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
    
  CGFloat previous_hosts_x =  155.;
  CGFloat previous_hosts_y =  180.;
  
  CGContextMoveToPoint(context, previous_hosts_x, previous_hosts_y);
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextAddLineToPoint(context, previous_hosts_x, previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x + 150., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x + 150., previous_hosts_y + 160.);
  CGContextAddLineToPoint(context, previous_hosts_x - 140., previous_hosts_y + 160.);
  CGContextAddLineToPoint(context, previous_hosts_x - 140., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x - 130, previous_hosts_y);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

@end
