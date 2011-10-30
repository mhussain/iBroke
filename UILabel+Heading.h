//
//  UILabel+Heading.h
//  iBroke
//
//  Created by Mujtaba Hussain on 29/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (Heading)

- (void)defineStyleWithTitle:(NSString *)title;

- (CGFloat)width;
- (CGFloat)height;

-(CGFloat)x_coord;
-(CGFloat)y_coord;

@end
