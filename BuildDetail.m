//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BuildDetail.h"
#import "NSArray+Blocks.h"


@implementation BuildDetail

@synthesize name = _name;
@synthesize description = _description;
@synthesize committers = _committers;


+(id)instanceWithData:(NSDictionary *)data;
{
  NSArray *culprits = [[data objectForKey:@"lastBuild"] objectForKey:@"culprits"];
  NSArray *committers = [culprits map:^id<NSObject>(id<NSObject> culprits) {
    return [(NSDictionary *)culprits objectForKey:@"fullName"];
  }];
  
  return [[BuildDetail alloc] initWithName:[data objectForKey:@"name"]
                               description:[data objectForKey:@"description"]
                                committers:[committers componentsJoinedByString:@", "]
  ];
}

-(id)initWithName:(NSString *)name description:(NSString *)description committers:(NSString *)committers;
{
  if ((self = [super init]))
  {
    [self setDescription:description];
    [self setName:name];
    [self setCommitters:committers];
  }
  return self;
}

@end