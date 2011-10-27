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

@synthesize hostnameText = _hostnameText;
@synthesize portText = _portText;
@synthesize suffixText = _suffixText;

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
    
    UITextField *url_text = [[UITextField alloc] initWithFrame:CGRectMake(20., 50., 270., 40.)];
    [url_text setKeyboardType:UIKeyboardTypeURL];
    [url_text setBorderStyle:UITextBorderStyleRoundedRect];
    [url_text setFont:[UIFont fontWithName:@"Helvetica" size:20.]];
    [url_text setTextColor:[UIColor blackColor]];
    
    NSString *hostnameText = [UserData get:@"hostame"];
    if (![hostnameText isEqualToString:@""])
    {
      [url_text setText:hostnameText];
    }
    else
    {
      [url_text setPlaceholder:@"http://server:port/suffix"];
    }
    
    [self addSubview:url_text];
    
  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
  }
  return self;
}

#pragma mark - UIView

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
