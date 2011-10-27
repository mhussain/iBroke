//
//  MainPage.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"
#import "UserData.h"

@implementation SettingsView

@synthesize url_text_1 = _url_text_1;
@synthesize url_text_2 = _url_text_2;
@synthesize url_text_3 = _url_text_3;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];

  if (self)
  {
    UILabel *url_label = [[UILabel alloc] initWithFrame:CGRectMake(32., 10., 230., 30.)];
    [url_label setText:@"Jenkins servers"];
    [url_label setTextColor:[UIColor blackColor]];
    [url_label setBackgroundColor:[UIColor clearColor]];
    [url_label setFont:[UIFont fontWithName:@"Helvetica" size:20.]];
    [self addSubview:url_label];
    
    _url_text_1 = [[UITextField alloc] initWithFrame:CGRectMake(20., 50., 270., 40.)];
    [_url_text_1 setKeyboardType:UIKeyboardTypeURL];
    [_url_text_1 setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_url_text_1 setTag:1];
    [_url_text_1 setBorderStyle:UITextBorderStyleRoundedRect];
    [_url_text_1 setFont:[UIFont fontWithName:@"Helvetica" size:20.]];
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
    
  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
  }
  return self;
}



#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  
}

- (void)drawRect:(CGRect)rect;
{  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 2.);
  
  CGContextMoveToPoint(context, 180., 25.);
  CGContextSetStrokeColorWithColor(context, [[UIColor brownColor] CGColor]);
  CGContextAddLineToPoint(context, 180., 25.);
  CGContextAddLineToPoint(context, 300., 25.);
  CGContextAddLineToPoint(context, 300., 110.);
  CGContextAddLineToPoint(context, 10., 110.);
  CGContextAddLineToPoint(context, 10., 25.);
  CGContextAddLineToPoint(context, 25., 25.);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

@end
