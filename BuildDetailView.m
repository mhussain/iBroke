//
//  Created by mike_rowe on 27/10/11.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BuildDetailView.h"
#import "BuildDetail.h"

#import "NSArray+Blocks.h"
#import "UIColor+Hex.h"
#import "UILabel+Heading.h"
#import "NSString+Empty.h"

#pragma mark - BuildDetailLabel

@interface BuildDetailLabel : UILabel

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text;
- (CGSize)actualSize;

@end

@implementation BuildDetailLabel

const CGFloat kPaddingBetweenLabels = 50.;

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text;
{
  self = [super initWithFrame:frame];
  
  if (self) 
  {
    [self setFrame:frame];
    [self setTextAlignment:UITextAlignmentCenter];
    [self setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setNumberOfLines:0.];
    [self setLineBreakMode:UILineBreakModeWordWrap];
    [self setTextAlignment:UITextAlignmentLeft];
    [self setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [self setText:text];
  }
  return self;
}

- (CGSize)actualSize;
{
  return [[self text] sizeWithFont:[UIFont fontWithName:@"Verdana" size:15.] 
                          constrainedToSize:CGSizeMake(280., 1000.)	
                     lineBreakMode:UILineBreakModeWordWrap];
}

@end

#pragma mark - BuildDetailView

@interface BuildDetailView ()

@property (nonatomic, retain) BuildDetailLabel *healthReport;
@property (nonatomic, retain) BuildDetailLabel *changeset;
@property (nonatomic, retain) BuildDetailLabel *culprit;

@property (nonatomic, retain) UILabel *healthLabel;
@property (nonatomic, retain) UILabel *changeSetLabel;
@property (nonatomic, retain) UILabel *culpritLabel;

- (NSString *)placeholder;

@end

@implementation BuildDetailView

@synthesize buildDetail = _buildDetail;

@synthesize healthReport = _healthReport;
@synthesize changeset = _changeset;
@synthesize culprit = _culprit;

@synthesize healthLabel = _healthLabel;
@synthesize changeSetLabel = _changeSetLabel;
@synthesize culpritLabel = _culpritLabel;

- (id)initWithFrame:(CGRect)frame;
{
  if ((self = [super initWithFrame:frame]))
  {
    [self setFrame:frame];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    _healthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_healthLabel defineStyleWithTitle:@"Health"];
    [_healthLabel setHidden:YES];
    [self addSubview:_healthLabel];
    
    _healthReport = [[BuildDetailLabel alloc] initWithFrame:CGRectZero andText:@""];
    [self addSubview:_healthReport];
    
    _changeSetLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_changeSetLabel defineStyleWithTitle:@"Comment"];
		[_changeSetLabel setHidden:YES];
    [self addSubview:_changeSetLabel];
    
    _changeset = [[BuildDetailLabel alloc] initWithFrame:CGRectZero andText:@""];
    [self addSubview:_changeset];

    _culpritLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_culpritLabel defineStyleWithTitle:@"Culprits"];
		[_culpritLabel setHidden:YES];
    [self addSubview:_culpritLabel];

    _culprit = [[BuildDetailLabel alloc] initWithFrame:CGRectZero andText:@""];    
    [self addSubview:_culprit];
  }

  return self;
}

- (NSString *)placeholder;
{
  return @"No information available";
}

- (void)setBuildData:(BuildDetail *)buildDetail;
{
  [[self healthReport] setText: [[buildDetail health] isEmpty] ? [self placeholder] : [buildDetail health]];
  [[self changeset] setText: [[buildDetail description] isEmpty] ? [self placeholder] : [buildDetail description]];
  [[self culprit] setText: [[buildDetail culprits] isEmpty] ? [self placeholder] : [buildDetail culprits]];
  
  [self setNeedsLayout];
	[self setNeedsDisplay];  
}

