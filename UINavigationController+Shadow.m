//
//  UINavigationController+Shadow.m
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

#import "UINavigationController+Shadow.h"

#import "UIView+Size.h"

@implementation UINavigationController (Shadow)

- (void)viewWillAppear:(BOOL)animated
{
  CGColorRef darkColor = [[[UIColor blackColor] colorWithAlphaComponent:.6f] CGColor];
  CGColorRef lightColor = [[UIColor clearColor] CGColor];
  CGFloat navigationBarBottom = [[self navigationBar] y_coord] + [[self navigationBar] height];
  
  CAGradientLayer *newShadow = [[[CAGradientLayer alloc] init] autorelease];
  
  newShadow.frame = CGRectMake(0. ,navigationBarBottom, [[self view] width], 10.);
  newShadow.colors = [NSArray arrayWithObjects:(id)darkColor, (id)lightColor, nil];
  
  [[[self view] layer] addSublayer:newShadow];
  [super viewWillAppear:animated];
}

@end
