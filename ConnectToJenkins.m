//
//  ConnectToJenkins.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ConnectToJenkins.h"

#import "SBJson.h"
#import "ASIHTTPRequest.h"

@implementation ConnectToJenkins

- (id)initWithAddress:(NSString *)address;
{
	self = [super init];
  
  if (self)
  {
//    NSString *api = [NSString stringWithFormat:@""];
//    if (nil == suffix)
//    {
//      api = [api stringByAppendingString:@"api/json/"];
//    }
//    else
//    {
//      api = [api stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/",suffix,@"api",@"json"]];
//    }
//    
//    NSString *address = [NSString stringWithFormat:@"%@:%@/%@",hostname,portNumber,api];
//    
    NSLog(@"Address = %@",address);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:address]];
    [request setDelegate:self];
    [request startAsynchronous];
  }
  
  return self;
}


//- (void)connect;
//{
//  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
//  NSString *address = [NSString stringWithFormat:@"%@:%@/api/json",
//                       [settings objectForKey:@"host"],
//                       [settings objectForKey:@"port"]];
//
//}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  NSLog(@"Connecting to the server");
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
//  NSString *json_string = [request responseString];
//  
//  SBJsonParser *parser = [[SBJsonParser alloc] init];
//  
//  NSDictionary *object = [parser objectWithString:json_string error:nil];
//  
//  NSLog(@"-->%@", object);

  NSLog(@"I am done");
  
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  NSLog(@"Error Fetching Data %@",[error description]);
}


@end
