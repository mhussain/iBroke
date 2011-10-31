//
//  UINavigationBar+Utilities.m
//  iBroke
//
//  Created by Mujtaba Hussain on 30/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+Utilities.h"

#import "UIView+Size.h"

@implementation UINavigationBar (Utilities)

- (void)drawRect:(CGRect)rect;
{
  
  if([self isMemberOfClass: [UINavigationBar class]])
  {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIImage *image = [UIImage imageNamed:@"navbar.png"];
    
    CGContextClip(context);
    CGContextTranslateCTM(context, 0, [image size].height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, [self width], [self height]), [image CGImage]);
  }
  else
  {
    [super drawRect:rect];
  }
  
}

@end