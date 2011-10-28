//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"

@class BuildDetailView;
@class Build;

@interface BuildDetailController : UIViewController <ASIHTTPRequestDelegate>

@property (nonatomic, retain) BuildDetailView *buildView;

- (id)initWithBuild:(Build *)build;

@end