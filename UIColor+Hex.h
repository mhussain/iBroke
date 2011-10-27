//
//  UIColor+Hex.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)color;
+ (UIColor *)colorWithHex:(NSInteger)color alpha:(float)alpha;

+ (UIColor *)colorWithHexString:(NSString*)hexString;

@end
