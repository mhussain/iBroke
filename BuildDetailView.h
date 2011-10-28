//
//  Created by mike_rowe on 27/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BuildDetail;

@interface BuildDetailView : UIView

@property (nonatomic, retain, setter = setBuildData:) BuildDetail *buildDetail;

@end