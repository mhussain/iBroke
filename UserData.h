//
//  UserData.h
//  iBroke
//
//  Created by Mujtaba Hussain on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

+ (void)save:(NSString*)data forKey:(NSString *)key;
+ (NSString *)get:(NSString *)key;
+ (NSArray *)previousHosts;

@end
