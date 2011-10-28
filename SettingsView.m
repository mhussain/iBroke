//
//  MainPage.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"
#import "UserData.h"
#import <QuartzCore/QuartzCore.h>

#import "NSArray+Blocks.h"
#import "UIColor+Hex.h"

@interface SettingsView ()

@property (nonatomic, retain) UIView *previous_hosts;

@end

@implementation SettingsView

@synthesize previous_hosts = _previous_hosts;

@synthesize url_text_1 = _url_text_1;
@synthesize url_text_2 = _url_text_2;
@synthesize url_text_3 = _url_text_3;

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
    
    _url_text_1 = [[UITextField alloc] initWithFrame:CGRectMake(20., 50., 270., 35.)];
    [_url_text_1 setKeyboardType:UIKeyboardTypeURL];
    [_url_text_1 setTextAlignment:UITextAlignmentCenter];
    [_url_text_1 setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_url_text_1 setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_url_text_1 setTag:1];
    [_url_text_1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_url_text_1 setBorderStyle:UITextBorderStyleLine];
    [_url_text_1 setBackgroundColor:[UIColor whiteColor]];
    [_url_text_1 setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_url_text_1 setTextColor:[UIColor blackColor]];
    
    NSString *hostnameText = [UserData get:@"hostname"];
    if (nil != hostnameText)
    {
      [_url_text_1 setText:hostnameText];
    }
    else
    {
      [_url_text_1 setPlaceholder:@"http://server:port/suffix"];
    }
    
    [self addSubview:_url_text_1];
   
    UILabel *previous_hosts_label = [[UILabel alloc] initWithFrame:CGRectMake(22., 163., 230., 30.)];
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
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    [self layoutIfNeeded];
  }
  return self;
}

#pragma mark - GestureRecogniser
- (void)previousHostTapped:(UIGestureRecognizer *)gestureRecogniser;
{
  UILabel *label = (UILabel *)[gestureRecogniser view];
	[_url_text_1 setText:[label text]];
}

- (void)hideKeyboard;
{
  [[self url_text_1] resignFirstResponder];
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
  [[self previous_hosts] setFrame:CGRectMake([self bounds].origin.x + 20., [self bounds].origin.y + 200., [self bounds].size.width - 60., 105.)];
  
  CGRect previous_hosts_rect = [[self previous_hosts] bounds];
  
  __block CGFloat padding = 0.;
  
  [[[self previous_hosts] subviews] each:^(id label) {    
    [label setFrame:CGRectMake(previous_hosts_rect.origin.x + 5., previous_hosts_rect.origin.y + padding, 250., 40.)];
    padding += 45.;
  }];
}

- (void)drawRect:(CGRect)rect;
{  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 1.);
  
  CGContextMoveToPoint(context, 140., 25.);
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextAddLineToPoint(context, 140., 25.);
  CGContextAddLineToPoint(context, 300., 25.);
  CGContextAddLineToPoint(context, 300., 110.);
  CGContextAddLineToPoint(context, 10., 110.);
  CGContextAddLineToPoint(context, 10., 25.);
  CGContextAddLineToPoint(context, 25., 25.);
  CGContextStrokePath(context);
    
  CGFloat previous_hosts_x =  150.;
  CGFloat previous_hosts_y =  180.;
  
  CGContextMoveToPoint(context, previous_hosts_x, previous_hosts_y);
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextAddLineToPoint(context, previous_hosts_x, previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x + 140., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x + 140., previous_hosts_y + 160.);
  CGContextAddLineToPoint(context, previous_hosts_x - 140., previous_hosts_y + 160.);
  CGContextAddLineToPoint(context, previous_hosts_x - 140., previous_hosts_y);
  CGContextAddLineToPoint(context, previous_hosts_x - 130, previous_hosts_y);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

@end
