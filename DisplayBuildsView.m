//
//  DisplayBuildsView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.
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

#import "DisplayBuildsView.h"

@implementation DisplayBuildsView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
{
  if ((self = [super initWithFrame:frame style:style]))
  {
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setRowHeight:50.];
    [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]]];	
  }
  return self;
}

- (void)drawRect:(CGRect)rect;
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetAllowsAntialiasing(context, YES);
  CGContextSetLineWidth(context, 4.);
  
  CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextMoveToPoint(context, 10., 100.);
  CGContextAddLineToPoint(context, 10., 200.);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);

}

@end
