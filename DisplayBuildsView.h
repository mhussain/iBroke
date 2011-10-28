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
@property (nonatomic, retain) UIImageView *imageView;

- (void)refresh;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end
