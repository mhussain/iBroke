//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BuildDetail.h"


@implementation BuildDetail

@synthesize name = _name;
@synthesize description = _description;

+(id)instanceWithData:(NSDictionary *)data;
{
  return [[BuildDetail alloc] initWithName:[data objectForKey:@"name"]
                               description:[data objectForKey:@"description"]];
}

-(id)initWithName:(NSString *)name description:(NSString *)description;
{
  if ((self = [super init]))
  {
    [self setDescription:description];
    [self setName:name];
  }
  return self;
}

@end