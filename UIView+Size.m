//
//  UIView+Size.m
//  iBroke
//
//  Created by Mujtaba Hussain on 31/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)

- (CGFloat)height;
{
  return [self bounds].size.height;
}

- (CGFloat)width;
{
  return [self bounds].size.width;
}

-(CGFloat)x_coord;
{
  return [self frame].origin.x;
}

-(CGFloat)y_coord;
{
  return [self frame].origin.y;  
}

@end
