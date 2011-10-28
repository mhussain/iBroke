//
//  Created by mike_rowe on 27/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BuildDetailView.h"
#import "BuildDetail.h"

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

@implementation BuildDetailView

@synthesize buildDetail = _buildDetail;

- (id)initWithFrame:(CGRect)frame;
{
  if ((self = [super initWithFrame:frame]))
  {
  }
  return self;
}

- (void)layoutSubviews;
{
  [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];

  BuildDetailLabel *build_name = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(0., 10., CGRectGetMaxX([self frame]), 40.) text:[[self buildDetail] name]];
  [build_name setFont:[UIFont boldSystemFontOfSize:22.]];
  [self addSubview:build_name];

  BuildDetailLabel *build_status = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(0., 50., CGRectGetMaxX([self frame]), 40.) text:[[self buildDetail] description]];
  [self addSubview:build_status];

  BuildDetailLabel *committers = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(0., 90., CGRectGetMaxX([self frame]), 40.) text:[[self buildDetail] committers]];
  [self addSubview:committers];

}

@end
