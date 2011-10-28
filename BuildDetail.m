//
//  Created by mike_rowe on 28/10/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BuildDetail.h"

#import "NSArray+Blocks.h"

@implementation BuildDetail

@synthesize name = _name;
@synthesize description = _description;
@synthesize health = _health;

+ (id)instanceWithData:(NSDictionary *)data;
{
  return [[BuildDetail alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data;
{
  if ((self = [super init]))
  {
    [self setDescription:[data objectForKey:@"description"]];
    [self setName:[data objectForKey:@"name"]];
    [self setHealth:@""];

    NSArray *health = [data objectForKey:@"healthReport"];
    [health each:^(id item) {
      [self setHealth:[[self health] stringByAppendingFormat:@"%@ ", [item objectForKey:@"description"]]];
    }];
  }
  
  return self;
}

@end