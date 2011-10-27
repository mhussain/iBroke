//
//  AddressFormatter.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressFormatter.h"

@implementation AddressFormatter

+ (NSString *)createAddressUsingHostname:(NSString *)hostname portNumber:(NSString *)portNumber suffix:(NSString *)suffix;
{
  return [NSString stringWithFormat:@"%@:%@/%@/api/json/",hostname,portNumber, suffix ? suffix : @""];
}

@end
