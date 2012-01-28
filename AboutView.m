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
@property (nonatomic, retain) UILabel *resources;

@end

@implementation AboutView

@synthesize about = _about;
@synthesize ack = _ack;
@synthesize dev = _dev;
@synthesize resources = _resources;

static NSString *text = @"iBroke allows you to keep track of your builds wherever you are. You can find out the last commit, the culprit and the health of your builds.";

static NSString *acknowledgements = @"Mike Rowe (@mrowe)\nYori Mihalakopoulos (@yori)\nMatt Galaghar (cocoawithlove)\nKevin O'Neill (@kevinoneill)";

static NSString *developer = @"From: Khalida Apps";

static NSString *res = @"json-framework (Stig Brautaset)\nASIHTTPRequest (Ben Copsey)";

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
    [_about setFont:[UIFont fontWithName:@"Futura-Medium" size:15.]];
    [_about setText:text];
    [_about setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [_about setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_about];

    _ack = [[UILabel alloc] initWithFrame:CGRectZero];
    [_ack setNumberOfLines:0.];
    [_ack setLineBreakMode:UILineBreakModeWordWrap];
    [_ack setFont:[UIFont fontWithName:@"Futura-Medium" size:15.]];
    [_ack setText:acknowledgements];
    [_ack setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [_ack setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_ack];

    _dev = [[UILabel alloc] initWithFrame:CGRectZero];
    [_dev setNumberOfLines:0.];
    [_dev setLineBreakMode:UILineBreakModeWordWrap];
    [_dev setFont:[UIFont fontWithName:@"Futura-Medium" size:18.]];
    [_dev setTextAlignment:UITextAlignmentCenter];
    [_dev setText:developer];
    [_dev setTextColor:[UIColor colorWithHexString:@"76EE00"]];
    [_dev setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_dev];

    UILabel *people = [[UILabel alloc] initWithFrame:CGRectMake(20., 140., 150., 45.)];
    [people setNumberOfLines:0.];
    [people setLineBreakMode:UILineBreakModeWordWrap];
    [people setFont:[UIFont fontWithName:@"Futura-Medium" size:15.]];
    [people setText:@"Acknowledgments"];
    [people setTextColor:[UIColor colorWithHexString:@"76EE00"]];
    [people setBackgroundColor:[UIColor clearColor]];
    [self addSubview:people];

    UILabel *frameworks = [[UILabel alloc] initWithFrame:CGRectMake(20., 280., 150., 45.)];
    [frameworks setNumberOfLines:0.];
    [frameworks setLineBreakMode:UILineBreakModeWordWrap];
    [frameworks setFont:[UIFont fontWithName:@"Futura-Medium" size:15.]];
    [frameworks setText:@"Resources"];
    [frameworks setTextColor:[UIColor colorWithHexString:@"76EE00"]];
    [frameworks setBackgroundColor:[UIColor clearColor]];
    [self addSubview:frameworks];

    _resources =  [[UILabel alloc] initWithFrame:CGRectZero];
    [_resources setNumberOfLines:0.];
    [_resources setLineBreakMode:UILineBreakModeWordWrap];
    [_resources setFont:[UIFont fontWithName:@"Futura-Medium" size:15.]];
    [_resources setText:res];
    [_resources setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [_resources setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_resources];


    [self setNeedsLayout];
    [self setNeedsDisplay];
  }
  return self;
}

- (void)layoutSubviews;
{
  [[self dev] setFrame:CGRectMake(25., 10., 200., 20.)];

  [[self about] setFrame:CGRectMake(20., 40., 280., 100.)];
  [[self ack] setFrame:CGRectMake(20., 170., 280., 100.)];

  [[self resources] setFrame:CGRectMake(20., 290., 280., 100.)];
}

- (void)drawRect:(CGRect)rect;
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);

  CGContextMoveToPoint(context, [self x_coord] + 210., [self y_coord] + 20.);

  CGContextAddLineToPoint(context, [self width] - 10., [self y_coord] + 20.);
  CGContextAddLineToPoint(context, [self width] - 10., [self height] - 20.);

  CGContextAddLineToPoint(context, [self x_coord] + 10., [self height] - 20.);
  CGContextAddLineToPoint(context, [self x_coord] + 10., [self y_coord] + 20.);
  CGContextAddLineToPoint(context, [self x_coord] + 35., [self y_coord] + 20.);

  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetStrokeColorWithColor(context, [[UIColor colorWithHexString:@"539DC2"] CGColor]);
  CGContextStrokePath(context);

  CGContextRestoreGState(context);
}


@end
