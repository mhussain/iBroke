//
//  Build.m
//  iBroke
//
//  Created by Mujtaba Hussain on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

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

@end
