//
//  Created by mike_rowe on 27/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BuildDetailView.h"

@implementation BuildDetailView

- (id)initWithFrame:(CGRect)frame build:(Build *)build;
{
  if ((self = [super initWithFrame:frame])) {
    [self setBackgroundColor:[UIColor whiteColor]];

    UILabel *build_name = [[UILabel alloc] initWithFrame:CGRectMake(0., 10., CGRectGetMaxX(frame), 40.)];
    [build_name setTextAlignment:UITextAlignmentCenter];
    [build_name setFont:[UIFont boldSystemFontOfSize:22.]];
    [build_name setText:[build name]];
    [self addSubview:build_name];

    UILabel *build_status = [[UILabel alloc] initWithFrame:CGRectMake(0., 50., CGRectGetMaxX(frame), 40.)];
    [build_status setTextAlignment:UITextAlignmentCenter];
    [build_status setText:[NSString stringWithFormat:@"Status: %@", [build status]]];
    [self addSubview:build_status];
  }
  return self;
}

@end