//
//  UINavigationBar+Utilities.m
//  iBroke
//
//  Created by Mujtaba Hussain on 30/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+Utilities.h"

//@implementation UINavigationBar (Utilities)
//
//- (void)drawRect:(CGRect)rect;
//{
//  UIImage *image = [UIImage imageNamed: @"navbar.png"];
//  [image drawInRect:rect];
//}

@implementation UINavigationBar (Utilities)

- (void)drawRect:(CGRect)rect;
{
  
  if([self isMemberOfClass: [UINavigationBar class]])
  {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIImage *image = [UIImage imageNamed:@"navbar.png"];
    CGContextClip(ctx);
    CGContextTranslateCTM(ctx, 0, image.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextDrawImage(ctx, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), image.CGImage);
  }
else{
    [super drawRect:rect];
}
  
}

@end