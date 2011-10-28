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
  if ((self = [super initWithFrame:frame])) {
    [self setBackgroundColor:[UIColor whiteColor]];
  }
  return self;
}


#pragma mark - UIView Lifecycle

- (void)drawRect:(CGRect)rect;
{
  UILabel *build_name = [[UILabel alloc] initWithFrame:CGRectMake(0., 10., CGRectGetMaxX(rect), 40.)];
  [build_name setTextAlignment:UITextAlignmentCenter];
  [build_name setFont:[UIFont boldSystemFontOfSize:22.]];
  [build_name setText:[build name]];
  [self addSubview:build_name];

  UILabel *build_status = [[UILabel alloc] initWithFrame:CGRectMake(0., 50., CGRectGetMaxX(rect), 40.)];
  [build_status setTextAlignment:UITextAlignmentCenter];
  [build_status setText:[NSString stringWithFormat:@"Status: %@", [build status]]];
  [self addSubview:build_status];
}

- (void)refresh;
{
}

@end