//
//  NSArray+Blocks.h
//  iBroke
//
//  Created by Mujtaba Hussain on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Blocks)

- (void)each:(void (^)(id item))block;
- (void)eachWithIndex:(void (^)(id item, int index))block;

- (NSArray *)filter:(BOOL (^)(id item))block;
- (NSArray *)pick:(BOOL (^)(id item))block;

- (id)first:(BOOL (^)(id))block;
- (NSUInteger)indexOfFirst:(BOOL (^)(id item))block;

- (id)last:(BOOL (^)(id))block;
- (NSUInteger)indexOfLast:(BOOL (^)(id item))block;

- (NSArray *)map:(id<NSObject> (^)(id<NSObject> item))block;
- (id)reduce:(id (^)(id current, id item))block initial:(id)initial;

@end
