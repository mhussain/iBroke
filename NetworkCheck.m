//
//  NetworkCheck.m
//  iBroke
//
//  Created by Mujtaba Hussain on 1/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkCheck.h"

@implementation NetworkCheck

+ (BOOL)isNetworkAvailable;
{
  Reachability *r = [Reachability reachabilityWithHostName:@"http://www.apple.com"];
  NetworkStatus internetStatus = [r currentReachabilityStatus];
  
  if(internetStatus == NotReachable)
    return NO;
  
  return YES;
}

+ (NSString *)error;
{
  return @"Please check your network connection";
}

@end
