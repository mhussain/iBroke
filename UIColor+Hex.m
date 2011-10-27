//
//  UIColor+Hex.m
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)color
{
  return [UIColor colorWithHex:color alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)color alpha:(float)alpha
{
  return [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16))/255.0
                         green:((float)((color & 0xFF00) >> 8))/255.0
                          blue:((float)(color & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString;
{
  if (nil == hexString) return nil;
  
  NSString *alphaString = nil;
  NSUInteger aValue = 0;
  
  if ([hexString length] == 10)
  {
    alphaString = [hexString substringWithRange:NSRangeFromString(@"2 2")];
    NSScanner *aScanner = [NSScanner scannerWithString:alphaString];
    
    BOOL parseSuccessful = [aScanner scanHexInt: &aValue];
    NSAssert(parseSuccessful, @"Invalid extended hex color alpha %@", alphaString);
    
    hexString = [NSString stringWithFormat:@"%@%@",[hexString substringWithRange:NSRangeFromString(@"0 2")],[hexString substringWithRange:NSRangeFromString(@"4 6")]];
  }
  
  NSScanner *pScanner = [NSScanner scannerWithString:hexString];
  
  NSUInteger iValue;
  BOOL parseSuccessful = [pScanner scanHexInt: &iValue];
  NSAssert(parseSuccessful, @"Invalid hex color %@", hexString);
  
  if (aValue > 0)
  {
    return [UIColor colorWithHex:iValue alpha:((float)aValue/255.0)];
  }
  
  return [UIColor colorWithHex:iValue];
}

@end
