//
//  Created by mike_rowe on 27/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BuildDetailView.h"

@implementation BuildDetailView

@synthesize build;

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];

  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];
  }

  return self;
}


#pragma mark - UIView Lifecycle

- (void)layoutSubviews;
{
}

- (void)drawRect:(CGRect)rect;
{
  CGRect frame = CGRectMake(0., 10., CGRectGetMaxX(rect), 40.);
  UILabel *build_name = [[UILabel alloc] initWithFrame:frame];
  [build_name setTextAlignment:UITextAlignmentCenter];
  [build_name setFont:[UIFont boldSystemFontOfSize:22.]];
  [build_name setText:[build name]];
  [self addSubview:build_name];
}

- (void)refresh;
{
}

@end