//
//  MeaningfulErrors.m
//  iBroke
//
//  Created by Mujtaba Hussain on 31/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MeaningfulErrors.h"

@implementation MeaningfulErrors

+ (NSString *)messageForErrorCode:(NSInteger)code;
{
  if (code == 2) { return @"Connection timed out"; }
  if (code == 6) { return @"Server addres not valid"; }
  if (code == 3) { return @"Authentication required"; }
  if (code == 1) { return @"Could not connect to server"; }
  return @"You can haz unknown error";
}

@end
