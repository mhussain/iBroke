//
//  AboutView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 28/10/11.

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

#import "AboutView.h"

#import "UIColor+Hex.h"
#import "UIView+Size.h"

@interface AboutView ()

@property (nonatomic, retain) UILabel *about;
@property (nonatomic, retain) UILabel *ack;
@property (nonatomic, retain) UILabel *dev;

@end

@implementation AboutView

@synthesize about = _about;
@synthesize ack = _ack;
@synthesize dev = _dev;

static NSString *text = @"'iBroke' was developed out of the need to always know when code I wrote broke a build, even if i was not near the build server. Who knows, this may help you too.";

static NSString *acknowledgements = @"I deeply appreciate the help Mike Rowe (@mrowe) and Yori gave me.";

static NSString *developer = @"Mujtaba Hussain\nhttp://ibroke.mujtabahussain.net";

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];
  if (self)
  {
    [self setFrame:frame];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];

    _about = [[UILabel alloc] initWithFrame:CGRectZero];
    [_about setNumberOfLines:0.];
    [_about setLineBreakMode:UILineBreakModeWordWrap];
    [_about setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_about setText:text];
    [_about setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [_about setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_about];

    _ack = [[UILabel alloc] initWithFrame:CGRectZero];
    [_ack setNumberOfLines:0.];
    [_ack setLineBreakMode:UILineBreakModeWordWrap];
    [_ack setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_ack setText:acknowledgements];
    [_ack setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [_ack setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_ack];

    _dev = [[UILabel alloc] initWithFrame:CGRectZero];
    [_dev setNumberOfLines:0.];
    [_dev setLineBreakMode:UILineBreakModeWordWrap];
    [_dev setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_dev setTextAlignment:UITextAlignmentCenter];
    [_dev setText:developer];
    [_dev setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [_dev setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_dev];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
  }
  return self;
}

- (void)layoutSubviews;
{
//  CGSize expectedSize =  [[[self about] text] sizeWithFont:[UIFont fontWithName:@"Futura Medium" size:40.] 
//                                         constrainedToSize:CGSizeMake(280., 1000.)
//                          								lineBreakMode:UILineBreakModeWordWrap];

  [[self about] setFrame:CGRectMake(20., 50., 280., 100.)];
  [[self ack] setFrame:CGRectMake(20., 180., 280., 100.)];
  [[self dev] setFrame:CGRectMake(20., 300., 280., 100.)];
  
}

- (void)drawRect:(CGRect)rect;
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextMoveToPoint(context, [self x_coord] + 10., [self y_coord] + 10.);
  
  CGContextAddLineToPoint(context, [self width] - 10., [self y_coord] + 10.);
  CGContextAddLineToPoint(context, [self width] - 10., [self height] - 10.);

  CGContextAddLineToPoint(context, [self x_coord] + 10., [self height] - 10.);
  CGContextAddLineToPoint(context, [self x_coord] + 10., [self y_coord] + 10.);
  
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetStrokeColorWithColor(context, [[UIColor colorWithHexString:@"539DC2"] CGColor]);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}


@end
