//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class BuildDetailView;
@class Build;

@interface BuildDetailController : UIViewController

@property (nonatomic, retain) BuildDetailView *buildView;

- (id)initWithBuild:(Build *)build;

@end