//
//  BuildDashboard.m
//  iBroke
//
//  Created by Mujtaba Hussain on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BuildDashboard.h"

#import "NSArray+Blocks.h"
#import "Build.h"

@implementation BuildDashboard

@synthesize builds = _builds;

-(id)initWithBuildData:(NSDictionary *)buildInfo;
{
	self = [super init];
  
  _builds = [[NSMutableArray alloc] init];
  
  if (self)
  {
   	 [[buildInfo objectForKey:@"jobs"] each:^(id build) {
       
     [[self builds] addObject:[[Build alloc] initWithName:[build objectForKey:@"name"] 
                                                   status:[build objectForKey:@"color"] 
                                                      url:[build objectForKey:@"url"]]];
     }];
  }
  return self;
}

@end
