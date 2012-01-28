//
//  UserData.m
//  iBroke
//
//  Created by Mujtaba Hussain on 27/10/11.

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2011 Mujtaba Hussain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

#import "UserData.h"

@implementation UserData

NSMutableSet *servers;

+ (void)save:(NSString *)data forKey:(NSString *)key;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
    servers = [[NSMutableSet alloc] init];
  });

	if (standardUserDefaults)
  {
		[standardUserDefaults setObject:data forKey:key];

    [servers addObject:data];

    [standardUserDefaults setObject:[servers allObjects] forKey:@"previous_hosts"];

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
	NSArray *hosts = nil;

	if (standardUserDefaults)
		hosts = [standardUserDefaults objectForKey:@"previous_hosts"];

  return hosts;
}

@end
