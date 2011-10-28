//
//  Created by mike_rowe on 27/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BuildDetailView.h"

#pragma mark - BuildDetailLabel

@interface BuildDetailLabel : UILabel
- (id)initWithFrame:(CGRect)frame text:(NSString *)text;
@end

@implementation BuildDetailLabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text;
{
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  [label setTextAlignment:UITextAlignmentCenter];
  [label setTextColor:[UIColor whiteColor]];
  [label setBackgroundColor:[UIColor clearColor]];
  [label setText:text];
  return label;
}

@end

#pragma mark - BuildDetailView

@implementation BuildDetailView

- (id)initWithFrame:(CGRect)frame build:(Build *)build;
{
  if ((self = [super initWithFrame:frame]))
  {
    UILabel *build_name = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(0., 10., CGRectGetMaxX(frame), 40.) text:[build name]];
    [build_name setFont:[UIFont boldSystemFontOfSize:22.]];
    [self addSubview:build_name];

    UILabel *build_status = [[BuildDetailLabel alloc] initWithFrame:CGRectMake(0., 50., CGRectGetMaxX(frame), 40.) text:[NSString stringWithFormat:@"Status: %@", [build status]]];
    [self addSubview:build_status];
    
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
  }
  return self;
}

@end
