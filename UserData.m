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
    servers = [[NSMutableArray alloc] init];
  });
  
	if (standardUserDefaults) {
		[standardUserDefaults setObject:data forKey:key];
    
    [servers addObject:data];
    [standardUserDefaults setObject:servers forKey:@"previous"];
    
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

@end
