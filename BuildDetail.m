//
//  Created by mike_rowe on 28/10/11.
//
// This code is distributed under the terms and conditions of the MIT license. 
//
// Copyright (c) 2011 Mujtaba Hussain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
// IN THE SOFTWARE.


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