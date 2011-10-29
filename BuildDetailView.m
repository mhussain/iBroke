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

@end

@implementation BuildDetailLabel

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
    [self setFrame:CGRectMake(0., 0., 320., 480.)];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    _healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(30., 10., 60., 30.)];
    [_healthLabel defineStyleWithTitle:@"Health"];
    [_healthLabel setHidden:YES];
    [self addSubview:_healthLabel];
    
    _changeSetLabel = [[UILabel alloc] initWithFrame:CGRectMake(30., 140., 150., 30.)];
    [_changeSetLabel defineStyleWithTitle:@"Comment"];
		[_changeSetLabel setHidden:YES];
    [self addSubview:_changeSetLabel];

    _culpritLabel = [[UILabel alloc] initWithFrame:CGRectMake(30., 230., 150., 30.)];
    [_culpritLabel defineStyleWithTitle:@"Culprits"];
		[_culpritLabel setHidden:YES];
    [self addSubview:_culpritLabel];

    _healthReport = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(25., 40., 280., 60.) andText:@""];
    [self addSubview:_healthReport];
    
    _changeset = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(20., 165., 280., 40.) andText:@""];
    [_changeset setFont:[UIFont fontWithName:@"Verdana" size:12.]];
    [self addSubview:_changeset];
    
    _culprit = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(20., 257., 280., 40.) andText:@""];
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
  [[self healthReport] sizeToFit];
  [[self changeset] setText: [[buildDetail description] isEmpty] ? [self placeholder] : [buildDetail description]];
  [[self changeset] sizeToFit];
  [[self culprit] setText: [[buildDetail culprits] isEmpty] ? [self placeholder] : [buildDetail culprits]];
  [[self culprit] sizeToFit];
	
  CGFloat height = [_healthReport height] + [_changeset height] + [_culprit height] + 200.;
  [self setContentSize:CGSizeMake([self bounds].size.width, height)];
	[self setNeedsDisplay];  
}

- (void)layoutSubviews;
{
  
}

#pragma mark - UIView Lifecycle

- (void)drawRect:(CGRect)rect;
{  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 1.);
  
  NSString *healthReportText = [[self healthReport] text];
  if ([healthReportText isNotEmpty])
  {
    [[self healthLabel] setHidden:NO];

    CGFloat vertical_padding = 20.;
    CGFloat text_height = [[self healthReport] bounds].size.height + vertical_padding;

    // Draw box around health report.
    CGContextMoveToPoint(context, 100., 25.);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddLineToPoint(context, 100., 25.);
    CGContextAddLineToPoint(context, 300., 25.);
    CGContextAddLineToPoint(context, 300., 25. + text_height);
    CGContextAddLineToPoint(context, 10., 25. + text_height);
    CGContextAddLineToPoint(context, 10., 25.);
    CGContextAddLineToPoint(context, 25., 25.);
    CGContextStrokePath(context);
  }

  NSString *changeSetText = [[self changeset] text];
	if ([changeSetText isNotEmpty])
  {
    CGFloat vertical_padding = 15.;
    CGFloat text_height = [[self changeset] bounds].size.height + vertical_padding;

    [[self changeSetLabel] setHidden:NO];

    // Draw box around Change set.
    CGContextMoveToPoint(context, 130., 155.);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddLineToPoint(context, 130.	, 155.);
    CGContextAddLineToPoint(context, 300., 155.);
    CGContextAddLineToPoint(context, 300., 155. + text_height);
    CGContextAddLineToPoint(context, 10., 155. + text_height);
    CGContextAddLineToPoint(context, 10., 155.);
    CGContextAddLineToPoint(context, 25., 155.);
    CGContextStrokePath(context);
  }

  NSString *culpritText = [[self culprit] text];
	if ([culpritText isNotEmpty])
  {
    CGFloat vertical_padding = 15.;
    CGFloat text_height = [[self culprit] bounds].size.height + vertical_padding;
    
    [[self culpritLabel] setHidden:NO];
    
    // Draw box around Culprits.
    CGContextMoveToPoint(context, 120., 245.);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddLineToPoint(context, 120., 245.);
    CGContextAddLineToPoint(context, 300., 245.);
    CGContextAddLineToPoint(context, 300., 245. + text_height);
    CGContextAddLineToPoint(context, 10., 245. + text_height);
    CGContextAddLineToPoint(context, 10., 245.);
    CGContextAddLineToPoint(context, 25., 245.);
    CGContextStrokePath(context);
  }

  
  CGContextRestoreGState(context);
}

@end
