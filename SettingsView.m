//
//  MainPage.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

@synthesize hostnameText = _hostnameText;
@synthesize portText = _portText;
@synthesize suffixText = _suffixText;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];

  if (self)
  {    
    UILabel *hostname = [[UILabel alloc] initWithFrame:CGRectMake(10., 10., 100., 30.)];
    [hostname setText:@"Host name"];
    [hostname setTextColor:[UIColor whiteColor]];
    [hostname setBackgroundColor:[UIColor clearColor]];
    [hostname setShadowColor:[UIColor blackColor]];
    [self addSubview:hostname];
    
    _hostnameText = [[UITextField alloc] initWithFrame:CGRectMake(120., 10., 180., 30.)];
    [_hostnameText setKeyboardType:UIKeyboardTypeURL];
    [_hostnameText setBorderStyle:UITextBorderStyleRoundedRect];
    [_hostnameText setText:@"http://ci-control01.dev.int.realestate.com.au"];
    [_hostnameText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self addSubview:_hostnameText];
    
    UILabel *port = [[UILabel alloc] initWithFrame:CGRectMake(10., 60., 100., 30.)];
    [port setText:@"Port number"];
    [port setTextColor:[UIColor whiteColor]];
    [port setBackgroundColor:[UIColor clearColor]];
		[port setShadowColor:[UIColor blackColor]];
    [self addSubview:port];

    _portText = [[UITextField alloc] initWithFrame:CGRectMake(120., 60., 180., 30.)];
    [_portText setKeyboardType:UIKeyboardTypeNumberPad];
    [_portText setText:@"8080"];
    [_portText setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:_portText];
    
    UILabel *suffix = [[UILabel alloc] initWithFrame:CGRectMake(10., 110., 100., 30.)];
    [suffix setText:@"Suffix"];
    [suffix setTextColor:[UIColor whiteColor]];
    [suffix setBackgroundColor:[UIColor clearColor]];
    [suffix setShadowColor:[UIColor blackColor]];
    [self addSubview:suffix];

    _suffixText = [[UITextField alloc] initWithFrame:CGRectMake(120., 110., 180., 30.)];
    [_suffixText setBorderStyle:UITextBorderStyleRoundedRect];
    [_suffixText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_suffixText setPlaceholder:@""];
    [self addSubview:_suffixText];
    
  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UIView
- (CGSize)sizeThatFits:(CGSize)size;
{
  return size;
}

@end
