//
//  ConnectToJenkins.h
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ASIHTTPRequestDelegate.h"

@interface ConnectToJenkins : NSObject <ASIHTTPRequestDelegate>

- (id)initWithAddress:(NSString *)address;
//- (void)connect;

@end
