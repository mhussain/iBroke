//
//  DisplayBuildsView.m
//  iBroke
//
//  Created by Mujtaba Hussain on 19/10/11.


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

@end
