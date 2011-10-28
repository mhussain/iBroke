//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BuildDetail : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSString *committers;

+(id)instanceWithData:(NSDictionary *)data;

-(id)initWithName:(NSString *)name description:(NSString *)description committers:(NSString *)committers;

@end
