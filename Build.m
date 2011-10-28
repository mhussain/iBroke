//
//  Build.m
//  iBroke
//
//  Created by Mujtaba Hussain on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Build.h"

@implementation Build

@synthesize name = _name;
@synthesize url = _url;
@synthesize status = _status;

-(id)initWithName:(NSString *)name status:(NSString *)status url:(NSString *)url;
{
  self = [super init];
  
  if (self)
  {
    [self setUrl:url];
    [self setStatus:status];
    [self setName:name];
  }
  return self;
}

-(BOOL)isFailed;
{
  return [[self status] isEqualToString:@"red"];
}

-(BOOL)isBuilding;
{
  return [[self status] hasSuffix:@"_anime"];
}

-(BOOL)isDisabled;
{
  return [[self status] isEqualToString:@"disabled"];
}

-(BOOL)isAborted;
{
  return [[self status] isEqualToString:@"aborted"];
}

@end
