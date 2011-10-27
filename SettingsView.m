//
//  MainPage.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"
#import "UserData.h"

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
    [url_label setTextColor:[UIColor whiteColor]];
    [url_label setBackgroundColor:[UIColor clearColor]];
    [url_label setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [self addSubview:url_label];
    
    _url_text_1 = [[UITextField alloc] initWithFrame:CGRectMake(20., 50., 270., 35.)];
    [_url_text_1 setKeyboardType:UIKeyboardTypeURL];
    [_url_text_1 setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_url_text_1 setTag:1];
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
      [_url_text_1 setText:@"http://"];
    }
    
    [self addSubview:_url_text_1];
   
    
    _previous_hosts = [[UIView alloc] initWithFrame:CGRectZero];
    [_previous_hosts setBackgroundColor:[UIColor greenColor]];
    [self addSubview:_previous_hosts];
    
  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
  }
  return self;
}



#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  [[self previous_hosts] setFrame:CGRectMake([self bounds].origin.x + 10., [self bounds].origin.y + 200., [self bounds].size.width - 20., 100.)];
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
  
  CGContextRestoreGState(context);
}

@end
