//
//  AboutView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 28/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
		[self setBackgroundColor:[UIColor greenColor]];
    [self layoutIfNeeded];
  }
  return self;
}

@end
