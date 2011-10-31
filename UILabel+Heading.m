//
//  UILabel+Heading.m
//  iBroke
//
//  Created by Mujtaba Hussain on 29/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Heading.h"
#import "UIColor+Hex.h"

@implementation UILabel (Heading)

- (void)defineStyleWithTitle:(NSString *)title
{
  [self setBackgroundColor:[UIColor clearColor]];
  [self setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
  [self setTextColor:[UIColor colorWithHexString:@"539DC2"]];
  [self setText:title];
}

@end
