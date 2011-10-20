//
//  DisplayBuildsView.h
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayBuildsView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *buildData;
- (void)refresh;

@end
