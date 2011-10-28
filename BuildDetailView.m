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

#pragma mark - BuildDetailLabel

@interface BuildDetailLabel : UILabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text;

@end

@implementation BuildDetailLabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text;
{
  self = [super initWithFrame:frame];
  
  if (self) 
  {
    [self setFrame:frame];
    [self setTextAlignment:UITextAlignmentCenter];
    [self setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setText:text];
  }
  return self;
}

@end

#pragma mark - BuildDetailView

@interface BuildDetailView ()

@property (nonatomic, retain) BuildDetailLabel *description;
@property (nonatomic, retain) BuildDetailLabel *healthReport;

@end

@implementation BuildDetailView

@synthesize description = _description;
@synthesize buildDetail = _buildDetail;
@synthesize healthReport = _healthReport;

- (id)initWithFrame:(CGRect)frame;
{
  if ((self = [super initWithFrame:frame]))
  {
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    UILabel *health_label = [[UILabel alloc] initWithFrame:CGRectMake(30., 10., 60., 30.)];
    [health_label setFont:[UIFont fontWithName:@"Futura-Medium" size:20.]];
    [health_label setText:@"Health"];
    [health_label setTextColor:[UIColor colorWithHexString:@"539DC2"]];
    [health_label setBackgroundColor:[UIColor clearColor]];
    [self addSubview:health_label];
  
    _description = [[BuildDetailLabel alloc] initWithFrame:CGRectZero];
    [_description setFont:[UIFont fontWithName:@"Futura-Medium" size:15.]];
    [_description setTextColor:[UIColor whiteColor]];
    [_description setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_description];
    
    _healthReport = [[BuildDetailLabel alloc] initWithFrame:CGRectZero];
    [_healthReport setFont:[UIFont fontWithName:@"Verdana" size:15.]];
    [_healthReport setTextColor:[UIColor whiteColor]];
    [_healthReport setBackgroundColor:[UIColor clearColor]];
    [_healthReport setLineBreakMode:UILineBreakModeWordWrap];
    [_healthReport setNumberOfLines:0.];
    [self addSubview:_healthReport];
  }

  return self;
}

- (void)setBuildData:(BuildDetail *)buildDetail;
{
  [[self description] setText:[buildDetail description]];
  [[self healthReport] setText:[buildDetail health]];
	
  [self layoutIfNeeded];
}

- (void)layoutSubviews;
{
  [[self healthReport] setFrame:CGRectMake(25., 40., 280., 60.)];
}

- (void)drawRect:(CGRect)rect;
{  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 1.);
  
  CGContextMoveToPoint(context, 100., 25.);
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextAddLineToPoint(context, 100., 25.);
  CGContextAddLineToPoint(context, 300., 25.);
  CGContextAddLineToPoint(context, 300., 110.);
  CGContextAddLineToPoint(context, 10., 110.);
  CGContextAddLineToPoint(context, 10., 25.);
  CGContextAddLineToPoint(context, 25., 25.);
  CGContextStrokePath(context);
  CGContextRestoreGState(context);
}

@end
