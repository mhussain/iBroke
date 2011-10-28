//
//  Build.h
//  iBroke
//
//  Created by Mujtaba Hussain on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Build : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *status;

-(id)initWithName:(NSString *)name status:(NSString *)status url:(NSString *)url;

-(BOOL)isFailed;
-(BOOL)isBuilding;

@end
