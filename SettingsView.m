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

-(void)saveToUserDefaults:(NSString*)data forKey:(NSString *)key;
-(NSString*)retrieveFromUserDefaults:(NSString *)key;

@end

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
    [hostname setTextColor:[UIColor blackColor]];
    [hostname setBackgroundColor:[UIColor clearColor]];
    [hostname setFont:[UIFont fontWithName:@"Helvetica" size:15.]];    
    [self addSubview:hostname];
    
    _hostnameText = [[UITextField alloc] initWithFrame:CGRectMake(120., 10., 180., 	30.)];
    [_hostnameText setKeyboardType:UIKeyboardTypeURL];
    [_hostnameText setBorderStyle:UITextBorderStyleLine];
    [_hostnameText setBackgroundColor:[UIColor clearColor]];    
//    [_hostnameText setText:@"http://ci-control01.dev.int.realestate.com.au"];
    
    NSString *savedHostname = [UserData get:@"hostname"];
    if ([savedHostname isEqualToString:@""])
    {
      [_hostnameText setText:@"http://"];
    }
    else 
    {
      [_hostnameText setText:savedHostname];
    }
    
    [_hostnameText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_hostnameText setFont:[UIFont fontWithName:@"Helvetica" size:15.]]; 
    [self addSubview:_hostnameText];
    
    UILabel *port = [[UILabel alloc] initWithFrame:CGRectMake(10., 60., 100., 30.)];
    [port setText:@"Port number"];
    [port setTextColor:[UIColor blackColor]];
    [port setBackgroundColor:[UIColor clearColor]];
    [port setFont:[UIFont fontWithName:@"Helvetica" size:15.]];    
    [self addSubview:port];

    _portText = [[UITextField alloc] initWithFrame:CGRectMake(120., 60., 180., 30.)];
    [_portText setKeyboardType:UIKeyboardTypeNumberPad];
    [_portText setText:@"8080"];
    [_portText setBorderStyle:UITextBorderStyleLine];
    [_portText setBackgroundColor:[UIColor clearColor]];
    [_portText setFont:[UIFont fontWithName:@"Helvetica" size:15.]];
    [self addSubview:_portText];
    
    UILabel *suffix = [[UILabel alloc] initWithFrame:CGRectMake(10., 110., 100., 30.)];
    [suffix setText:@"Suffix"];
    [suffix setTextColor:[UIColor blackColor]];
    [suffix setBackgroundColor:[UIColor clearColor]];
    [suffix setFont:[UIFont fontWithName:@"Helvetica" size:15.]];    
    [self addSubview:suffix];

    _suffixText = [[UITextField alloc] initWithFrame:CGRectMake(120., 110., 180., 30.)];
    [_suffixText setBorderStyle:UITextBorderStyleLine];
    [_suffixText setBackgroundColor:[UIColor clearColor]];
    [_suffixText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_suffixText setFont:[UIFont fontWithName:@"Helvetica" size:15.]];
    [_suffixText setPlaceholder:@""];
    [self addSubview:_suffixText];
    
  	[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
  }
  return self;
}

@end
