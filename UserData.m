//
//  UserData.m
//  iBroke
//
//  Created by Mujtaba Hussain on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UserData.h"

@implementation UserData

static NSMutableArray *servers;

+ (void)save:(NSString *)data forKey:(NSString *)key;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    servers = [[NSMutableArray alloc] initWithCapacity:3.];
  });
  
	if (standardUserDefaults) {
		[standardUserDefaults setObject:data forKey:key];
    
    if (![servers containsObject:data])
    {
      if ([servers count] > 2)
        [servers removeLastObject];

      [servers insertObject:data atIndex:0];
    }
  
    [standardUserDefaults setObject:servers forKey:@"previous_hosts"];

		[standardUserDefaults synchronize];
	}
}

+ (NSString *)get:(NSString *)key;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:key];
	
	return val;
}

+ (NSArray *)previousHosts;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableArray *hosts = nil;
	if (standardUserDefaults) 
		hosts = [standardUserDefaults objectForKey:@"previous_hosts"];
  
  return (NSArray *)hosts;
}


@end
