//
//  NetworkCheck.h
//  iBroke
//
//  Created by Mujtaba Hussain on 1/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"

@interface NetworkCheck : NSObject

+ (BOOL)isNetworkAvailable;
+ (NSString *)error;

@end
