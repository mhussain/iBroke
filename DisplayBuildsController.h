//
//  DisplayBuildsController.h
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequestDelegate.h"

@interface DisplayBuildsController : UIViewController <UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>

- (id)initWithAddress:(NSString *)address;
- (void)connectToAddress;

@property (nonatomic, retain) NSString *address;
@property(nonatomic, retain) NSArray *buildData;

@end