- (void)layoutSubviews;
{
  [_healthLabel setFrame:CGRectMake(30., 10., 60., 30.)];
  CGSize healthReportSize = [_healthReport actualSize];
  [_healthReport setFrame:CGRectMake(20., [_healthLabel y_coord] + 30., healthReportSize.width, healthReportSize.height)];
  
  [_changeSetLabel setFrame:CGRectMake(30., [_healthLabel y_coord] + [[self healthReport] height] + kPaddingBetweenLabels, 150., 30.)];
  CGSize changesetSize = [_changeset actualSize];
  [_changeset setFrame:CGRectMake(20., [_changeSetLabel y_coord] + 30., changesetSize.width, changesetSize.height)];

  [_culpritLabel setFrame:CGRectMake(30., [_changeSetLabel y_coord] + [[self changeset] height] + kPaddingBetweenLabels, 150., 30.)];
  CGSize culpritSize = [_culprit actualSize];
  [_culprit setFrame:CGRectMake(20., [_culpritLabel y_coord] + 30., culpritSize.width, culpritSize.height)];
  
  CGFloat height = [_healthReport height] + [_changeset height] + [_culprit height] + 200.;
  [self setContentSize:CGSizeMake([self bounds].size.width, height)];
}

#pragma mark - UIView Lifecycle

- (void)drawRect:(CGRect)rect;
{  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 1.);
  
  CGFloat vertical_padding = 20.;
  
  NSString *healthReportText = [[self healthReport] text];
  if ([healthReportText isNotEmpty])
  {
    [[self healthLabel] setHidden:NO];

    CGFloat text_height = [[self healthReport] height] + vertical_padding;
    CGFloat y_start = [[self healthLabel] y_coord]  + [[self healthLabel] height] - 15.;

    // Draw box around health report.
    CGContextMoveToPoint(context, 100., y_start);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddLineToPoint(context, 100., y_start);
    CGContextAddLineToPoint(context, 300., y_start);
    CGContextAddLineToPoint(context, 300., y_start + text_height);
    CGContextAddLineToPoint(context, 10., y_start + text_height);
    CGContextAddLineToPoint(context, 10., y_start);
    CGContextAddLineToPoint(context, 25., y_start);
    CGContextStrokePath(context);
  }

  NSString *changeSetText = [[self changeset] text];
	if ([changeSetText isNotEmpty])
  {
    CGFloat text_height = [[self changeset] height] + vertical_padding;
    CGFloat y_start = [[self changeSetLabel] y_coord]  + [[self changeSetLabel] height] - 15.;
    
    [[self changeSetLabel] setHidden:NO];

    // Draw box around Change set.
    CGContextMoveToPoint(context, 130., y_start);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddLineToPoint(context, 130.	, y_start);
    CGContextAddLineToPoint(context, 300., y_start);
    CGContextAddLineToPoint(context, 300., y_start + text_height);
    CGContextAddLineToPoint(context, 10., y_start + text_height);
    CGContextAddLineToPoint(context, 10., y_start);
    CGContextAddLineToPoint(context, 25., y_start);
    CGContextStrokePath(context);
  }

  NSString *culpritText = [[self culprit] text];
	if ([culpritText isNotEmpty])
  {
    CGFloat text_height = [[self culprit] height] + vertical_padding;
    CGFloat y_start = [[self culpritLabel] y_coord]  + [[self culpritLabel] height] - 15.;
    
    [[self culpritLabel] setHidden:NO];
    
    // Draw box around Culprits.
    CGContextMoveToPoint(context, 120., y_start);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddLineToPoint(context, 120., y_start);
    CGContextAddLineToPoint(context, 300., y_start);
    CGContextAddLineToPoint(context, 300., y_start + text_height);
    CGContextAddLineToPoint(context, 10., y_start + text_height);
    CGContextAddLineToPoint(context, 10., y_start);
    CGContextAddLineToPoint(context, 25., y_start);
    CGContextStrokePath(context);
  }

  
  CGContextRestoreGState(context);
}

@end
