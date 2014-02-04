//
//  NotificationView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 1/11/11.

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

#import "NotificationView.h"

#import "UIView+Size.h"

@interface NotificationView ()

@property (nonatomic, retain) UILabel *messageLabel;

@end

@implementation NotificationView

@synthesize messageLabel = _messageLabel;

- (id)initWithFrame:(CGRect)frame andMessage:(NSString *)message andType:(NotificationType)type;
{
  self = [super initWithFrame:frame];
  if (self)
  {
    if (type == kErrorNotification)
	    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Error"]]];
    else if (type == kSuccessNotification)
      [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Success"]]];

    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_messageLabel setBackgroundColor:[UIColor clearColor]];
    [_messageLabel setTextColor:[UIColor whiteColor]];
    [_messageLabel setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_messageLabel setText:message];

    [self addSubview:_messageLabel];
  }
  return self;
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
  [self setFrame:CGRectMake(0., 0., 320., 50.)];

  CGSize expectedSize = [[[self messageLabel] text] sizeWithFont:[UIFont fontWithName:@"Verdana" size:15.]
                                               constrainedToSize:[self bounds].size];

  [[self messageLabel] setFrame:CGRectMake(([self width] - expectedSize.width)/2, ([self height] - expectedSize.height)/2, expectedSize.width, expectedSize.height)];
}

@end
