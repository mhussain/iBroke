//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BuildDetailController.h"
#import "Build.h"
#import "BuildDetailView.h"


@implementation BuildDetailController

@synthesize buildView = _buildView;

- (id)initWithBuild:(Build *)build;
{
  self = [super initWithNibName:nil bundle:nil];

  if (self)
  {
    [[self navigationItem] setHidesBackButton:NO animated:YES];
    [self setTitle:[build name]];

    _buildView = [[BuildDetailView alloc] initWithFrame:[[self view] frame] build:build];
    [self setView:_buildView];
  }
  return self;
}

@end