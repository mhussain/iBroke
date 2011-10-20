//
//  NSArray+Blocks.m
//  iBroke
//
//  Created by Mujtaba Hussain on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Blocks.h"

@implementation NSArray (Blocks)

- (void)each:(void (^)(id))block;
{
  [self enumerateObjectsUsingBlock: ^(id item, uint i, BOOL *stop) { block(item); }];
}

- (void)eachWithIndex:(void (^)(id, int))block;
{
  [self enumerateObjectsUsingBlock: ^(id item, uint i, BOOL *stop) { block(item, i); }];
}


- (NSArray *)filter:(BOOL (^)(id))block;
{
  NSMutableArray *result = [NSMutableArray array];
  
  for (id obj in self)
  {
    if (!block(obj))
    {
      [result addObject:obj];
    }
  }
  
  return result;
}

- (NSArray *)pick:(BOOL (^)(id))block;
{
  NSMutableArray *result = [NSMutableArray array];
  
  for (id obj in self)
  {
    if (block(obj))
    {
      [result addObject:obj];
    }
  }
  
  return result;
}

- (id)first:(BOOL (^)(id))block;
{
	id result = nil;
  
  for (id obj in self)
  {
    if (block(obj))
    {
      result = obj;
      break;
    }
  }
  
  return result;
}

- (NSUInteger)indexOfFirst:(BOOL (^)(id item))block;
{
  return [self indexOfObjectPassingTest:^ BOOL (id item, NSUInteger idx, BOOL *stop) {
		if (block(item))
    {
      *stop = YES;
      return YES;
    }
    
    return NO;
  }];
}

- (id)last:(BOOL (^)(id))block;
{
	id result = nil;
  
  for (id obj in [self reverseObjectEnumerator])
  {
    if (block(obj))
    {
      result = obj;
      break;
    }
  }
  
  return result;
}

- (NSUInteger)indexOfLast:(BOOL (^)(id item))block;
{
  return [self indexOfObjectWithOptions:NSEnumerationReverse passingTest:^ BOOL (id item, NSUInteger idx, BOOL *stop) {
		if (block(item))
    {
      *stop = YES;
      return YES;
    }
    
    return NO;
  }];
}

- (NSArray *)map:(id<NSObject> (^)(id<NSObject> item))block;
{
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
  
  for (id obj in self)
  {
    [result addObject:block(obj)];
  }
  
  return [NSArray arrayWithArray:result];
}

- (id)reduce:(id (^)(id current, id item))block initial:(id)initial;
{
  id result = initial;
  
  for (id obj in self)
  {
    result = block(result, obj);
  }
  
  return result;
}

@end
