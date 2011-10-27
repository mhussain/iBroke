//
//  UserData.m
//  iBroke
//
//  Created by Mujtaba Hussain on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UserData.h"

@implementation UserData

+ (void)save:(NSString *)data forKey:(NSString *)key;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  
	if (standardUserDefaults) {
		[standardUserDefaults setObject:data forKey:key];
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
