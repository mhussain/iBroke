//
//  ConnectionFailedView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 31/10/11.
// This code is distributed under the terms and conditions of the MIT license. 
//
// Copyright (c) 2011 Mujtaba Hussain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
// IN THE SOFTWARE.


#import <QuartzCore/QuartzCore.h>

#import "ConnectionFailedView.h"

#import "UIColor+Hex.h"
#import "UIView+Size.h"

@implementation ConnectionFailedView

- (id)initWithFrame:(CGRect)frame withMessage:(NSString *)message;
{
  self = [super initWithFrame:frame];
  if (self)
  {
    [self setFrame:frame];
    [self setBackgroundColor:[UIColor blackColor]];
    [self setAlpha:0.4];
    
    const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
    const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
    CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [loadingLabel setText:NSLocalizedString(message, nil)];
    [loadingLabel setTextColor:[UIColor colorWithHexString:@"76EE00"]];
    [loadingLabel setBackgroundColor:[UIColor clearColor]];
    [loadingLabel setTextAlignment:UITextAlignmentCenter];
    [loadingLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [self addSubview:loadingLabel];
    
    CGFloat totalHeight = [loadingLabel height];
    labelFrame.origin.x = floor(0.5 * ([self width] - DEFAULT_LABEL_WIDTH));
    labelFrame.origin.y = floor(0.5 * ([self height] - totalHeight));
    [loadingLabel setFrame:labelFrame];

    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];

  }
  return self;
}

@end
