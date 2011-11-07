//
//  LoadingView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 28/10/11.
//  Copyright Matt Gallagher 2009. All rights reserved.
// 
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.


#import <QuartzCore/QuartzCore.h>

#import "LoadingView.h"
#import "UIView+Size.h"
#import "UIColor+Hex.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame andMessage:(NSString *)message;
{
  self = [super initWithFrame:frame];
  
  if (self)
  {
    [self setTag:3];
    [self setBackgroundColor:[UIColor blackColor]];
    [self setAlpha:0.4];
    
    const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
    const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
    CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [loadingLabel setText:NSLocalizedString(message, nil)];
    [loadingLabel setTextColor:[UIColor colorWithHexString:@"FFE600"]];
    [loadingLabel setBackgroundColor:[UIColor clearColor]];
    [loadingLabel setTextAlignment:UITextAlignmentCenter];
    [loadingLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [self addSubview:loadingLabel];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]
                                                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    CGFloat totalHeight = [loadingLabel height] + [activityIndicatorView height];
    labelFrame.origin.x = floor(0.5 * ([self width] - DEFAULT_LABEL_WIDTH));
    labelFrame.origin.y = floor(0.5 * ([self height] - totalHeight));
    [loadingLabel setFrame:labelFrame];
    
    CGRect activityIndicatorRect = [activityIndicatorView frame];
    activityIndicatorRect.origin.x = 0.5 * ([self width] - activityIndicatorRect.size.width);
    activityIndicatorRect.origin.y = [loadingLabel y_coord] + [loadingLabel height];
    [activityIndicatorView setFrame:activityIndicatorRect];
    
    // Set up the fade-in animation
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];

  }
  return self;
}

@end
