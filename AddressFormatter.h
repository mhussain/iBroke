//
//  AddressFormatter.h
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressFormatter : NSObject

+ (NSString *)createAddressUsingHostname:(NSString *)hostname portNumber:(NSString *)portNumber suffix:(NSString *)suffix;

@end
